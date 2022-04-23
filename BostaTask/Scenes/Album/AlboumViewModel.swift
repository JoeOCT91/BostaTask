//
//  AlboumViewController.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 19/04/2022.
//

import Foundation
import Combine

protocol AlbumPhotosViewModelProtocol: AnyObject{
    var albumPhotosList: CurrentValueSubject<[AlbumPhoto], Never> { get }
    var searchKeyWord:PassthroughSubject <String, Never> { set get }
    var album: Album { get }
}

class AlbumPhotosViewModel: AlbumPhotosViewModelProtocol {
    
    private var anyCancellable = Set<AnyCancellable>()
    private var originalAlbumPhotosList = [AlbumPhoto]()

    internal var searchKeyWord = PassthroughSubject <String, Never>()
    internal var albumPhotosList = CurrentValueSubject<[AlbumPhoto], Never>([AlbumPhoto]())
    internal let album: Album

    init(album: Album) {
        self.album = album
        fetchAlbumPhotos()
        bindToSearchKeyWordStream()
    }
    
    private func fetchAlbumPhotos() {
        NetworkManager.shared().getAlbumPhotos(albumId: album.albumId).sink { completion in
            print(completion)
        } receiveValue: { [weak self] photosList in
            guard let self = self else { return }
            self.originalAlbumPhotosList = photosList
            self.albumPhotosList.send(photosList)
            print(photosList.count)
        }.store(in: &anyCancellable)
    }
    
    func bindToSearchKeyWordStream() {
        searchKeyWord.sink { [weak self] searchKeyword in
            guard let self = self else { return }
            if !searchKeyword.isEmpty {
                let filteredAlbumPhotosList = self.originalAlbumPhotosList.filter { $0.title.contains(searchKeyword.lowercased()) }
                self.albumPhotosList.send(filteredAlbumPhotosList)
            } else {
                self.albumPhotosList.send(self.originalAlbumPhotosList)
            }
        }.store(in: &anyCancellable)
    }
    
    deinit {
        print("View model has been deinitlized \(String(describing: self))")
    }
    
}
