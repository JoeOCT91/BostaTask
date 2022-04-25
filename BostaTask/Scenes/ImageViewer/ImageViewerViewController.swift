//
//  ImageViewerViewController.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 23/04/2022.
//

import UIKit
import Combine

class ImageViewerViewController: UIViewController {
    
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Properties ...
    //----------------------------------------------------------------------------------------------------------------
    private var imageViewerView: ImageViewerView! {
        willSet {
            self.view = newValue
        }
    }
    private var subscriptions = Set<AnyCancellable>()
    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Life cycle methods ...
    //----------------------------------------------------------------------------------------------------------------
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        createShareButton()
    }

    class func create(albumPhoto: AlbumPhoto) -> ImageViewerViewController {
        let viewController = ImageViewerViewController()
        let imageViewerView = ImageViewerView(albumPhoto: albumPhoto)
        viewController.title = albumPhoto.title
        viewController.imageViewerView = imageViewerView
        return viewController
    }

    //----------------------------------------------------------------------------------------------------------------
    //=======>MARK: -  Private methods ...
    //----------------------------------------------------------------------------------------------------------------
    
    private func createShareButton() {
        let config = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        let image = UIImage(systemName: L10n.shareButtonSystemIconName, withConfiguration: config)
        let shareButton = UIBarButtonItem(image: image, style: .plain, target: self, action: #selector(sharedButtonTapped))
        self.navigationItem.rightBarButtonItem = shareButton
    }
    
    @objc private func sharedButtonTapped() {
        guard let imageToShare = imageViewerView.imageView.image else { return }
        let descriptionItem = L10n.imageShareDescription 
        let imageToShareItem = ImageActivityItemSource(title: descriptionItem, image: imageToShare)
        let activityController = UIActivityViewController(activityItems: [imageToShareItem], applicationActivities: nil)
        activityController.popoverPresentationController?.sourceView = imageViewerView
        present(activityController, animated: true, completion: nil)
    }
}

import LinkPresentation

private class ImageActivityItemSource: NSObject, UIActivityItemSource {
    var title: String
    var image: UIImage
    
    init(title: String, image: UIImage) {
        self.title = title
        self.image = image
        super.init()
    }
    
    func activityViewControllerPlaceholderItem(_ activityViewController: UIActivityViewController) -> Any {
        return image
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, itemForActivityType activityType: UIActivity.ActivityType?) -> Any? {
        return image
    }
    
    func activityViewController(_ activityViewController: UIActivityViewController, subjectForActivityType activityType: UIActivity.ActivityType?) -> String {
        return title
    }

    func activityViewControllerLinkMetadata(_ activityViewController: UIActivityViewController) -> LPLinkMetadata? {
        let metadata = LPLinkMetadata()
        metadata.title = title
        metadata.iconProvider = NSItemProvider(object: image)
        return metadata
    }

}
