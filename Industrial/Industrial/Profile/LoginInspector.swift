//
//  LoginInspector.swift
//  Industrial
//
//  Created by DmitriiG on 13.08.2022.
//

import UIKit

//MARK: - новый класс, подписанный на протокол LoginViewControllerDelegate

final class LoginInspector: LoginViewControllerDelegate {
    
    func checkLogin(login: String, password: String) -> Bool {
        let checker = Checker.shared
        checker.checker(loginInserted: login, passwordInserted: password)
        return checker.logInned
        }
    
}

