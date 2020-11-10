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

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        
        let viewModel = LoginScreenImpl()
//        let vc = LoginScreen(viewModel: viewModel)
        let vc = LoginScreen()
        let navigation = UINavigationController(rootViewController: vc)
        window?.rootViewController = navigation
        window?.makeKeyAndVisible()
        return true
    }

   
}

