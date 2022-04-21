//
//  AppDelegate.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 19/04/2022.
//

import UIKit
import Combine

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let profileViewController = ProfileViewController.create()
        let navigationViewController = UINavigationController(rootViewController: profileViewController)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
        return true
    }

}

