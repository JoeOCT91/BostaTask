//
//  AlbumItemCollectionViewCell.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 20/04/2022.
//

import UIKit
import Combine
import Kingfisher


class AlbumItemCollectionViewCell: UICollectionViewCell {
    
    var tapSubscription: AnyCancellable?
    let containerView = UIView(frame: .zero)
    let imageView = UIImageView(frame: .zero)
    let tapGesture = UITapGestureRecognizer(target: AlbumItemCollectionViewCell.self, action: nil)
    private var downloadTask: DownloadTask?
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        addGestureRecognizer(tapGesture)
        configureContainerView()
        configureImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        downloadTask?.cancel()
        tapSubscription = nil
    }
    
    func setup(albumPhoto: AlbumPhoto) {
        let url = URL(string: albumPhoto.thumbnailUrl)
        imageView.kf.indicatorType = .activity
        downloadTask = imageView.kf.setImage(with: url)
    }

    private func configureContainerView() {
        contentView.addSubview(containerView)
        containerView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            containerView.rightAnchor.constraint(equalTo: contentView.rightAnchor),
            containerView.leftAnchor.constraint(equalTo: contentView.leftAnchor),
        ])
    }
    private func configureImageView() {
        containerView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: containerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            imageView.rightAnchor.constraint(equalTo: containerView.rightAnchor),
            imageView.leftAnchor.constraint(equalTo: containerView.leftAnchor),
        ])
    }
}
