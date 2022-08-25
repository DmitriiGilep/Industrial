//
//  AppDelegate.swift
//  Navigation
//
//  Created by DmitriiG on 12.02.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        window = UIWindow()
        window?.makeKeyAndVisible()
        let mainCoordinator = MainCoordinator()
        window?.rootViewController = mainCoordinator.startApplication()
      
        
        return true
    }

  

}

