//
//  Address.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 21/04/2022.
//

import Foundation

struct Address: Codable {
    
    let street: String
    let suite: String
    let city: String
    let zipCode: String?
    
    var fullAddress: String {
        get {
            var address = "\(street), \(suite), \(city)"
            guard let zipCode = zipCode else { return address }
            address.append(contentsOf: ", \(zipCode)")
            return address
        }
    }
}
