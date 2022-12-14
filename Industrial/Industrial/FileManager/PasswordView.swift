//
//  PasswordView.swift
//  Industrial
//
//  Created by DmitriiG on 04.12.2022.
//

import Foundation
import UIKit

final class PasswordView {
    
    var login: String?
    var loginStatus = false
    let alert = CustomAlert()
    let blurEffect = UIBlurEffect(style: .dark)
    lazy var blurVisualEffectView = UIVisualEffectView(effect: blurEffect)
    
    
    func launchCreatePasswordAlertWindow(controller: UIViewController) {
        blurVisualEffectView.frame = controller.view.bounds
        controller.view.addSubview(blurVisualEffectView)
        
        lazy var alertControllerCreatePassword = alert.createAlertWithThreeCompletion(title: "Create a password", message: "The length is not less 4 symbols", placeholder1: "Insert a login", placeholder2: "Insert a password" , titleAction1: "Ok", action1: {
            [weak self] in
            guard let login = alertControllerCreatePassword.textFields?[0].text else {return}
            guard let password = alertControllerCreatePassword.textFields?[1].text else {return}
            
            if login.count == 0 || password.count < 4 {
                let alert = self?.alert.createAlertWithCompletion(title: "Error", message: "The login or password doesn't meet the rules", placeholder: nil, titleAction: "Repeat") {
                    self?.launchCreatePasswordAlertWindow(controller: controller)
                }
                controller.present(alert!, animated: true)
            } else {
                self?.launchCreatePasswordAlertWindow2(login: login, password: password, controller: controller)
            }

        }, titleAction2: "Already have a password", action2: {
            [weak self] in
            self?.launchInsertPasswordAlertWindow(controller: controller)
        }, titleAction3: "Cancel", action3: {
            ()
        })
        alertControllerCreatePassword.textFields?[1].isSecureTextEntry = true
        controller.present(alertControllerCreatePassword, animated: true)
    }
    
    func launchCreatePasswordAlertWindow2(login: String, password: String, controller: UIViewController) {
 
        lazy var alertControllerCreatePassword2 = alert.createAlertWithTwoCompletion(title: "Repeat a password", message: "Insert a password again", placeholder: "Insert a password", titleAction1: "Ok", action1: {
            [weak self] in
            guard let passwordRep = alertControllerCreatePassword2.textFields?[0].text else {return}
            if password != passwordRep {
                let alertRepeat = self?.alert.createAlertWithCompletion(title: "Error", message: "Passwords don't match", placeholder: nil, titleAction: "Repeat") {
                    self?.launchCreatePasswordAlertWindow(controller: controller)
                }
                controller.present(alertRepeat!, animated: true)
            } else {
                self?.addPassword(login: login, password: password, controller: controller)
            }
            
        }, titleAction2: "Cancel", action2: {
            ()
        })
        alertControllerCreatePassword2.textFields?[0].isSecureTextEntry = true
        controller.present(alertControllerCreatePassword2, animated: true)
    }
    
    func launchInsertPasswordAlertWindow(controller: UIViewController) {
        
        lazy var alertControllerInsertPassword = alert.createAlertWithThreeCompletion(title: "Insert a password", message: "Please, insert a password", placeholder1: "Insert a login", placeholder2: "Insert a password", titleAction1: "Ok", action1: { [weak self] in
            guard let login = alertControllerInsertPassword.textFields?[0].text else {return}
            guard let password = alertControllerInsertPassword.textFields?[1].text else {return}
            self?.getPassword(login: login, password: password, controller: controller)
        }, titleAction2: "Create a password", action2: {
            [weak self] in
            self?.launchCreatePasswordAlertWindow(controller: controller)
        }, titleAction3: "Cancel", action3: {
            ()
        })
        alertControllerInsertPassword.textFields?[1].isSecureTextEntry = true
        controller.present(alertControllerInsertPassword, animated: true)
    }
    
