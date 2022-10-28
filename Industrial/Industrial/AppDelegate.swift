//
//  AppDelegate.swift
//  Navigation
//
//  Created by DmitriiG on 12.02.2022.
//

import UIKit
import FirebaseCore
import FirebaseAuth


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    // объявил свойство конфигурации
    var appConfiguration: AppConfiguration?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        // инициализировал кейсом ref1
        appConfiguration = AppConfiguration.ref1
        
        FirebaseApp.configure() // добавил конфигурирование Firebase
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        let mainCoordinator = MainCoordinator()
        window?.rootViewController = mainCoordinator.startApplication()
        
        return true
    }

    func applicationWillTerminate(_ application: UIApplication) {
        do {
            try Auth.auth().signOut() // разлогинивает пользователя
        } catch {
            return
        }
        
        
    }

}

