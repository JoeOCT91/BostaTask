//
//  ProfileViewModel.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 19/04/2022.
//

import Foundation
import Combine
import SwiftUI

protocol ProfileViewModelProtocol: AnyObject {
    var isLoading: CurrentValueSubject<Bool, Never> { get }
}
class ProfileViewModel: ProfileViewModelProtocol{
    
    var isLoading = CurrentValueSubject<Bool, Never>(false)
    var randomUser = PassthroughSubject<User, Never>()
    var usersList = PassthroughSubject<[User], Never>()
    
    init() {
        getUsersList()
    }
    
    
    private func getUsersList() {
        
    }
    
    private func getUserData() {
        
    }
    
}
