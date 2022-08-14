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
   
        // создал экземляры 2 viewControllers
        let feedViewController = FeedViewController()
        let loginViewController = LogInViewController()
        
        //MARK: - инициализировал фабрику и создал зависимость LoginViewController, myLoginFactory.loginInspector() возвращает класс LoginInspector()
        let myLoginFactory = MyLoginFactory()
        loginViewController.delegate = myLoginFactory.loginInspector()
        
        // создал экземпляр tabBarControllers - панель внизу
        let tabBarController = UITabBarController()
        
        // создал экземпляры navControllers с присвоением при инициализации rootView созданным viewControllers
        let firstNavController = UINavigationController(rootViewController: feedViewController)
        let secondNavContoller = UINavigationController(rootViewController: loginViewController)
       
        // nav stacks
        firstNavController.viewControllers = [feedViewController]
        
        secondNavContoller.viewControllers = [loginViewController]
        secondNavContoller.navigationBar.isHidden = true
        

        // tabbar stack c navControllers = панель внизу
        tabBarController.viewControllers = [firstNavController, secondNavContoller]
        

        //создал экземпляр иконки таббара и присвоил им имена и картинки, затем присвоил таббарайтему навконтролера эти экземпляры
        let tabBar1 = UITabBarItem()
        let tabBar2 = UITabBarItem()
        tabBar1.title = "Лента"
        tabBar2.title = "Профиль"
        let image1 = UIImage(systemName: "person.3.sequence.fill")
        let image2 = UIImage(systemName: "person.fill")
        tabBar1.image = image1
        tabBar2.image = image2
        
        firstNavController.tabBarItem = tabBar1
        secondNavContoller.tabBarItem = tabBar2
        
        //присвоил rootView tabBarController
        window?.rootViewController = tabBarController
        window?.makeKeyAndVisible()
        
        return true
    }

  

}

