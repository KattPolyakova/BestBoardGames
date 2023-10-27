//
//  FavoritesGamesVC.swift
//  BestBoardGames
//
//  Created by Kate on 26.09.2023.
//

import UIKit

class FavoritesGamesVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    let service = GameListService()
    let flowLayout = UICollectionViewFlowLayout()
    lazy var collectionView = UICollectionView(frame: self.view.bounds, collectionViewLayout: flowLayout)
    var savedGames: [Game] = []
    private let favoritesService = FavoritesService()
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.title = "Favorites"
        self.navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor: UIColor.black]
        
        collectionView.register(FavoriteGameCell.self, forCellWithReuseIdentifier: "collectionCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor(hex: 0xF3F3F3)
        
        
        flowLayout.minimumLineSpacing = 10
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.scrollDirection = .vertical

        self.view.addSubview(collectionView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        service.fetchInformation(with: "", completion: fillData)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = savedGames.count
        return count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "collectionCell", for: indexPath as IndexPath) as! FavoriteGameCell
        let game = savedGames[indexPath.row]
        cell.configure(game: .init(name: game.name, imageString: game.imageString))
        cell.backgroundColor = .white
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: self.view.frame.width/2 - 15, height: 195)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    func fillData(games: [Game]) {
        savedGames = []
    
        for i in 0..<games.count {
            if favoritesService.checkFavorites(data: .init(gameId: games[i].gameId)) {
                savedGames.append(games[i])
            }
        }
        collectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let gameDescriptionViewController = GameDescriptionViewController()
        gameDescriptionViewController.gameId = savedGames[indexPath.row].gameId
        navigationController?.pushViewController(gameDescriptionViewController, animated: true)
    }
    
}
