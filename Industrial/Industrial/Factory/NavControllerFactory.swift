//
//  NavControllerFactory.swift
//  Industrial
//
//  Created by DmitriiG on 25.08.2022.
//

import Foundation
import UIKit
import PhotosUI

final class NavControllerFactory {
    
    enum NavControllerName {
        case first
        case second
        case third
    }
    
    var navController = UINavigationController()
    private let navControllerName: NavControllerName
    
    init(navControllerName: NavControllerName) {
        self.navControllerName = navControllerName
        createNavController()
    }
    
    func createNavController() {
        switch navControllerName {
        case .first:
            let feedCoordinator = FeedCoordinator()
            let feedViewModel = FeedViewModel()
            let feedViewController = FeedViewController(coordinator: feedCoordinator, model: feedViewModel)
            feedCoordinator.navController = navController
            navController.setViewControllers([feedViewController], animated: true)
            
            let tabBar1 = UITabBarItem()
            tabBar1.title = "Лента"
            tabBar1.image = UIImage(systemName: "person.3.sequence.fill")
            navController.tabBarItem = tabBar1
            
        case .second:
            
            let profileCoordinator = ProfileCoordinator()
            let loginViewController = LogInViewController(coordinator: profileCoordinator)
            let myLoginFactory = MyLoginFactory()
            loginViewController.delegate = myLoginFactory.loginInspector()
            
            profileCoordinator.navController = navController
            navController.setViewControllers([loginViewController], animated: true)
            navController.navigationBar.isHidden = true
            
            let tabBar2 = UITabBarItem()
            tabBar2.title = "Профиль"
            tabBar2.image = UIImage(systemName: "person.fill")
            navController.tabBarItem = tabBar2
            
        case .third:
            let fileManagerTableViewController = FileManagerTableViewController(style: .plain)
            navController.navigationBar.barStyle = .black
            navController.setViewControllers([fileManagerTableViewController], animated: true)
            navController.tabBarItem = UITabBarItem(title: "FileManager", image: UIImage(systemName: "photo"), selectedImage: nil)
            
        }
    }
    
}
