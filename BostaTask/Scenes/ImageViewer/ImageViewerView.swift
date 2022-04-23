//
//  ImageViewerView.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 23/04/2022.
//

import UIKit
import SDWebImage

class ImageViewerView: UIView {
    
    var imageView = UIImageView(frame: .zero)
    var scrollView = UIScrollView(frame: .zero)
    var imageViewBottomConstraint: NSLayoutConstraint!
    var imageViewLeadingConstraint: NSLayoutConstraint!
    var imageViewTopConstraint: NSLayoutConstraint!
    var imageViewTrailingConstraint: NSLayoutConstraint!
    
    init(albumPhoto: AlbumPhoto) {
        super.init(frame: .zero)
        backgroundColor = .white
        layoutScrollView()
        print(SDImageCache.shared.imageFromCache(forKey: albumPhoto.thumbnailUrl) as Any)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func layoutScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
}
