//
//  ImageViewerView.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 23/04/2022.
//

import UIKit
import Kingfisher

class ImageViewerView: UIView {
    
    var imageView = UIImageView(frame: .zero)
    var scrollView = UIScrollView(frame: .zero)

    
    init(albumPhoto: AlbumPhoto) {
        super.init(frame: .zero)
        backgroundColor = .white
        configureScrollView()
        downloadFullSizeImage(albumPhoto: albumPhoto)
        scrollView.delegate = self
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        layoutScrollView()
        layoutImageView()
    }
    private func configureScrollView() {
        scrollView.maximumZoomScale = 2 // to control how big can image become
        scrollView.minimumZoomScale = 1
    }
    
    private func downloadFullSizeImage(albumPhoto: AlbumPhoto) {
        let url = URL(string: albumPhoto.url)
        ImageCache.default.retrieveImage(forKey: albumPhoto.thumbnailUrl) { [weak self] compilation in
            guard let self = self else { return }
            switch compilation {
            case .success(let value):
                self.imageView.kf.setImage(with: url, placeholder: value.image)
            case .failure(_):
                self.imageView.kf.setImage(with: url)
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    private func layoutScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }

    private func layoutImageView() {
        let imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        let imageViewWidthConstraint = imageView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor)
        let imageViewLeftConstraint = imageView.leftAnchor.constraint(equalTo: scrollView.leftAnchor)
        let imageViewRightConstraint = imageView.rightAnchor.constraint(equalTo: scrollView.rightAnchor)
        let imageViewTopConstraint = imageView.topAnchor.constraint(equalTo: scrollView.topAnchor)
        let imageViewBottomConstraint = imageView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor)

        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageViewTopConstraint,
            imageViewBottomConstraint,
            imageViewRightConstraint,
            imageViewLeftConstraint,
            imageViewHeightConstraint,
            imageViewWidthConstraint,
        ])
    }
}
//MARK:- UIScrollViewDelegate
extension ImageViewerView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        // could use to do improvement to zooming mechanism
    }
}
