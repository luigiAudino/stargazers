//
//  UiView+Extension.swift
//  Stargazers
//
//  Created by Luigi Audino on 10/08/21.
//

import UIKit

extension UIView {
    func setCorner(cornerRadius: CGFloat = 10, borderWidth: CGFloat = 1, borderColor: UIColor = UIColor.gray) {
        self.layer.cornerRadius = cornerRadius
        self.layer.borderWidth = borderWidth
        self.layer.borderColor = borderColor.cgColor
    }
    
    func setShadow(shadowColor: UIColor = UIColor.black, shadowOpacity: Float = 1, shadowOffset: CGSize = .zero, shadowRadius: CGFloat = 10) {
        self.layer.shadowColor = shadowColor.cgColor
        self.layer.shadowOpacity = shadowOpacity
        self.layer.shadowOffset = shadowOffset
        self.layer.shadowRadius = shadowRadius
        self.layer.shouldRasterize = true
    }
}
