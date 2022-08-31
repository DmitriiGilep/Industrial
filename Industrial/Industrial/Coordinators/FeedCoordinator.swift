//
//  FeedCoordinator.swift
//  Industrial
//
//  Created by DmitriiG on 25.08.2022.
//

import Foundation
import UIKit

final class FeedCoordinator {
    
    var navController: UINavigationController?
    
    func postViewController() {
        let coordinator = FeedCoordinator()
        let model = PostViewModel()
        let postViewController = PostViewController(coordinator: coordinator, model: model)
        navController?.pushViewController(postViewController, animated: true)
    }
    
    func infoViewController(postViewController: PostViewController) {
        let coordinator = FeedCoordinator()
        let model = InfoViewModel()
        let infoViewController = InfoViewController(coordinator: coordinator, model: model)
        postViewController.present(infoViewController, animated: true, completion: nil)
    }
    
    func alertView(infoViewController: InfoViewController) {
        let alertView = UIAlertController(title: "Alert", message: "Don't press this button", preferredStyle: .alert)
        let accepted = UIAlertAction(title: "Accepted", style: .default, handler: {(Accepted) in print("well done")})
        let notAccepted = UIAlertAction(title: "Did't accepted", style: .cancel, handler: {(notAccepted) in print("well done")})
        alertView.addAction(accepted)
        alertView.addAction(notAccepted)
        
        // модальный вывод
        infoViewController.present(alertView, animated: true, completion: nil)
    }
    
    
    
}
