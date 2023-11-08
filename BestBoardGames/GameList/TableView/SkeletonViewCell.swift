//
//  SkeletonViewCell.swift
//  BestBoardGames
//
//  Created by Kate on 25.09.2023.
//

import UIKit

class SkeletonViewCell: UITableViewCell {

    let nameLabelSkeleton = UIView()
    let nameLabelSkeleton2 = UIView()
    let yearPublishedLabelSkeleton = UIView()
    let gameImageViewSkeleton = UIView()
    let viewSkeleton = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCell() {
        backgroundColor = UIColor(hex: 0xD9D9D9)
        
        nameLabelSkeleton.backgroundColor = UIColor(hex: 0xC4C4C4)
        nameLabelSkeleton.layer.cornerRadius = 10
        
        nameLabelSkeleton2.backgroundColor = UIColor(hex: 0xC4C4C4)
        nameLabelSkeleton2.layer.cornerRadius = 10
        
        yearPublishedLabelSkeleton.backgroundColor = UIColor(hex: 0xEFEFEF)
        yearPublishedLabelSkeleton.layer.cornerRadius = 10
        
        gameImageViewSkeleton.backgroundColor =  UIColor(hex: 0xC4C4C4)
        
        viewSkeleton.backgroundColor = .white
        viewSkeleton.layer.cornerRadius = 10
        viewSkeleton.clipsToBounds = true
        
        addSubview(viewSkeleton)
        viewSkeleton.addSubview(gameImageViewSkeleton)
        viewSkeleton.addSubview(nameLabelSkeleton)
        viewSkeleton.addSubview(nameLabelSkeleton2)
        viewSkeleton.addSubview(yearPublishedLabelSkeleton)
        
        viewSkeleton.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        gameImageViewSkeleton.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(gameImageViewSkeleton.snp.height)
        }
        
        nameLabelSkeleton.snp.makeConstraints { make in
            make.top.equalTo(viewSkeleton).offset(14)
            make.left.equalTo(gameImageViewSkeleton.snp.right).offset(10)
            make.right.equalTo(viewSkeleton).offset(-10)
            make.bottom.equalTo(viewSkeleton).offset(-66)
        }
        
        nameLabelSkeleton2.snp.makeConstraints { make in
            make.top.equalTo(viewSkeleton).offset(42)
            make.left.equalTo(gameImageViewSkeleton.snp.right).offset(10)
            make.right.equalTo(viewSkeleton).offset(-10)
            make.bottom.equalTo(viewSkeleton).offset(-38)
        }
        
        yearPublishedLabelSkeleton.snp.makeConstraints { make in
            make.top.equalTo(viewSkeleton).offset(71)
            make.right.equalTo(viewSkeleton).offset(-5)
            make.bottom.equalTo(viewSkeleton).offset(-9)
            make.left.equalTo(viewSkeleton).offset(318)
        }
    }
}
