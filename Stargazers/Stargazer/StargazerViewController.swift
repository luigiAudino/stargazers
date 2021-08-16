//
//  StargazerViewController.swift
//  Stargazers
//
//  Created by Luigi Audino on 11/08/21.
//

import UIKit

protocol StargazerProtocol {
    func searchStargazer(owner: String, repository: String, perPage: Int)
    func dismissStargazer()
}

class StargazerViewController: UIViewController {

    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var loadBtn: UIButton!
    @IBOutlet weak var ownerTxtField: UITextField!
    @IBOutlet weak var repoTxtField: UITextField!
    @IBOutlet weak var perPageSlider: UISlider!
    @IBOutlet weak var perPageLbl: UILabel!
    
    private var repowners = [Repowner]()
    private var perPageDefault: Float = 30.0
    
    var delegate: StargazerProtocol!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        repowners = ModelData.load("mock.json")
        
        presentationController?.delegate = self
        ownerTxtField.delegate = self
        repoTxtField.delegate = self
                
        ownerTxtField.clearButtonMode = .always
        repoTxtField.clearButtonMode = .always

        searchBtn.setCorner()
        loadBtn.setCorner(borderColor: .orange)
        
        perPageSlider.value = perPageDefault
        
        perPageLbl.text = Int(perPageSlider.value).description
    }
    
    @IBAction func perPageSliderChanged(_ sender: UISlider) {
        let currentValue = Int(sender.value)
        perPageLbl.text = "\(currentValue)"
    }
    
    
    @IBAction func searchBtnPress(_ sender: Any) {
        print("Owner \(String(describing: ownerTxtField.text))")
        print("Repository \(String(describing: repoTxtField.text))")
        
        let owner = ownerTxtField.text ?? ""
        let repository = repoTxtField.text ?? ""
        let perPage = Int(perPageSlider.value)
        
        dismiss(animated: true) {
            print("Close")
            self.delegate.searchStargazer(owner: owner, repository: repository, perPage: perPage)
        }
    }
    
    @IBAction func loadBtnPress(_ sender: Any) {
        let index = Int.random(in: 0..<repowners.count)
        
        ownerTxtField.text = repowners[index].owner
        repoTxtField.text = repowners[index].repository
    }
    
    @IBAction func perPageScrollMove(_ sender: Any) {
    }
}

extension StargazerViewController: UIAdaptivePresentationControllerDelegate {
    func presentationControllerDidDismiss(_ presentationController: UIPresentationController) {
        self.delegate.dismissStargazer()
    }
}

extension StargazerViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        ownerTxtField.resignFirstResponder()
        repoTxtField.resignFirstResponder()
        
        return true
    }
}

