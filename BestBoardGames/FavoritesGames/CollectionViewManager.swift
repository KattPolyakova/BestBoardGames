//
//  CollectionViewManager.swift
//  BestBoardGames
//
//  Created by Kate on 07.11.2023.
//

import UIKit

class CollectionViewManager: NSObject {
    
    var savedGames: [Game] = []
    weak var delegate: GameListDelegate?
    
    init(delegate: GameListDelegate) {
        self.delegate = delegate
    }
}

extension CollectionViewManager: UICollectionViewDataSource {
    
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
}

extension CollectionViewManager: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
       
        delegate?.goToNextVC(row: indexPath.row)
    }
}

extension CollectionViewManager: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - Constants.insetsInRow * Constants.baseInset) / Constants.cellsInRow , height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.insets
    }
}

extension CollectionViewManager {
    enum Constants {
        static let baseInset: CGFloat = 10
        static let insets = UIEdgeInsets(top: baseInset, left: baseInset, bottom: baseInset, right: baseInset)
        static let cellHeight: CGFloat = 195
        static let cellsInRow: CGFloat = 2
        static let insetsInRow = cellsInRow + 1
    }
}
