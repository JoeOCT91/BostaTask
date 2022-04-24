//
//  ProfileView.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 20/04/2022.
//

import UIKit

class ProfileView: UIView{

    private let userNameLabel = UILabel(frame: .zero)
    private let userFullAddressLabel = UILabel(frame: .zero)
    private let sectionTitle = UILabel(frame: .zero)
    let albumsTableView = UITableView(frame: .zero)
    let userInformationStack = UIStackView(frame: .zero)

    private let padding: CGFloat = 22
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        configureTableView()
        configureLabels()
        configureUserInformationStack()
        layoutTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupUserInformationDetails(userInformation: User) {
        userNameLabel.text = userInformation.name
        userFullAddressLabel.text = userInformation.address.fullAddress
        sectionTitle.text = L10n.myAlbumsSection
    }

    private func configureUserInformationStack() {
        let stackViews = [ userNameLabel, userFullAddressLabel, sectionTitle]
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
    
    private func configureLabels() {
        userNameLabel.font = .systemFont(ofSize: 18, weight: .bold)
        sectionTitle.font = .systemFont(ofSize: 18, weight: .bold)
        userFullAddressLabel.font = .systemFont(ofSize: 16, weight: .regular)
        userFullAddressLabel.numberOfLines = 0
    }
    
    private func configureTableView() {
        albumsTableView.register(AlbumTableViewCell.self, forCellReuseIdentifier: Cells.albumCell)
        albumsTableView.separatorStyle = .none
    }
    
    private func layoutTableView() {
        addSubview(albumsTableView)
        albumsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumsTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            albumsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            albumsTableView.leftAnchor.constraint(equalTo: leftAnchor),
            albumsTableView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
