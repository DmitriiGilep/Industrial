//
//  LoginRealmModel.swift
//  Industrial
//
//  Created by DmitriiG on 17.12.2022.
//

import Foundation
import RealmSwift

final class LoginModel: Object {
    
    @Persisted var login: String = ""
    @Persisted var password: String = ""
    
}

final class Status: Object {
    
    @Persisted var status: Bool = false
    @Persisted var login: String?
    
}

final class LoginRealmModel {
    
    static let shared = LoginRealmModel()

    var status = Status()
    
    var loginPairArray: [LoginModel] = []
    
    init() {
        migrate()
        refreshData()
    }
    
    func addLoginModel(login: String, password: String) {
        let realm = try! Realm()
        try! realm.write {
            let loginPair = LoginModel()
            loginPair.login = login
            loginPair.password = password
            realm.add(loginPair)
            refreshData()
        }
    }
    
    func refreshData() {
        let realm = try! Realm()
        loginPairArray = Array(realm.objects(LoginModel.self))
        if let statusNew = realm.objects(Status.self).first {
            status = statusNew
        }
        
    }
    
    func statusLoggedIn(login: String) {
        let realm = try! Realm()
        if let statusUpdate = realm.objects(Status.self).first {
            try! realm.write {
                statusUpdate.status = true
                statusUpdate.login = login
            }
        } else {
            try! realm.write {
                let statusUpdate = Status()
                statusUpdate.status = true
                statusUpdate.login = login
                realm.add(statusUpdate)
            }
        }
        refreshData()
    }
    
    func statusLoggedOut() {
        let realm = try! Realm()
        if let statusUpdate = realm.objects(Status.self).first {
            try! realm.write {
                statusUpdate.status = false
                statusUpdate.login = nil
                refreshData()
            }
        }
        
    }
    
//    func deleteData(login: String, password: String) {
//        let realm = try! Realm()
//        try! realm.write {
//            for i in realm.objects(LoginModel.self) {
//                if i.login == login, i.password == password {
//                    realm.delete(i)
//                }
//            }
//        }
//        refreshData()
//    }
    
    private func migrate() {
        let config = Realm.Configuration(schemaVersion: 2) // update the scheme number after the model has been changed
        Realm.Configuration.defaultConfiguration = config
    }
    
}
