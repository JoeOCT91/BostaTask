//
//  ProfileViewController.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 19/04/2022.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {
    
    private var subscriptions = Set<AnyCancellable>()
    private var viewModel: ProfileViewModelProtocol!
    private var profileView: ProfileView!
    
    override func loadView() {
        let profileView = ProfileView()
        self.profileView = profileView
        self.view = profileView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.prefersLargeTitles = true
        bindToDataStreamsAndUserInteractions()
    }
    
    class func create() -> ProfileViewController {
        let viewController = ProfileViewController()
        let viewModel = ProfileViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}

extension ProfileViewController {
    private func bindToDataStreamsAndUserInteractions() {
        bindToRandomUser()
    }
    private func bindToRandomUser() {
        viewModel.randomUser.sink { [weak self] randomUser in
            guard let self = self else { return }
            self.profileView.setupUserInformationDetails(userInformation: randomUser)
        }.store(in: &subscriptions)
    }
}
