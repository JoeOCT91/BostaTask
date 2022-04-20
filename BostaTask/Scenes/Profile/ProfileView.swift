//
//  ProfileView.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 20/04/2022.
//

import UIKit

class ProfileView: UIView{
    
    let AlbumsTableView = UITableView(frame: .zero)
    
    init() {
        super.init(frame: .zero)
        configureTableView()
        configureTableViewHeader()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureTableView() {
        
    }
    
    private func configureTableViewHeader() {
        
    }
}
