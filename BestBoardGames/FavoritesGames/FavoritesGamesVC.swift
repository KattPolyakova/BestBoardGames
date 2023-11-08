//
//  FavoritesGamesVC.swift
//  BestBoardGames
//
//  Created by Kate on 26.09.2023.
//

import UIKit

class FavoritesGamesVC: UIViewController {
    
    let service = GameListService()
    let flowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
    private let favoritesService = FavoritesService()
    lazy var collectionViewManager = CollectionViewManager(delegate: self)
    lazy var skeletonCollectionViewManager = SkeletonCollectionViewManager()
 
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(collectionView)
        
        collectionView.delegate = skeletonCollectionViewManager
        collectionView.dataSource = skeletonCollectionViewManager
        collectionView.isScrollEnabled = false
        
        collectionView.backgroundColor = Constants.backgroundColor
        
        self.navigationItem.title = Constants.title
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        collectionView.register(FavoriteGameCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.register(SkeletonCollectionViewCell.self, forCellWithReuseIdentifier: "SkeletonCollectionViewCell")
        
        flowLayout.minimumLineSpacing = Constants.minimumItemSpacing
        flowLayout.minimumInteritemSpacing = Constants.minimumItemSpacing
        flowLayout.scrollDirection = .vertical

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 6) { [self] in
            self.service.fetchInformation(with: "", completion: fillData)
        }
    }
    
    func fillData(games: [Game]) {
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
