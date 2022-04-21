//
//  AlbumViewController.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 19/04/2022.
//

import UIKit
import Combine

class AlbumPhotosViewController: UIViewController {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    private enum Section: Hashable {
        case main
    }
    private typealias DataSource = UITableViewDiffableDataSource<Section, Album>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Album>
    private var dataSource: DataSource!
    
    private weak var coordinator: MainCoordinator?
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel: AlbumPhotosViewModelProtocol!
    private var albumPhotosView: AlbumPhotosView!
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    override func loadView() {
        let albumPhotosView = albumPhotosView()
        self.albumPhotosView = albumPhotosView
        self.view = albumPhotosView
    }
    
    class func create(coordinator: MainCoordinator, albumId: Int) -> AlbumPhotosViewController {
        let viewController = AlbumPhotosViewController()
        let viewModel = AlbumPhotosViewModel(albumId: albumId)
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        return viewController
    }
    
}
