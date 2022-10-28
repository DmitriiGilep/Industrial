//
//  LoginInspector.swift
//  Industrial
//
//  Created by DmitriiG on 13.08.2022.
//

import UIKit

//MARK: - новый класс, подписанный на протокол LoginViewControllerDelegate

final class LoginInspector: LoginViewControllerDelegate {
    
    let checkerService = CheckerService() // переменная должна быть вне completion, то есть нужно держать ссылку на CheckerService, если создаешь внутри, то ссылка не держится, когда асинхронно вызывается комплишн, этого сервиса уже нет, его никто не держит.

    func checkCredentials(login: String, password: String, controller: LogInViewController, coordinator: ProfileCoordinator) {
        checkerService.checkCredentials(login: login, password: password, controller: controller, coordinator: coordinator)
    }
    
    func signUp(login: String, password: String, controller: LogInViewController, coordinator: ProfileCoordinator) {
        checkerService.signUp(login: login, password: password, controller: controller, coordinator: coordinator)
    }
    
}
