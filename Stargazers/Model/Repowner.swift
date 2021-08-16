//
//  Repowner.swift
//  Stargazers
//
//  Created by Luigi Audino on 12/08/21.
//

import Foundation

struct Repowner: Codable {
    var owner: String
    var repository: String
    
    init(owner: String, repository: String) {
        self.owner = owner
        self.repository = repository
    }
}
