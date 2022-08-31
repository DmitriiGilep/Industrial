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
    
    func profileViewController(coordinator: ProfileCoordinator) {
        let coordinator = ProfileCoordinator()
        let loginViewController = LogInViewController(coordinator: coordinator)
#if DEBUG
        let userService = TestUserService()
#else
        let userService = CurrentUserService()
#endif
        let profileViewController = ProfileViewController(userService: userService, userName: loginViewController.nameTextField.text ?? "", coordinator: coordinator)
        
        navController?.pushViewController(profileViewController, animated: true)
        
    }
    
    func photosViewController(profileViewController: ProfileViewController) {
        let photosViewController = PhotosViewController()
        profileViewController.navigationController?.pushViewController(photosViewController, animated: true)
    }
    
    
}
