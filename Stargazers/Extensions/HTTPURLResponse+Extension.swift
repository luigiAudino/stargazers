//
//  HTTPURLResponse+Extension.swift
//  Stargazers
//
//  Created by Luigi Audino on 10/08/21.
//

import Foundation

extension HTTPURLResponse {
  var hasSuccessStatusCode: Bool {
    return 200...299 ~= statusCode
  }
}
