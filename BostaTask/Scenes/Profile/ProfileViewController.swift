//
//  ProfileViewController.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 19/04/2022.
//

import UIKit
import Combine

class ProfileViewController: UIViewController {
    
    private var viewModel: ProfileViewModelProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    class func create() -> ProfileViewController {
        let viewController = ProfileViewController()
        let viewModel = ProfileViewModel()
        viewController.viewModel = viewModel
        return viewController
    }
}
