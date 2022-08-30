//
//  InfoViewModel.swift
//  Industrial
//
//  Created by DmitriiG on 30.08.2022.
//

import Foundation

final class InfoViewModel {
    
    enum InterFaceEvents {
        case buttonPresentAlertViewTapped
    }
    
    enum State {
        case goToAlertView
    }
    
    var processInterfaceEvents: ((State) -> Void)?
    
    private(set) var state: State = .goToAlertView{
        didSet{
            processInterfaceEvents?(state)
        }
    }
    
    func changeState(interFaceEvent: InterFaceEvents, controller: InfoViewController) {
        switch interFaceEvent {
        case .buttonPresentAlertViewTapped:
            state = .goToAlertView
        }
    }
    
}
