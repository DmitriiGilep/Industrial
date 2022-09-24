//
//  ProfileModel.swift
//  Industrial
//
//  Created by DmitriiG on 24.09.2022.
//

import Foundation
import UIKit

// enum с ошибками
enum ProfileErrorsList: Error {
    case noLogInNoPassword
    case noLogIn
    case noPassword
    case wrongPassword
    case unknownError
    case noImagesForCollection
}

class ProfileErrorsProcessor {
    
    // функция обрабатывает ошибки
    func processErrors(error: ProfileErrorsList) -> UIAlertController{
        var alertView = UIAlertController()
        switch error {
        case .noLogInNoPassword:
            alertView = profileErrorAlert(message: "Введите логин и пароль")
        case .noLogIn:
            alertView = profileErrorAlert(message: "Введите логин")
        case .noPassword:
            alertView = profileErrorAlert(message: "Введите пароль")
        case .wrongPassword:
            alertView = profileErrorAlert(message: "Неверный логин или пароль")
        case.unknownError:
            alertView = profileErrorAlert(message: "Неизвестная ошибка")
        case .noImagesForCollection:
            alertView = profileErrorAlert(message: "В коллекции нет изображений")
        }
        return alertView
    }
    
    // функция выводит alert при ошибках
    private func profileErrorAlert(message: String) -> UIAlertController {
        let alertView = UIAlertController(title: "Ошибка", message: message, preferredStyle: .alert)
        let ok = UIAlertAction(title: "ok", style: .default)
        alertView.addAction(ok)
        return alertView
    }
}
