//
//  Checker.swift
//  Industrial
//
//  Created by DmitriiG on 13.08.2022.
//

import Foundation

final class Checker {
    
    private init() {}
    
    static let shared = Checker()
    
    private let login = "Dmitrii"
    private let pswd = "111"
    var logInned = false
    
    func checker(loginInserted: String, passwordInserted: String) {
        if loginInserted.hash == login.hash && passwordInserted.hash == pswd.hash {
            logInned = true
        }
    }
    
}

