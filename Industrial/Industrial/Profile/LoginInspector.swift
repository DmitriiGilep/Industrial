//
//  LoginInspector.swift
//  Industrial
//
//  Created by DmitriiG on 13.08.2022.
//

import UIKit

//MARK: - новый класс, подписанный на протокол LoginViewControllerDelegate

final class LoginInspector: LoginViewControllerDelegate {
    
    func checkCredentials(login: String, password: String, controller: LogInViewController, coordinator: ProfileCoordinator) {
        let checkerService = CheckerService()
        checkerService.checkCredentials(login: login, password: password, controller: controller, coordinator: coordinator)
    }
    
    func signUp(login: String, password: String, controller: LogInViewController, coordinator: ProfileCoordinator) {
        let checkerService = CheckerService()
        checkerService.signUp(login: login, password: password, controller: controller, coordinator: coordinator)
    }
    
}
