//
//  ProfileViewController.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 19/04/2022.
//

import UIKit
import Combine
import CombineCocoa

class ProfileViewController: UIViewController {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    private enum Section: SectionProtocol {
        case main
        var header: String {
            switch self {
            case .main:
                return L10n.myAlbumsSection
            }
        }
    }

    private typealias DataSource = DataSourceWithSectionsHeader<Section, Album>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, Album>
    private var dataSource: DataSource!
    
    private weak var coordinator: MainCoordinator?
    private var subscriptions = Set<AnyCancellable>()
    private var cellsTapsSubscriptions = Dictionary<IndexPath, AnyCancellable>()
    private var viewModel: ProfileViewModelProtocol!
    private var profileView: ProfileView!

    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    
    override func loadView() {
        let profileView = ProfileView()
        self.profileView = profileView
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = L10n.profileViewControllerTitle
        navigationController?.navigationBar.prefersLargeTitles = true
        bindToDataStreamsAndUserInteractions()
        configureDataSource()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    deinit {
        print("has been deinitlized \(String(describing: self)) ")
    }
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Public methods ...
    //----------------------------------------------------------------------------------------------------------------
    class func create(coordinator: MainCoordinator) -> ProfileViewController {
        let viewController = ProfileViewController()
        let viewModel = ProfileViewModel()
        viewController.coordinator = coordinator
        viewController.viewModel = viewModel
        return viewController
    }
}

extension ProfileViewController {
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Private methods ...
    //----------------------------------------------------------------------------------------------------------------
    private func bindToDataStreamsAndUserInteractions() {
        bindToRandomUser()
        bindToAlbumList()
    }
    
    private func bindToRandomUser() {
        viewModel.randomUser.sink { [weak self] randomUser in
            guard let self = self else { return }
            self.profileView.setupUserInformationDetails(userInformation: randomUser)
        }.store(in: &subscriptions)
    }
    
    private func bindToAlbumList() {
        viewModel.userAlbums.sink { [weak self] albumList in
            guard let self = self else { return }
            var snapshot = DataSourceSnapshot()
            snapshot.appendSections([Section.main])
            snapshot.appendItems(albumList)
            self.updateDataSource(snapshot: snapshot)
        }.store(in: &subscriptions)
    }
    
    private func updateDataSource(snapshot: DataSourceSnapshot) {
        DispatchQueue.main.async {
            var snap = self.dataSource.snapshot()
            snap.deleteAllItems()
            self.dataSource.apply(snapshot, animatingDifferences: false)
        }
    }
    
    private func configureDataSource() {
        dataSource = DataSource(tableView: profileView.albumsTableView) { [weak self]  tableView, indexPath, album in
            let cell = tableView.dequeueReusableCell(withIdentifier: Cells.albumCell, for: indexPath) as! AlbumTableViewCell
            guard let self = self else { return cell }
            cell.setup(with: album)
            cell.tapGesture.tapPublisher.sink { _ in
                self.coordinator?.pushAlbumPhotosViewController(with: album)
            }.store(in: &self.cellsTapsSubscriptions, for: indexPath)
            return cell
        }
        
    }
}
