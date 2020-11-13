//
//  AppDelegate.swift
//  VkReader
//
//  Created by  Alex on 10.11.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?

    var coreAssembly = CoreAssembly()
    lazy var presentationAssembly = coreAssembly.presentationAssembly
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        if let token = coreAssembly.credentialsStorage.get(key: kToken) {
            print("Авторизованы уже, вот токен \(token)")
        } else {
            let navigation = UINavigationController(rootViewController: presentationAssembly.loginViewController())
            window?.rootViewController = navigation
        }
        window?.makeKeyAndVisible()
        return true
    }

   
}

