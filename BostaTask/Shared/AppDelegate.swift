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
    var subscriptions = Set<AnyCancellable>()

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        let profileViewController = ProfileViewController.create()
        let navigationViewController = UINavigationController(rootViewController: profileViewController)
        window?.rootViewController = navigationViewController
        window?.makeKeyAndVisible()
        
        NetworkManager.shared().getUsersList().sink { error in
            print(error)
        } receiveValue: { usersList in
            print(usersList)
        }.store(in: &subscriptions)

                                                    
        return true
    }

}

