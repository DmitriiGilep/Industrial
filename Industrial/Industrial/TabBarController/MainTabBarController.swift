//
//  MainTabBarController.swift
//  Industrial
//
//  Created by DmitriiG on 25.08.2022.
//

import UIKit

final class MainTabBarController: UITabBarController {
    
    
    private let firstNavController = NavControllerFactory(navControllerName: .first)
    private let secondNavController = NavControllerFactory(navControllerName: .second)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setControllers()
        
    }
    
    private func setControllers() {
        viewControllers = [
            firstNavController.navController,
            secondNavController.navController
        ]
    }
}
