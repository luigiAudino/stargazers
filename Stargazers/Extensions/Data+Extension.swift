//
//  Data+Extension.swift
//  Stargazers
//
//  Created by Luigi Audino on 09/08/21.
//

import Foundation

extension Data {
    func toString() -> String {
        return String(decoding: self, as: UTF8.self)
    }
}
