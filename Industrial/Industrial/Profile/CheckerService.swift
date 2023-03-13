//
//  CheckerService.swift
//  Industrial
//
//  Created by DmitriiG on 19.10.2022.
//

import Foundation
import UIKit
import FirebaseAuth

protocol CheckerServiceControllerProtocol: AnyObject {
    func callAlertViewSignUpFailure()
    func callAlertViewSignUpSuccess()
    func callAlertViewCredentialFailure()
    func goToProfilePage()
    
}

final class CheckerService: CheckerServiceProtocol {
    
    var controller: CheckerServiceControllerProtocol? = nil
    
    func signUp(login: String, password: String) {
        
        guard !login.isEmpty, !password.isEmpty else {
            controller?.callAlertViewCredentialFailure()
            return
        }
        
        var checkStatus = false
        
        for i in LoginRealmModel.shared.loginPairArray {
            if i.login == login {
                checkStatus = true
            }
        }
        
        if checkStatus {
            controller?.callAlertViewCredentialFailure()
        } else {
            LoginRealmModel.shared.addLoginModel(login: login, password: password)
            LoginRealmModel.shared.statusLoggedIn(login: login)
            controller?.callAlertViewSignUpSuccess()
        }
    }
    
    func checkCredentials(login: String, password: String) {
        
        guard !login.isEmpty, !password.isEmpty else {
            controller?.callAlertViewCredentialFailure()
            return
        }
        
        var checkStatus = false
        for i in LoginRealmModel.shared.loginPairArray {
            if i.login == login, i.password == password {
                checkStatus = true
            }
        }
        
        if checkStatus {
            LoginRealmModel.shared.statusLoggedIn(login: login)
            
            controller?.goToProfilePage()
            
        } else {
            controller?.callAlertViewCredentialFailure()
        }
    }
    
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
