//
//  APIRouter.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 20/04/2022.
//

import Foundation
import Moya

public enum APIRouter {
    case getUsers
    case getUserAlbums(_ userId: Int)
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
        case .getUserAlbums:
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
        switch self {
        case .getUserAlbums(let userId):
            let parameters = [ParametersKeys.userId: userId]
            return .requestParameters(parameters: parameters, encoding: URLEncoding.default)
        default:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        let headers = [
            HeaderKeys.contentType: "application/json",
            HeaderKeys.accept: "application/json"  
        ]
        return headers
    }
}
