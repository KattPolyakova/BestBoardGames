//
//  SkeletonCollectionViewCell.swift
//  BestBoardGames
//
//  Created by Kate on 07.11.2023.
//

import UIKit

class SkeletonCollectionViewCell: UICollectionViewCell {
    
    let nameLabelView = UIView()
    let nameLabelView2 = UIView()
    let gameImageView = UIView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCell() {
        
        nameLabelView.backgroundColor = UIColor(hex: 0xC4C4C4)
        nameLabelView.layer.cornerRadius = 10
        
        nameLabelView2.backgroundColor = UIColor(hex: 0xC4C4C4)
        nameLabelView2.layer.cornerRadius = 10
                                                
//        gameImageView.contentMode = .scaleAspectFill
//        gameImageView.clipsToBounds = true
        gameImageView.backgroundColor = UIColor(hex: 0xC4C4C4)
        
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        addSubview(gameImageView)
        addSubview(nameLabelView)
        addSubview(nameLabelView2)
        
        gameImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalToSuperview().offset(-72)
        }
        
        nameLabelView.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.top.equalTo(gameImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(nameLabelView2.snp.top).offset(-9)
        }
        
        nameLabelView2.snp.makeConstraints { make in
            make.height.equalTo(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
}

