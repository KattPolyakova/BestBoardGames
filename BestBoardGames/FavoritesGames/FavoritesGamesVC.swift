//
//  FavoritesGamesVC.swift
//  BestBoardGames
//
//  Created by Kate on 26.09.2023.
//

import UIKit

final class FavoritesGamesVC: UIViewController {
    
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
    
    let flowLayout = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = Constants.minimumItemSpacing
        flowLayout.minimumInteritemSpacing = Constants.minimumItemSpacing
        flowLayout.scrollDirection = .vertical
        return flowLayout
    }()
    
    lazy var collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
    private let favoritesService = FavoritesService()
    
    lazy var collectionViewManager = CollectionViewManager(delegate: self)
    lazy var skeletonCollectionViewManager = SkeletonCollectionViewManager()
    
    private let refreshControl = UIRefreshControl()
    
    let service = GameListService()
    private let warningView = WarningView(frame: .zero)
 
    override func viewDidLoad() {
        super.viewDidLoad()
        state = .loading
        
        view.addSubview(collectionView)
        view.addSubview(warningView)
        
        warningView.reload = reload
        
        collectionView.backgroundColor = Constants.backgroundColor
        view.backgroundColor = .white
        addConstraints()
        
        self.navigationItem.title = Constants.title
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        collectionView.register(FavoriteGameCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.register(SkeletonCollectionViewCell.self, forCellWithReuseIdentifier: "SkeletonCollectionViewCell")
        
        self.collectionView.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
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
        warningView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(self.view.safeAreaLayoutGuide.snp.bottom)
        }
    }
    
    func showLoading() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [self] in
            self.service.fetchInformation(with: "", completion: fillData)
        }
        collectionView.delegate = skeletonCollectionViewManager
        collectionView.dataSource = skeletonCollectionViewManager
        collectionView.isScrollEnabled = false
        warningView.isHidden = true
        collectionView.isHidden = false
        collectionView.reloadData()
    }
    
    func showGames(games: [Game]) {
        warningView.isHidden = true
        collectionView.isHidden = false

        collectionViewManager.savedGames = []
        collectionView.dataSource = collectionViewManager
        collectionView.delegate = collectionViewManager
        collectionView.isScrollEnabled = true
    
        for i in 0..<games.count {
            if favoritesService.checkFavorites(data: .init(gameId: games[i].gameId)) {
                collectionViewManager.savedGames.append(games[i])
            }
        }
        collectionView.reloadData()
        self.collectionView.refreshControl?.endRefreshing()
    }
    
    func showWarning(text: String) {
        warningView.isHidden = false
        collectionView.isHidden = true
        warningView.updateText(text: text)
    }
    
    func reload() {
        state = .loading
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.service.fetchInformation(with: "", completion: fillData)
        self.collectionView.reloadData()
    }
}

extension FavoritesGamesVC {
    enum Constants {
        static let title = "Favorites"
        static let backgroundColor = UIColor(hex: 0xD9D9D9)
        static let minimumItemSpacing: CGFloat = 10
    }
}

extension FavoritesGamesVC: GameListDelegate {
    
    var games: [Game] {
        collectionViewManager.savedGames
    }
    
    func goToNextVC(row: Int) {
        let gameDescriptionViewController = GameDescriptionViewController()
        gameDescriptionViewController.gameId = games[row].gameId
        navigationController?.pushViewController(gameDescriptionViewController, animated: true)
    }
}
