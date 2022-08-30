//
//  InfoViewController.swift
//  Navigation
//
//  Created by DmitriiG on 19.02.2022.
//

import UIKit

final class InfoViewController: UIViewController {
    
    private let coordinator: FeedCoordinator
    private let infoViewModel: InfoViewModel
    
    
    init(coordinator: FeedCoordinator, model: InfoViewModel) {
        self.coordinator = coordinator
        self.infoViewModel = model
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //создал кнопку, назначил ей вывод AlertView
    // переинициализировал кнопку при помощи CustomButton
    private lazy var button = CustomButton(
        title: (name: "Alert", state: .normal),
        titleColor: (color: nil, state: nil),
        backgroundColor: .magenta,
        backgroundImage: (image: nil, state: nil),
        action:  {
            self.infoViewModel.changeState(interFaceEvent: .buttonPresentAlertViewTapped, controller: self)
        })
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // поменял фон и имя
        title = "Info"
        view.backgroundColor = .cyan
        view.addSubview(button)
        bindViewModel()
    }
    
    override func viewDidLayoutSubviews() {
        button.frame = CGRect(x: view.center.x, y: view.center.y, width: 130, height: 50)
    }
    
    private func bindViewModel() {
        infoViewModel.processInterfaceEvents = {
            [weak self] state in
            switch state {
            case .goToAlertView:
                self?.coordinator.alertView(infoViewController: self!)
            }
        }
    }
    
}
