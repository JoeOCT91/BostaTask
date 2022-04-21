//
//  AlbumPhotosView.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 20/04/2022.
//

import UIKit

class AlbumPhotosView: UIView {
    
    let albumCollectionView = UICollectionView(frame: .zero)
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
