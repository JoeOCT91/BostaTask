//
//  Album.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 21/04/2022.
//

import Foundation

struct Album: Codable, Hashable {
    let uuid = UUID()
    let userId: Int
    let albumId: Int
    let albumTitle: String
    
    enum CodingKeys: String, CodingKey {
        case userId
        case albumId = "id"
        case albumTitle = "title"
    }
    
    static func == (lhs: Album, rhs: Album) -> Bool {
        return lhs.uuid == rhs.uuid
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(uuid)
    }
}
