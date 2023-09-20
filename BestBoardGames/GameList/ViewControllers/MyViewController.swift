//
//  ViewController.swift
//  BestBoardGames
//
//  Created by Kate on 26.05.2023.
//

import UIKit
import SnapKit
import Alamofire

class MyViewController: UIViewController {
    
    let tableView = UITableView()
    lazy var tableViewDataSource = TableViewDataSource()
    lazy var tableViewDelegate = TableViewDelegate(delegate: self)
    
    private let service = GameListService()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate

        
        service.fetchInformation(with: "", completion: fillData)
        
        
        tableView.backgroundColor = .black
        tableView.snp.makeConstraints { (make) -> Void in
            
            make.bottom.left.right.top.equalToSuperview()
        }
        
        self.navigationItem.title = "Games"
        
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.orange]
        
        self.tableView.register(UITableViewCell.self, forCellReuseIdentifier: "UITableViewCell")
    }
    
    func fillData(games: [Game]) {
        self.tableViewDataSource.savedGames = games
        self.tableView.reloadData()
    }
}



extension MyViewController: NavigationDelegate {
    func goToNextVC(row: Int) {
        
        let vc = GameDescriptionViewController()
        vc.gameId = tableViewDataSource.savedGames[row].gameId
        navigationController?.pushViewController(vc, animated: true)
        
    }
    
    
}
