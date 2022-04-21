//
//  MainCoordinator.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 22/04/2022.
//

import UIKit

protocol AppCoordinator: AnyObject {
    
}
class MainCoordinator: AppCoordinator {
    
    let navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ProfileViewController.create()
        
    }
    
    
}
