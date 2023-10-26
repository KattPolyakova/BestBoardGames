//
//  CustomTableViewCell.swift
//  BestBoardGames
//
//  Created by Kate on 19.09.2023.
//

import UIKit
import Kingfisher

class CustomTableViewCell: UITableViewCell {
    
    struct ViewModel {
        let name: String
        let yearPublished: Int
        let imageString: String
    }
    
    let nameLabel = UILabel()
    let yearPublishedLabel = UILabel()
    let gameImageView = UIImageView()
    let view = UIView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configCell()
    }
    
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configCell() {
        backgroundColor = .clear
        nameLabel.textColor = .black
        nameLabel.font = UIFont(name: "Arial", size: 24)
        yearPublishedLabel.textColor = .gray
        gameImageView.contentMode = .scaleAspectFill
        gameImageView.clipsToBounds = true
        view.backgroundColor = .white
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        addSubview(view)
        view.addSubview(gameImageView)
        view.addSubview(nameLabel)
        view.addSubview(yearPublishedLabel)
        
        view.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-5)
        }
        
        gameImageView.snp.makeConstraints { make in
            make.left.top.bottom.equalToSuperview()
            make.width.equalTo(gameImageView.snp.height)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(10)
            make.left.equalTo(gameImageView.snp.right).offset(10)
            make.right.equalTo(view).offset(-10)
            make.bottom.equalTo(view).offset(-30)
        }
        
        yearPublishedLabel.snp.makeConstraints { make in
            make.top.equalTo(view).offset(71)
            make.right.equalTo(view).offset(-5)
            make.bottom.equalTo(view).offset(-5)
        }
    }
    

    func configure(game: ViewModel){
        nameLabel.text = game.name
        yearPublishedLabel.text = String(game.yearPublished)
        let url = URL(string: game.imageString)
        self.gameImageView.kf.setImage(with: url)
    }
}

