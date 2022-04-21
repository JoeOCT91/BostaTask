//
//  MainCoordinator.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 22/04/2022.
//

import UIKit

protocol AppCoordinator: AnyObject {
    var navigationController: UINavigationController { get }
    func start()
}
class MainCoordinator: AppCoordinator {
    
    let navigationController: UINavigationController
    
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        let viewController = ProfileViewController.create(coordinator: self)
        navigationController.viewControllers = [viewController]
    }
    
    func pushAlbumPhotosViewController(with albumId: Int) {
        let viewController = ProfileViewController.create(coordinator: self)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    
}
