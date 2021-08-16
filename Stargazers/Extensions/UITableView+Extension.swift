//
//  UITableView+Extension.swift
//  Stargazers
//
//  Created by Luigi Audino on 10/08/21.
//

import UIKit

extension UITableView {
    func setEmptyView(title: String, message: String) {
        let emptyView = UIView(frame: CGRect(x: self.center.x, y: self.center.y, width: self.bounds.size.width, height: self.bounds.size.height))
        
        let titleLabel = UILabel()
        let messageLabel = UILabel()
        
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        messageLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.textColor = UIColor.label
        titleLabel.font = UIFont(name: "HelveticaNeue-Bold", size: 18)
        messageLabel.textColor = UIColor.label
        messageLabel.font = UIFont(name: "HelveticaNeue-Regular", size: 17)
        
        let stackView   = UIStackView()
        stackView.axis  = NSLayoutConstraint.Axis.vertical
        stackView.distribution  = UIStackView.Distribution.equalCentering
        stackView.alignment = UIStackView.Alignment.center
        stackView.spacing = 10.0
        
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(messageLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false

        emptyView.addSubview(stackView)
        
        stackView.centerXAnchor.constraint(equalTo: emptyView.centerXAnchor).isActive = true
        stackView.centerYAnchor.constraint(equalTo: emptyView.centerYAnchor).isActive = true
        
        stackView.topAnchor.constraint(greaterThanOrEqualTo: emptyView.topAnchor, constant: 30).isActive = false
        stackView.bottomAnchor.constraint(greaterThanOrEqualTo: emptyView.bottomAnchor, constant: 30).isActive = false
        stackView.leftAnchor.constraint(greaterThanOrEqualTo: emptyView.leftAnchor, constant: 30).isActive = true
        stackView.rightAnchor.constraint(greaterThanOrEqualTo: emptyView.rightAnchor, constant: -30).isActive = true

        titleLabel.text = title
        messageLabel.text = message
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center

        self.backgroundView = emptyView
        self.separatorStyle = .none
    }
    
    func restore() {
        self.backgroundView = nil
        self.separatorStyle = .singleLine
    }

}
