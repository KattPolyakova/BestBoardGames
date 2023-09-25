//
//  GameDescription.swift
//  BestBoardGames
//
//  Created by Kate on 01.06.2023.
//

import UIKit
import SnapKit
import Alamofire
import Kingfisher

class GameDescriptionViewController: UIViewController {
    
    var gameId = 0
    
    private let image = {
        let image = UIImageView()
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        return image
    }()
    private let nameLabel = {
        let nameLabel = UILabel()
        nameLabel.textColor = .orange
        nameLabel.font = Constants.titleFont
        nameLabel.numberOfLines = .zero
        return nameLabel
    }()
    private let ratingLabel = {
        let ratingLabel = UILabel()
        ratingLabel.textColor = .orange
        ratingLabel.font = Constants.titleFont
        return ratingLabel
    }()
    private let descriptionLabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .white
        descriptionLabel.numberOfLines = .zero
        return descriptionLabel
    }()
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    private let nameAndRatingView = UIView()
    private let scrollView = UIScrollView()
    private let service = GameDescriptionService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.fetchInformation(with: String(gameId), completion: fillData)
        view.backgroundColor = .black
        addSubViews()
        addConstraints()
    }
    
    func fillData(gameInformation: GameInformation) {
        self.nameLabel.text = gameInformation.name
        self.ratingLabel.text = String(format: "%.2f", gameInformation.rating)
        self.descriptionLabel.text = gameInformation.description
        let url = URL(string: gameInformation.image)
        self.image.kf.setImage(with: url)
    }
    
    private func addSubViews() {
        nameAndRatingView.addSubview(nameLabel)
        nameAndRatingView.addSubview(ratingLabel)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(nameAndRatingView)
        stackView.addArrangedSubview(descriptionLabel)
        stackView.addArrangedSubview(UIView())
        view.addSubview(scrollView)
    }
    
    private func addConstraints() {
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        stackView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalTo(view)
        }
        image.snp.makeConstraints { make in
            make.height.equalTo(Constants.imageHeight)
        }
        nameLabel.snp.makeConstraints { (make) -> Void in
            make.left.top.bottom.equalToSuperview()
        }
        ratingLabel.snp.makeConstraints { make in
            make.left.greaterThanOrEqualTo(self.nameLabel.snp.right).offset(10)
            make.top.equalTo(self.nameLabel.snp.top)
            make.right.equalToSuperview()
        }
    }
}

extension GameDescriptionViewController {
    enum Constants {
        static let imageHeight = 400
        static let stackViewSpacing: CGFloat = 20
        static let titleFont = UIFont(name: ".SFUI-Regular", size: 25)
    }
}
