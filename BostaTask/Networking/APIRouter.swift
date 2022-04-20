//
//  File.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 20/04/2022.
//

import Foundation
import Moya

public enum APIRouter {
    case getUsers
    case getUser
    case getAlbum
}

extension APIRouter: TargetType {

    public var baseURL: URL {
        guard let url = URL(string: URLs.baseURL) else { fatalError() }
        return url
    }
    
    public var path: String {
        switch self {
        case .getUsers:
            return URLs.users
        case .getUser:
            return URLs.albums
        case .getAlbum:
            return URLs.photos
        }
    }
    
    public var method: Moya.Method {
            // Since all request is GET will return get for now :)
            return .get
    }
    
    public var task: Task {
        // Since no additional data to add to request will return planRequest fro now :)
        return .requestPlain
        }
    
    
    public var headers: [String : String]? {
        let headers = [
            HeaderKeys.contentType: "application/json",
            HeaderKeys.accept: "application/json"  
        ]
        return headers
    }


}
