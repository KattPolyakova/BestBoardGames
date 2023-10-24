//
//  FavoritesGamesVC.swift
//  BestBoardGames
//
//  Created by Kate on 26.09.2023.
//

import UIKit

class FavoritesGamesVC: UIViewController {
    
    var myCollectionView:UICollectionView?
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            let view = UIView()
            view.backgroundColor = UIColor(hex: 0xD9D9D9)
            
            let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
            layout.sectionInset = UIEdgeInsets(top: 20, left: 10, bottom: 10, right: 10)
            layout.itemSize = CGSize(width: 60, height: 60)
            
            myCollectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
            myCollectionView?.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "MyCell")
            myCollectionView?.backgroundColor = UIColor.white
            view.addSubview(myCollectionView ?? UICollectionView())
            
            self.view = view
    }
}
