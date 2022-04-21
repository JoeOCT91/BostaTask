//
//  ProfileViewModel.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 19/04/2022.
//

import Foundation
import Combine

protocol ProfileViewModelProtocol: AnyObject {
    var isLoading: CurrentValueSubject<Bool, Never> { get }
    var randomUser: PassthroughSubject<User, Never> { get }
    var userAlbums: CurrentValueSubject<[Album], Never> { get }

}
class ProfileViewModel: ProfileViewModelProtocol{
    private var anyCancellable = Set<AnyCancellable>()
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var randomUser = PassthroughSubject<User, Never>()
    var userAlbums = CurrentValueSubject<[Album], Never>([Album]())
    
    init() {
        getUsersList()
        getUserData()
    }
    
    private func getUsersList() {
        NetworkManager.shared().getUsersList().sink { compilation  in
            print(compilation)
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
        .sink { completion  in
        } receiveValue: { [weak self] albumsList in
            guard let self = self else { return }
            self.userAlbums.send(albumsList)
        }.store(in: &anyCancellable)
    }
}
