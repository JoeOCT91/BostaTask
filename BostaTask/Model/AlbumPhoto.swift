//
//  AlbumPhoto.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 22/04/2022.
//

import Foundation

struct AlbumPhoto: Codable, Hashable {
    
    let uuid = UUID()
    let title: String
    let url: String
    let thumbnailUrl: String
    
    enum CodingKeys: String, CodingKey {
        case title
        case url
        case thumbnailUrl
    }
    
    static func == (lhs: AlbumPhoto, rhs: AlbumPhoto) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
