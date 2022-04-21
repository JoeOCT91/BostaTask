//
//  ProfileView.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 20/04/2022.
//

import UIKit

class ProfileView: UIView{
    
    private let userInformationStack = UIStackView(frame: .zero)
    private let userNameLabel = UILabel(frame: .zero)
    private let userFullAddressLabel = UILabel(frame: .zero)
    let albumsTableView = UITableView(frame: .zero)
    
    private let padding: CGFloat = 25
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        configureUserInformationStack()
        configureNameLabel()
        configureAddressLabel()
        configureTableView()
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
        userInformationStack.distribution = .fill
        userInformationStack.axis = .vertical
    }
    
    private func configureNameLabel() {
        
    }
    
    private func configureAddressLabel(){
        userFullAddressLabel.numberOfLines = 0
    }
    
    private func configureTableView() {

    }
    
    private func configureTableViewHeader() {
        
    }
    
//    private func layoutScrollView() {
//        self.addSubview(scrollView)
//        scrollView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
//            scrollView.rightAnchor.constraint(equalTo: rightAnchor),
//            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
//            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor)
//        ])
//    }
    
//    private func layoutContentView() {
//        scrollView.addSubview(contentView)
//        contentView.translatesAutoresizingMaskIntoConstraints = false
//        NSLayoutConstraint.activate([
//            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
//            contentView.leftAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leftAnchor),
//            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
//            contentView.rightAnchor.constraint(equalTo: scrollView.contentLayoutGuide.rightAnchor),
//            contentView.widthAnchor.constraint(equalToConstant: scrollView.frameLayoutGuide.layoutFrame.width),
//            contentView.heightAnchor.constraint(equalToConstant: scrollView.frameLayoutGuide.layoutFrame.height)
//        ])
//    }
    private func layoutUserInformationStack() {
        addSubview(userInformationStack)
        userInformationStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            userInformationStack.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            userInformationStack.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: padding),
            userInformationStack.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -padding),
        ])
    }
    
    private func layoutTableView() {
        addSubview(albumsTableView)
        albumsTableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumsTableView.topAnchor.constraint(equalTo: userInformationStack.bottomAnchor),
            albumsTableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            albumsTableView.leftAnchor.constraint(equalTo: leftAnchor),
            albumsTableView.rightAnchor.constraint(equalTo: rightAnchor),
        ])
    }
}
