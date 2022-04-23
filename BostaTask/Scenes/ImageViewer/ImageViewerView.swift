//
//  ImageViewerView.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 23/04/2022.
//

import UIKit

class ImageViewerView: UIView {
    
    var imageView = UIImageView(frame: .zero)
    var scrollView = UIScrollView(frame: .zero)

    private var imageViewCenterXConstraint: NSLayoutConstraint!
    private var imageViewCenterYConstraint: NSLayoutConstraint!
    private var imageViewHeightConstraint: NSLayoutConstraint!
    private var imageViewWidthConstraint: NSLayoutConstraint!

    
    init(albumPhoto: AlbumPhoto) {
        super.init(frame: .zero)
        backgroundColor = .white
        layoutScrollView()
        layoutImageView()
        scrollView.delegate = self
        downloadFullSizeImage(albumPhoto: albumPhoto)
    }
    private func downloadFullSizeImage(albumPhoto: AlbumPhoto) {
        let url = URL(string: albumPhoto.url)

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func updateMinZoomScaleForSize(_ size: CGSize) {
        let widthScale = size.width / imageView.bounds.width
        let heightScale = size.height / imageView.bounds.height
        let minScale = min(widthScale, heightScale)

        print(imageView.bounds)
        print(widthScale)
        
        scrollView.minimumZoomScale = minScale
        scrollView.zoomScale = minScale
    }
    
    private func layoutScrollView() {
        addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            scrollView.leftAnchor.constraint(equalTo: leftAnchor),
            scrollView.rightAnchor.constraint(equalTo: rightAnchor)
        ])
    }
    private func layoutImageView() {
        imageViewHeightConstraint = imageView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        imageViewWidthConstraint  = imageView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        imageViewCenterYConstraint = imageView.centerYAnchor.constraint(equalTo: scrollView.centerYAnchor)
        imageViewCenterXConstraint = imageView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor)
        scrollView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            imageView.heightAnchor.constraint(equalTo: scrollView.widthAnchor),
            imageView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),


        ])
    }
    
    
    
}
//MARK:- UIScrollViewDelegate
extension ImageViewerView: UIScrollViewDelegate {
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        print(imageView.frame)
        return imageView
    }
    
    func scrollViewDidZoom(_ scrollView: UIScrollView) {
        print("scrollViewDidZoom")
        updateConstraintsForSize(bounds.size)
    }
    
    func updateConstraintsForSize(_ size: CGSize) {
        let yOffset = max(0, (size.height - imageView.frame.height) / 2)
        imageViewHeightConstraint.constant = yOffset
        print("yOffset is \(yOffset)")

        let xOffset = max(0, (size.width - imageView.frame.width) / 2)
        imageViewWidthConstraint.constant = xOffset
        print("xofset is \(xOffset)")
        
        layoutIfNeeded()
    }
}
