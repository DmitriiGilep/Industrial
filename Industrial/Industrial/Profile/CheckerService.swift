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
        let alertViewFailure = self.createAlertView(viewTitle: "failure_registration".localizable, message: "user_existed_something_wrong".localizable, actionTitle: "ok", action: nil)
        
        guard !login.isEmpty, !password.isEmpty else {
            return controller.present(alertViewFailure, animated: true, completion: nil)
        }
        
        var checkStatus = false
        
        for i in LoginRealmModel.shared.loginPairArray {
            if i.login == login {
                checkStatus = true
            }
        }
        
        
        if checkStatus {
            controller.present(alertViewFailure, animated: true, completion: nil)
        } else {
            LoginRealmModel.shared.addLoginModel(login: login, password: password)
            LoginRealmModel.shared.statusLoggedIn(login: login)
            let alertViewSuccess = self.createAlertView(viewTitle: "successful_registrarion".localizable, message: "user_registered".localizable, actionTitle: "ok") {
                coordinator.profileViewController(coordinator: coordinator, controller: controller, navControllerFromFactory: nil)
            }
            controller.present(alertViewSuccess, animated: true, completion: nil)

        }
        
        // firebase
  /*      Auth.auth().createUser(withEmail: login, password: password) { [weak self] authResult, error in
            if error == nil {
                let alertView = self!.createAlertView(viewTitle: "Успешная регистрация", message: "Пользователь успешно зарегистрирован", actionTitle: "ok")
                controller.present(alertView, animated: true, completion: nil)
            } else {

                let alertView = self!.createAlertView(viewTitle: "Ошибка регистрации", message: error!.localizedDescription, actionTitle: "ok")
                controller.present(alertView, animated: true, completion: nil)
            }
        }
      */
        
    }
    
    func checkCredentials(login: String, password: String, controller: LogInViewController, coordinator: ProfileCoordinator) {
        let alertView = self.createAlertView(viewTitle: "error".localizable, message: "password_login_incorrect".localizable, actionTitle: "Ок", action: nil)
        
        guard !login.isEmpty, !password.isEmpty else {
            return controller.present(alertView, animated: true, completion: nil)
        }
        
        var checkStatus = false
        for i in LoginRealmModel.shared.loginPairArray {
            if i.login == login, i.password == password {
                checkStatus = true
            }
        }
        
        if checkStatus {
            LoginRealmModel.shared.statusLoggedIn(login: login)
            
            coordinator.profileViewController(coordinator: coordinator, controller: controller, navControllerFromFactory: nil)
            
        } else {
            controller.present(alertView, animated: true)
        }
        
        
        
//        Auth.auth().signIn(withEmail: login, password: password) { [weak self] authResult, error in
//            let profileErrorsProcessor = ProfileErrorsProcessor()
//            if error != nil {
//                do {
//                    if  login.isEmpty && password.isEmpty {
//                        throw ProfileErrors.noLogInNoPassword
//                    } else if login.isEmpty {
//                        throw ProfileErrors.noLogIn
//                    } else if password.isEmpty {
//                        throw ProfileErrors.noPassword
//                    } else {
//                        throw ProfileErrors.wrongPassword
//                    }
//
//                } catch {
//                    if let catchedError = error as? ProfileErrors {
//                        let alertView = profileErrorsProcessor.processErrors(error: catchedError)
//                        controller.present(alertView, animated: true, completion: nil)
//                    }
//                }
//            } else {
//                coordinator.profileViewController(coordinator: coordinator)
//            }
//
//        }
    }
    
    private func createAlertView(viewTitle: String, message: String, actionTitle: String, action: (() -> Void)?) -> UIAlertController {
        let alertView = UIAlertController(title: viewTitle, message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: actionTitle, style: .default) { UIAlertAction in
            guard let actionUnwrapped = action else {return}
            actionUnwrapped()
        }
        alertView.addAction(action)
        return alertView
    }
    
}
