//
//  FeedViewModel.swift
//  Industrial
//
//  Created by DmitriiG on 27.08.2022.
//

import Foundation


final class FeedViewModel {
    
    enum InterfaceEvents{
        case checkGuessButtonPressed
        case buttonGoToPostViewControllerPressed
    }
    
    enum State {
        case resultGuessCheckTrue
        case resultGuessCheckFalse
        case goToPostViewController
    }
    
    var processInterfaceEvents: ((State) -> Void)?
    
    private(set) var state: State = .resultGuessCheckFalse {
        didSet {
            processInterfaceEvents?(state)
        }
    }
    
    
    func changeState(interfaceEvent: InterfaceEvents, controller: FeedViewController){
        switch interfaceEvent {
        case .checkGuessButtonPressed:
            let feedModel = FeedModel(passwordForCheck: controller.guessTextField.text!)
            
            switch feedModel.check() {
            case true:
                state = .resultGuessCheckTrue
            case false:
                state = .resultGuessCheckFalse
            }
        case .buttonGoToPostViewControllerPressed:
            state = .goToPostViewController
            
            
        }
    }
    
}
