//
//  AlbumPhotosView.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 20/04/2022.
//

import UIKit

class AlbumPhotosView: UIView {
    
    let searchController = UISearchController()
    let albumCollectionView: UICollectionView = {
        let screenWidth = UIScreen.main.bounds.width // 
        let padding: CGFloat = 1
        let numberOfImagesPeerRow: CGFloat = 3
        let availableWidth: CGFloat = screenWidth - (padding * 2)
        let itemWidth: CGFloat = availableWidth / numberOfImagesPeerRow
        
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth )
        flowLayout.scrollDirection = .vertical
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.minimumLineSpacing = 1
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        return collectionView
    }()
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .white
        configureCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureCollectionView() {
        addSubview(albumCollectionView)
        albumCollectionView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            albumCollectionView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            albumCollectionView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            albumCollectionView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor),
            albumCollectionView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor),
        ])
        albumCollectionView.register(AlbumItemCollectionViewCell.self, forCellWithReuseIdentifier: Cells.albumItemCell)
        albumCollectionView.showsVerticalScrollIndicator = false
        albumCollectionView.showsHorizontalScrollIndicator = false
    }
}
