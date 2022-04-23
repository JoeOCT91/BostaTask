//
//  ProfileView.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 20/04/2022.
//

import UIKit

class ProfileView: UIView{
    let scrollView = UIScrollView(frame: .zero)
    let contentView = UIView(frame: .zero)
    let headerView = UIView(frame: .zero)
    private let userInformationStack = UIStackView(frame: .zero)
    private let userNameLabel = UILabel(frame: .zero)
    private let userFullAddressLabel = UILabel(frame: .zero)
    let albumsTableView = UITableView(frame: .zero)
    
    private let padding: CGFloat = 22
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        configureNameLabel()
        configureAddressLabel()
        configureTableView()
        configureUserInformationStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutUserInformationStack()
        layoutTableView()
    }
    
    func setupUserInformationDetails(userInformation: User) {
        userNameLabel.text = userInformation.name
        userFullAddressLabel.text = userInformation.address.fullAddress
    }

    
    private func configureUserInformationStack() {
        let stackViews = [ userNameLabel, userFullAddressLabel]
        stackViews.forEach { view in
            userInformationStack.addArrangedSubview(view)
        }
        userInformationStack.backgroundColor = .white
        userInformationStack.layoutMargins = UIEdgeInsets(top: 12, left: padding, bottom: 12, right: padding)
        userInformationStack.isLayoutMarginsRelativeArrangement = true
        userInformationStack.distribution = .fill
        userInformationStack.axis = .vertical
        userInformationStack.spacing = 12
    }
    
    private func configureNameLabel() {
        userNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
    }
    
    private func configureAddressLabel(){
        userFullAddressLabel.numberOfLines = 0
        userFullAddressLabel.font = .systemFont(ofSize: 16, weight: .regular)
    }
    
    private func configureTableView() {
        albumsTableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: Cells.albumCell)
        albumsTableView.separatorStyle = .none
    }
    
    private func layoutUserInformationStack() {
        addSubview(userInformationStack)
        userInformationStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userInformationStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userInformationStack.leftAnchor.constraint(equalTo: leftAnchor),
            userInformationStack.rightAnchor.constraint(equalTo: rightAnchor)
        ])
        userInformationStack.layoutIfNeeded()
    }
    private func layoutTableView() {
        addSubview(albumsTableView)
        albumsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumsTableView.topAnchor.constraint(equalTo: userInformationStack.bottomAnchor),
            albumsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            albumsTableView.leftAnchor.constraint(equalTo: leftAnchor),
            albumsTableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
