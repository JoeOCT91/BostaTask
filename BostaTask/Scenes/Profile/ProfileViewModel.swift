//
//  ProfileViewModel.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 19/04/2022.
//

import Foundation
import Combine

protocol ProfileViewModelProtocol: AnyObject {
    
    var errorOccurredObserver: PassthroughSubject<Error, Never> { get }
    var isLoadingObserver: CurrentValueSubject <Bool, Never> { get }
    var randomUser: PassthroughSubject<User, Never> { get }
    var userAlbums: CurrentValueSubject<[Album], Never> { get }

}
class ProfileViewModel: ProfileViewModelProtocol {
    
    private var anyCancellable = Set<AnyCancellable>()
    var errorOccurredObserver = PassthroughSubject<Error, Never>()
    var isLoadingObserver = CurrentValueSubject<Bool, Never>(false)
    var randomUser = PassthroughSubject<User, Never>()
    var userAlbums = CurrentValueSubject<[Album], Never>([Album]())
    
    init() {
        getUsersList()
        getUserData()
    }
    
    private func getUsersList() {
        isLoadingObserver.send(true)
        NetworkManager.shared().getUsersList()
            .sink { [weak self] completion  in
                guard let self = self else { return }
                guard case let .failure(error) = completion else { return }
                self.isLoadingObserver.send(false)
                self.errorOccurredObserver.send(error)
            } receiveValue: { [weak self] usersList in
                guard let self = self else { return }
                guard let randomUser = usersList.randomElement() else { return }
                self.randomUser.send(randomUser)
            }.store(in: &anyCancellable)
    }
    
    private func getUserData() {
        randomUser.map {
            NetworkManager.shared().getUserAlbums(userId: $0.id)
        }
        .flatMap({ $0 })
        .sink { [weak self] completion  in
            guard let self = self else { return }
            self.isLoadingObserver.send(false)
            guard case let .failure(error) = completion else { return }
            self.errorOccurredObserver.send(error)
        } receiveValue: { [weak self] albumsList in
            guard let self = self else { return }
            self.userAlbums.send(albumsList)
            self.randomUser.send(completion: .finished)
        }.store(in: &anyCancellable)
    }
}
