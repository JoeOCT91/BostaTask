//
//  AlbumViewController.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 19/04/2022.
//

import UIKit
import Combine
import Kingfisher

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
        albumPhotosView.albumCollectionView.prefetchDataSource = self
        bindToDataStreamsAndUserInteractions()
        configureDataSource()
        configureSearchBar()
    }

    deinit {
        print("has been deinitlized \(String(describing: self)) ")
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Public methods ...
    //----------------------------------------------------------------------------------------------------------------
    
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
        bindToLoadingData()
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
            self.albumPhotosView.albumCollectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        }.store(in: &subscriptions)
    }
    private func bindToLoadingData() {
        viewModel.isLoadingObserver.sink { [weak self] loadingState in
            guard let self = self else { return }
            self.albumPhotosView.setActivityIndicator = loadingState
        }.store(in: &subscriptions)
    }
}

extension AlbumPhotosViewController: UICollectionViewDataSourcePrefetching {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  DataSource Prefetching delegate methods
    //----------------------------------------------------------------------------------------------------------------
    
    func collectionView(_ collectionView: UICollectionView, prefetchItemsAt indexPaths: [IndexPath]) {
        guard let currentDataList = dataSource?.snapshot().itemIdentifiers else { return }
        let urls = indexPaths.compactMap { indexPath -> URL? in
            return URL(string: currentDataList[indexPath.item].thumbnailUrl)
        }
        let prefetcher = ImagePrefetcher(urls: urls)
        prefetcher.start()
    }
}
