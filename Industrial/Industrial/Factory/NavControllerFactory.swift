//
//  NavControllerFactory.swift
//  Industrial
//
//  Created by DmitriiG on 25.08.2022.
//

import Foundation
import UIKit

final class NavControllerFactory {
    
    enum NavControllerName {
        case first
        case second
    }
    
    var navController = UINavigationController()
    let navControllerName: NavControllerName
    
    init(navControllerName: NavControllerName) {
        self.navControllerName = navControllerName
        createNavController()
    }
    
    func createNavController() {
        switch navControllerName {
        case .first:
            
            let feedViewController = FeedViewController()
            let firstNavController = UINavigationController(rootViewController: feedViewController)
            firstNavController.setViewControllers([feedViewController], animated: true)
            
            let tabBar1 = UITabBarItem()
            tabBar1.title = "Лента"
            tabBar1.image = UIImage(systemName: "person.3.sequence.fill")
            firstNavController.tabBarItem = tabBar1
            navController = firstNavController
            
        case .second:
            
            let loginViewController = LogInViewController()
            let myLoginFactory = MyLoginFactory()
            loginViewController.delegate = myLoginFactory.loginInspector()
            
            let secondNavContoller = UINavigationController(rootViewController: loginViewController)
            secondNavContoller.setViewControllers([loginViewController], animated: true)
            secondNavContoller.navigationBar.isHidden = true
            
            let tabBar2 = UITabBarItem()
            tabBar2.title = "Профиль"
            tabBar2.image = UIImage(systemName: "person.fill")
            secondNavContoller.tabBarItem = tabBar2
            navController = secondNavContoller
        }
    }
    
}
