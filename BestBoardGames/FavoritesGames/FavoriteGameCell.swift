//
//  FavoriteGameCell.swift
//  BestBoardGames
//
//  Created by Kate on 25.10.2023.
//

import UIKit

class FavoriteGameCell: UICollectionViewCell {
    
    struct ViewModel {
        let name: String
        let imageString: String
    }
    
    let nameLabel = UILabel()
    let gameImageView = UIImageView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCell() {
        backgroundColor = .clear
        gameImageView.contentMode = .scaleAspectFill
        gameImageView.clipsToBounds = true
        nameLabel.textColor = .black
        nameLabel.font = UIFont(name: "Arial", size: 24)
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        
        addSubview(gameImageView)
        addSubview(nameLabel)
        
        gameImageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.bottom.equalTo(nameLabel.snp.top).offset(-17)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    func configure(game: ViewModel){
        nameLabel.text = game.name
        let url = URL(string: game.imageString)
        self.gameImageView.kf.setImage(with: url)
    }
}
