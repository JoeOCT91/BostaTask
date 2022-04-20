//
//  NetworkManager.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 20/04/2022.
//

import Foundation
import Combine
import Moya

class NetworkManager {
    
    private var provider = MoyaProvider<APIRouter>(plugins: [NetworkLoggerPlugin()])
    private static let sharedInstance = NetworkManager()
    
    class func shared() -> NetworkManager {
        return NetworkManager.sharedInstance
    }
    
    // Private Init
    private init() {}
    
    func getUsersList() -> Future<[User], Error> {
        return request(target: APIRouter.getUsers)
    }
}

private extension NetworkManager {
    private func request<T: Decodable>(target: APIRouter) -> Future<T, Error>  {
        return Future { [weak self] promise in
            guard let self = self else { return }
            self.provider.request(target) { result in
                switch result {
                case .success(let response):
                    do {
                        try promise(.success(response.map(T.self)))
                    } catch {
                        promise(.failure(error))
                    }
                case .failure(let error):
                    promise(.failure(error))
                }
            }
        }
    }

}
