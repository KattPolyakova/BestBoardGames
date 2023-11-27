//
//  ViewController.swift
//  BestBoardGames
//
//  Created by Kate on 26.05.2023.
//

import UIKit
import SnapKit
import Alamofire

final class MyViewController: UIViewController {
    
    enum State {
        case loading
        case normal([Game])
        case warning(String)
    }
    
    private var state = State.loading {
        didSet {
            switch state {
            case .loading:
                showLoading()
            case .normal(let games):
                showGames(games: games)
            case .warning(let message):
                showWarning(text: message)
            }
        }
    }
    
    private let tableView = UITableView()
    private lazy var tableViewDataSource = TableViewDataSource()
    private lazy var tableViewDelegate = TableViewDelegate(delegate: self)
    
    private lazy var skeletonTableViewDataSource = SkeletonTableViewDataSource()
    private lazy var skeletonTableViewDelegate = SkeletonTableViewDelegate()
    
    private let service = GameListService()
    private let warningView = WarningView(frame: .zero)
    
    private lazy var filterBarButtonItem = UIBarButtonItem(image: UIImage(named: "filter"),
                                                      style: .plain, target: self,
                                                      action: #selector(onFilterButtonClicked))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .loading
        
        view.addSubview(tableView)
        view.addSubview(warningView)
        
        warningView.reload = reload
        
        
        self.navigationItem.rightBarButtonItem  = filterBarButtonItem
        
        view.backgroundColor = .white
        tableView.backgroundColor = UIColor(hex: 0xD9D9D9)
        addConstraints()
        
        self.navigationItem.title = "Games"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        self.tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "CustomTableViewCell")
        self.tableView.register(SkeletonViewCell.self, forCellReuseIdentifier: "SkeletonViewCell")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    func fillData(completionType: CompletionType<[Game]>) {
        switch completionType {
        case .success(let games):
            state = .normal(games)
        case .error(let errorString):
            state = .warning(errorString)
        }
    }
    
    func addConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        warningView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            self.service.fetchInformation(with: "", completion: fillData)
        }
        tableView.dataSource = skeletonTableViewDataSource
        tableView.delegate = skeletonTableViewDelegate
        tableView.isScrollEnabled = false
        warningView.isHidden = true
        tableView.isHidden = false
        filterBarButtonItem.isHidden = true
        tableView.reloadData()
    }
    
    func showGames(games: [Game]) {
        warningView.isHidden = true
        tableView.isHidden = false
        filterBarButtonItem.isHidden = false

        self.tableViewDataSource.savedGames = games
        self.tableViewDataSource.filteredGames = games
        tableView.dataSource = tableViewDataSource
        tableView.delegate = tableViewDelegate
        tableView.isScrollEnabled = true
        self.tableView.reloadData()
    }
    
    func showWarning(text: String) {
        warningView.isHidden = false
        tableView.isHidden = true
        filterBarButtonItem.isHidden = true
        warningView.updateText(text: text)
    }
    
    func reload() {
        state = .loading
    }
    
    @objc func onFilterButtonClicked(_ sender: Any){
        let filterVC = FilterVC()
        filterVC.games = tableViewDataSource.savedGames
        filterVC.showFilteredGames = showFilteredGames
        present(filterVC, animated: true)
    }
    
    func showFilteredGames(games: [Game]) {
        tableViewDataSource.filteredGames = games
        self.tableView.reloadData()
    }
}

extension MyViewController: GameListDelegate {
    var games: [Game] {
        tableViewDataSource.savedGames
    }
    
    func goToNextVC(row: Int) {
        
        let vc = GameDescriptionViewController()
        vc.gameId = tableViewDataSource.filteredGames[row].gameId
        navigationController?.pushViewController(vc, animated: true)
    }
}
