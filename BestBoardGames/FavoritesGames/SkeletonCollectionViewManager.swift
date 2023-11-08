//
//  SkeletonCollectionViewDataSource.swift
//  BestBoardGames
//
//  Created by Kate on 07.11.2023.
//

import UIKit
import SnapKit

class SkeletonCollectionViewManager: NSObject, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "SkeletonCollectionViewCell", for: indexPath) as? SkeletonCollectionViewCell else { return UICollectionViewCell() }
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width - Constants.insetsInRow * Constants.baseInset) / Constants.cellsInRow , height: Constants.cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return Constants.insets
    }
}

extension SkeletonCollectionViewManager {
    enum Constants {
        static let baseInset: CGFloat = 10
        static let insets = UIEdgeInsets(top: baseInset, left: baseInset, bottom: baseInset, right: baseInset)
        static let cellHeight: CGFloat = 195
        static let cellsInRow: CGFloat = 2
        static let insetsInRow = cellsInRow + 1
    }
}
