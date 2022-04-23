//
//  AlbumTableViewCell.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 21/04/2022.
//

import UIKit
import Combine

class AlbumTableViewCell: UITableViewCell {
    
    private let albumTitleLabel = UILabel(frame: .zero)
    private let containerStack = UIStackView(frame: .zero)
    var subscriptions = Set<AnyCancellable>()
    let tapGesture = UITapGestureRecognizer(target: self, action: nil)
    
    private let padding: CGFloat = 18
    private let sepView: UIView = {
       let sepView = UIView()
        sepView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        sepView.backgroundColor = .gray
        return sepView
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.addGestureRecognizer(tapGesture)
        backgroundColor = .clear
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with album: Album) {
        albumTitleLabel.text = album.albumTitle
    }
    
    private func configureCell() {
        configureContainerStack()
        configureAlbumTitleLabel()
    }
    private func configureContainerStack() {
        contentView.addSubview(containerStack)
        containerStack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            containerStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding),
            containerStack.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: padding),
            containerStack.rightAnchor.constraint(equalTo: contentView.rightAnchor, constant: -padding),
            containerStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
        let stackViews = [sepView, albumTitleLabel]
        stackViews.forEach { view in
            containerStack.addArrangedSubview(view)
        }
        containerStack.axis = .vertical
        containerStack.spacing = padding
    }
    
    private func configureAlbumTitleLabel() {
        albumTitleLabel.font = .systemFont(ofSize: 18, weight: .regular)
        albumTitleLabel.minimumScaleFactor = 0.75
    }
}
