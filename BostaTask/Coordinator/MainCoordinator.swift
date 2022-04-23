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
    
    func pushAlbumPhotosViewController(with album: Album) {
        let viewController = AlbumPhotosViewController.create(coordinator: self, album: album)
        navigationController.pushViewController(viewController, animated: true)
    }
    
    func pushImageViewerViewController(with albumPhoto: AlbumPhoto) {
        let viewController = ImageViewerViewController.create(albumPhoto: albumPhoto)
        navigationController.pushViewController(viewController, animated: true)
    }
}
