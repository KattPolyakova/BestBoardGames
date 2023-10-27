//
//  ViewController.swift
//  BestBoardGames
//
//  Created by Kate on 26.05.2023.
//

import UIKit
import SnapKit
import Alamofire
class TableViewDataSource2 {
    
}
class MyViewController: UIViewController {
    
    let tableView = UITableView()
    lazy var tableViewDataSource = TableViewDataSource()
    lazy var tableViewDataSource2 = TableViewDataSource2()
    lazy var tableViewDelegate = TableViewDelegate(delegate: self)

    
    lazy var skeletonTableViewDataSource = SkeletonTableViewDataSource()
    lazy var skeletonTableViewDelegate = SkeletonTableViewDelegate()
    
    private let service = GameListService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(tableView)
        
        tableView.dataSource = skeletonTableViewDataSource
        tableView.delegate = skeletonTableViewDelegate
        tableView.isScrollEnabled = false
       
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            self.service.fetchInformation(with: "", completion: fillData)
        }

        
        tableView.backgroundColor = UIColor(hex: 0xD9D9D9)
        
        tableView.snp.makeConstraints { (make) -> Void in
            
            make.bottom.left.right.top.equalToSuperview()
        }
        
        self.navigationItem.title = "Games"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        self.tableView.register(SkeletonViewCell.self, forCellReuseIdentifier: "SkeletonViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func fillData(games: [Game]) {
        self.tableViewDataSource.savedGames = games
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.isScrollEnabled = true
        self.tableView.reloadData()
    }
    
//    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
//            let item = UIContextualAction(style: .destructive, title: "Delete") {  (contextualAction, view, boolValue) in
//                //Write your code in here
//            }
//            item.image = UIImage(named: "heart_empty")
//
//            let swipeActions = UISwipeActionsConfiguration(actions: [item])
//        
//            return swipeActions
//        }
}



extension MyViewController: NavigationDelegate {
    func goToNextVC(row: Int) {
        
        let vc = GameDescriptionViewController()
        vc.gameId = tableViewDataSource.savedGames[row].gameId
        navigationController?.pushViewController(vc, animated: true)   
    }
}
