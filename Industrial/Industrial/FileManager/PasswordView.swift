//
//  PasswordView.swift
//  Industrial
//
//  Created by DmitriiG on 04.12.2022.
//

import Foundation
import UIKit

private class PasswordView {
    
    private func launchPasswordAlertWindow(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addTextField { text in
            text.placeholder = message
        }
    let alertActionOk = UIAlertAction(title: "Ok", style: .default) { UIAlertAction in
        self.processPassword(alertController: alertController)
    }
    
    alertController.addAction(alertActionOk)
//    self.present(alertController, animated: true)
}
    
    private func processPassword(alertController: UIAlertController) {
        ()
    }
    
}
