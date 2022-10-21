//
//  CheckerService.swift
//  Industrial
//
//  Created by DmitriiG on 19.10.2022.
//

import Foundation
import UIKit
import FirebaseAuth


final class CheckerService: CheckerServiceProtocol {
    
    func signUp(login: String, password: String, controller: LogInViewController, coordinator: ProfileCoordinator) {
        Auth.auth().createUser(withEmail: login, password: password) { [weak self] authResult, error in
            if error == nil {
//                let alertView = self!.createAlertView(viewTitle: "Успешная регистрация", message: "Пользователь успешно зарегистрирован", actionTitle: "ok")
                let alertView = UIAlertController(title: "Успешная регистрация", message: "Пользователь успешно зарегистрирован", preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .default)
                alertView.addAction(ok)
                controller.present(alertView, animated: true, completion: nil)
            } else {

//                let alertView = self!.createAlertView(viewTitle: "Ошибка регистрации", message: error!.localizedDescription, actionTitle: "ok")
                
                let alertView = UIAlertController(title: "Ошибка регистрации", message: error!.localizedDescription, preferredStyle: .alert)
                let ok = UIAlertAction(title: "ok", style: .default)
                alertView.addAction(ok)
                controller.present(alertView, animated: true, completion: nil)
            }
        }
        
        
    }
    
    func checkCredentials(login: String, password: String, controller: LogInViewController, coordinator: ProfileCoordinator) {
        
        Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
            let profileErrorsProcessor = ProfileErrorsProcessor()
            if error != nil {
                do {
                    if  login.isEmpty && password.isEmpty {
                        throw ProfileErrors.noLogInNoPassword
                    } else if login.isEmpty {
                        throw ProfileErrors.noLogIn
                    } else if password.isEmpty {
                        throw ProfileErrors.noPassword
                    } else {
                        throw ProfileErrors.wrongPassword
                    }
                    
                } catch {
                    if let catchedError = error as? ProfileErrors {
                        let alertView = profileErrorsProcessor.processErrors(error: catchedError)
                        controller.present(alertView, animated: true, completion: nil)
                    }
                }
            } else {
                coordinator.profileViewController(coordinator: coordinator)
            }

        }
    }
    
    private func createAlertView(viewTitle: String, message: String, actionTitle: String) -> UIAlertController {
        let alertView = UIAlertController(title: viewTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default)
        alertView.addAction(action)
        return alertView
    }
    
}
