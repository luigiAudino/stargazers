//
//  StargazerViewController.swift
//  Stargazers
//
//  Created by Luigi Audino on 09/08/21.
//

import UIKit

class StargazerListViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var clearView: UIView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var stargazers = [Stargazer]()
    private var identifier = Constant.Cell.stargazerCell
    private var currentPage = 1
    private var isLoading = false
    private var isFinished = false
    private var owner: String?
    private var repository: String?
    private var perPage: Int = 30
    private var placeholder = "Clicca in alto a destra per effettuare una ricerca!"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        guard let _ = owner, let _ = repository else { return }
        
        self.fetchData()
    }
    
    @IBAction func searchBarBtnPress(_ sender: Any) {
        startIndicator()
        
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        if let vc = storyboard.instantiateViewController(withIdentifier: "StargazerViewController") as? StargazerViewController {
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        }
        
    }
    
    private func fetchData() {
        guard let owner = owner, let repository = repository else { return }
        
        RequestManager.instance.getStargazers(owner: owner, repository: repository, perPage: perPage, page: currentPage) { (result) in
            switch result {
            case .success(let stargazerResponse):
                
                DispatchQueue.main.async {
                    self.isFinished = stargazerResponse.isEmpty
                    self.stargazers.append(contentsOf: stargazerResponse)
                }
                
            case .failure(let error):                
                self.placeholder = error == .notFound ? "Nessun risultato" : "Si è verificato un errore"
            }
            
            DispatchQueue.main.async {
                self.isLoading = false
                
                self.tableview.reloadData()
                
                if(self.activityIndicator.isAnimating) {
                    self.stopIndicator()
                }
            }
            
        }
    }
    
    private func fetchNextPage() {
        isLoading = true
        currentPage += 1
        print ("page --->\(currentPage)")
        fetchData()
    }
    
    private func initTableView() {
        tableview.delegate = self
        tableview.dataSource = self
        tableview.prefetchDataSource = self
        
        let uiNib = UINib(nibName: "StargazerTableViewCell", bundle: nil)
        tableview.register(uiNib, forCellReuseIdentifier: identifier)
        
        tableview.allowsSelection = false
    }
    
    private func startIndicator() {
        clearView.isHidden = false
        activityIndicator.startAnimating()
    }
    
    private func stopIndicator() {
        clearView.isHidden = true
        activityIndicator.stopAnimating()
    }
}

extension StargazerListViewController: UITableViewDelegate {
    
}

extension StargazerListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if(stargazers.count == 0) {
            tableView.setEmptyView(title: "Attenzione", message: placeholder)
        }
        else {
            tableView.restore()
        }
        
        return stargazers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableview.dequeueReusableCell(withIdentifier: identifier, for: indexPath) as! StargazerTableViewCell
        
        if(isLoading && tableview.numberOfRows(inSection: indexPath.section) > stargazers.count) {
            cell.configure(with: .none)
        }
        else {
            cell.configure(with: stargazers[indexPath.row])
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if false && indexPath.row == stargazers.count - 10 && !isLoading{
            fetchNextPage()
        }
    }
    
}

extension StargazerListViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        print("prefetchRowsAt \(indexPaths)")
                
        let needsFetch = indexPaths.last?.row == stargazers.count - 1
        if needsFetch && !isLoading && !isFinished {
            fetchNextPage()
        }
        
        
    }
    
}

extension StargazerListViewController: StargazerProtocol {
    func searchStargazer(owner: String, repository: String, perPage: Int) {
        self.owner = owner
        self.repository = repository
        self.perPage = perPage
        
        stargazers.removeAll()
        isFinished = false
        currentPage = 1
        
        if(self.owner == "" || self.repository == "") {
            placeholder = "Inserisci owner e repository"
            tableview.reloadData()
            stopIndicator()
        }
        else {
            fetchData()
        }
    }
    
    func dismissStargazer() {
        stopIndicator()
    }
    
}
