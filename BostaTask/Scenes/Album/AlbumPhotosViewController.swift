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
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, AlbumPhoto>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, AlbumPhoto>
    private var dataSource: DataSource!
    
    private weak var coordinator: MainCoordinator?
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel: AlbumPhotosViewModelProtocol!
    private var albumPhotosView: AlbumPhotosView!
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    override func loadView() {
        let albumPhotosView = AlbumPhotosView()
        self.albumPhotosView = albumPhotosView
        self.view = albumPhotosView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = viewModel.album.albumTitle
        bindToDataStreamsAndUserInteractions()
        configureDataSource()
        configureSearchBar()
    }
    
    deinit {
        print("has been deinitlized \(String(describing: self)) ")
    }
    
    class func create(coordinator: MainCoordinator, album: Album) -> AlbumPhotosViewController {
        let viewController = AlbumPhotosViewController()
        let viewModel = AlbumPhotosViewModel(album: album)
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        return viewController
    }
    
}
extension AlbumPhotosViewController {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Private methods ...
    //----------------------------------------------------------------------------------------------------------------
    private func bindToDataStreamsAndUserInteractions() {
        bindToAlbumPhotosDataStream()
        bindToSearchBarCancelTapUserInteraction()
    }
    
    private func bindToAlbumPhotosDataStream() {
        viewModel.albumPhotosList.sink { [weak self] photosList in
            guard let self = self else { return }
            var snapshot = DataSourceSnapshot()
            snapshot.appendSections([Section.main])
            snapshot.appendItems(photosList)
            self.updateDataSource(snapshot: snapshot)
        }.store(in: &subscriptions)
    }
    
    private func updateDataSource(snapshot: DataSourceSnapshot) {
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func configureDataSource() {
        dataSource = DataSource(collectionView: albumPhotosView.albumCollectionView) { [weak self] collectionView, indexPath, albumPhoto in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Cells.albumItemCell, for: indexPath) as! AlbumItemCollectionViewCell
            guard let self = self else { return cell }
            cell.setup(albumPhoto: albumPhoto)
            cell.tapSubscription = cell.tapGesture.tapPublisher.sink { [weak self] _ in
                guard let self = self else { return }
                print("cell at index path : \(indexPath) has been clicked")
                self.coordinator?.pushImageViewerViewController(with: albumPhoto)
            }
            return cell
        }
    }
    
    private func configureSearchBar() {
        navigationItem.searchController = albumPhotosView.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        albumPhotosView.searchController.searchBar.searchTextField.textPublisher
            .debounce(for: .milliseconds(500), scheduler: RunLoop.main)
            .compactMap( { $0 })
            .sink { [weak self] searchKeyword in
                guard let self = self else { return }
                self.viewModel.searchKeyWord.send(searchKeyword)
            }.store(in: &subscriptions)
    }
    
    private func bindToSearchBarCancelTapUserInteraction() {
        albumPhotosView.searchController.searchBar.cancelButtonClickedPublisher.sink { [weak self] _ in
            guard let self = self else { return }
            self.albumPhotosView.albumCollectionView.scrollsToTop = true
        }.store(in: &subscriptions)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        print("didReceiveMemoryWarning")
    }
}