    func launchChangePasswordAlertWindow(controller: UIViewController) {
        
        lazy var alertControllerChangePassword = alert.createAlertWithTwoCompletion(title: "Change a password", message: "Please, insert a password", placeholder: "Insert a password", titleAction1: "Ok", action1: { [weak self] in
            guard let password = alertControllerChangePassword.textFields?[0].text else {return}
            if password.count < 4 {
                let alert = self?.alert.createAlertWithCompletion(title: "Error", message: "The login or password doesn't meet the rules", placeholder: nil, titleAction: "Repeat") {
                    self?.launchChangePasswordAlertWindow(controller: controller)
                }
                controller.present(alert!, animated: true)
            } else {
                self?.launchChangePasswordAlertWindow2(password: password, controller: controller)
            }
            
            
        }, titleAction2: "Cancel") {
            ()
        }
        alertControllerChangePassword.textFields?[0].isSecureTextEntry = true
        controller.present(alertControllerChangePassword, animated: true)
    }
    
    
    func launchChangePasswordAlertWindow2(password: String, controller: UIViewController) {
 
        lazy var alertControllerCreatePassword2 = alert.createAlertWithTwoCompletion(title: "Repeat a password", message: "Insert a password again", placeholder: "Insert a password", titleAction1: "Ok", action1: {
            [weak self] in
            guard let passwordRep = alertControllerCreatePassword2.textFields?[0].text else {return}
            if password != passwordRep {
                let alertRepeat = self?.alert.createAlertWithCompletion(title: "Error", message: "Passwords don't match", placeholder: nil, titleAction: "Repeat") {
                    self?.launchChangePasswordAlertWindow(controller: controller)
                }
                controller.present(alertRepeat!, animated: true)
            } else {
                self?.updatePassword(newPassword: password, controller: controller)
            }
        }, titleAction2: "Cancel", action2: {
            ()
        })
        alertControllerCreatePassword2.textFields?[0].isSecureTextEntry = true
        controller.present(alertControllerCreatePassword2, animated: true)
    }
    
    
    private func addPassword(login: String, password: String, controller: UIViewController) {
        guard let passData = password.data(using: .utf8) else {
            print("Ошибка преобразования пароля")
            return
        }
        
        let attribute = [
            kSecClass: kSecClassGenericPassword,
            kSecValueData: passData,
            kSecAttrAccount: login
        ] as CFDictionary
        
        let status = SecItemAdd(attribute, nil)
        
        if status == errSecSuccess {
            print("Пароль добавлен")
            self.login = login
            blurVisualEffectView.removeFromSuperview()
            loginStatus = true

        } else {
            print("Ошибка добавления пароля: \(status)")
            lazy var alert = alert.createAlertWithCompletion(title: "Error", message: "The pair 'login/password' could not be added", placeholder: nil, titleAction: "Ok") {
                [weak self] in
                self?.launchCreatePasswordAlertWindow(controller: controller)
            }
            controller.present(alert, animated: true)
        }
    }
    
    private func getPassword(login: String, password: String, controller: UIViewController) {
        
        let  query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: login,
            kSecReturnData: true
        ] as CFDictionary
        
        var extractedData: AnyObject?
        
        let status = SecItemCopyMatching(query, &extractedData)
        
        if status != errSecSuccess {
            print("Ошибка получения пароля: \(status)")
            lazy var alert = alert.createAlertWithCompletion(title: "Error", message: "The password doesn't exist", placeholder: nil, titleAction: "Ok") {
                [weak self] in
                self?.launchInsertPasswordAlertWindow(controller: controller)
            }
            controller.present(alert, animated: true)
            return
        }
        
        guard let passData = extractedData as? Data,
              let passwordExtracted = String(data: passData, encoding: .utf8) else {
            print("Ошибка преобразования пароля")
            return
        }
        
        if passwordExtracted == password {
            print(passwordExtracted)
            blurVisualEffectView.removeFromSuperview()
            loginStatus = true
            self.login = login
            
        } else {
            lazy var alert = alert.createAlertWithCompletion(title: "Error", message: "The password is incorrect", placeholder: nil, titleAction: "Ok") {
                [weak self] in
                self?.launchInsertPasswordAlertWindow(controller: controller)
            }
            controller.present(alert, animated: true)

        }
        
    }
 
    func updatePassword(newPassword: String, controller: UIViewController) {
        
        guard let passData = newPassword.data(using: .utf8) else {
            print("Ошибка преобразования пароля")
            return
        }
        
        let query = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: self.login,
            kSecReturnData: false
        ] as CFDictionary
        
        let attribute = [
            kSecValueData: passData
        ] as CFDictionary
        
        let status = SecItemUpdate(query, attribute)
        
        if status == errSecSuccess {
            print("Пароль обновлен")
            lazy var alert = alert.createAlertWithCompletion(title: "The password has been updated", message: nil, placeholder: nil, titleAction: "Ok") {
                ()
            }
            controller.present(alert, animated: true)
        } else {
            print("Ошибка обновления пароля: \(status)")
            lazy var alert = alert.createAlertWithCompletion(title: "Error", message: nil, placeholder: nil, titleAction: "Ok") {
                ()
            }
            controller.present(alert, animated: true)
        }
    }
    
    
}
