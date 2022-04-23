//
//  Combine+Dictionary.swift
//  BostaTask
//
//  Created by Yousef Mohamed on 22/04/2022.
//

import Combine
import Foundation

extension AnyCancellable {
    func store(in dictionary: inout [IndexPath: AnyCancellable], for key: IndexPath) {
        dictionary[key] = self
    }
}
