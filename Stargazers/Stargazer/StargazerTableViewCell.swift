//
//  StargazerTableViewCell.swift
//  Stargazers
//
//  Created by Luigi Audino on 09/08/21.
//

import UIKit
import Kingfisher

class StargazerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var background: UIView!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        indicatorView.hidesWhenStopped = true
        indicatorView.color = .white
        
        background.setCorner()
        imgView.setCorner()
    }
    
    func configure(with stargazer: Stargazer?) {
        if let stargazer = stargazer {
            let avatar_url = stargazer.avatar_url
            
            imgView.kf.setImage(with: URL(string: avatar_url)) { [self] result in
                switch result {
                case .success(let value):
                    self.imgView.image = value.image
                case .failure(let error):
                    print(error)
                }
            
                DispatchQueue.main.async {
                    lbl?.text = stargazer.login
                    
                    imgView.alpha = 1
                    lbl.alpha = 1
                    
                    indicatorView.stopAnimating()
                }
            }
        } else {
            imgView.alpha = 0
            lbl.alpha = 0
            
            indicatorView.startAnimating()
        }
    }
    
    
}
