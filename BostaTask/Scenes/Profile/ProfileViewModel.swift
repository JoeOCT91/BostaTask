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
}
class ProfileViewModel: ProfileViewModelProtocol{
    private var anyCancellable = Set<AnyCancellable>()
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var randomUser = PassthroughSubject<User, Never>()
    
    init() {
        getUsersList()
    }
    
    
    private func getUsersList() {
        NetworkManager.shared().getUsersList().sink { compilation  in
            print(compilation)
        } receiveValue: { [weak self] usersList in
            guard let self = self else { return }
            guard let randomUser = usersList.randomElement() else { return }
            self.randomUser.send(randomUser)
            print(randomUser.address)
        }.store(in: &anyCancellable)
    }
    
    private func getUserData() {
        randomUser.sink  { user in
            NetworkManager.shared().getUsersList()
        }

        
        
    }
    
}
