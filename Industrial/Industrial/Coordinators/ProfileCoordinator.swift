//
//  ProfileCoordinator.swift
//  Industrial
//
//  Created by DmitriiG on 25.08.2022.
//

import Foundation
import UIKit

final class ProfileCoordinator {
    
    var navController: UINavigationController?
    
    func profileViewController(coordinator: ProfileCoordinator, controller: LogInViewController, navControllerFromFactory: UINavigationController?) {
 #if DEBUG
        let userService = TestUserService()
#else
        let userService = CurrentUserService()
#endif
        let profileViewController = ProfileViewController(userService: userService, userName: LoginRealmModel.shared.status.login ?? "Не определен", coordinator: coordinator, controller: controller)
//        if let navFromFactory = navControllerFromFactory {
//            navFromFactory.pushViewController(profileViewController, animated: true)
//        } else {
            navController?.pushViewController(profileViewController, animated: true)
 //       }
        
    }
    
    func photosViewController(profileViewController: ProfileViewController) {
        let photosViewController = PhotosViewController()
        photosViewController.navigationController?.isNavigationBarHidden = false
        profileViewController.navigationController?.pushViewController(photosViewController, animated: true)
    }
    
    func favoritesTableViewController() {
        let favoritesTableViewController = FavoritesTableViewController()
        navController?.navigationBar.isHidden = false
        navController?.pushViewController(favoritesTableViewController, animated: true)
    }
    
    
}
