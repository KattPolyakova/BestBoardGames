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
        nameLabel.textColor = .black
        nameLabel.font = Constants.titleFont
        nameLabel.numberOfLines = .zero
        return nameLabel
    }()
    private let ratingLabel = {
        let ratingLabel = UILabel()
        ratingLabel.font = Constants.titleFont
        return ratingLabel
    }()
    private let descriptionLabel = {
        let descriptionLabel = UILabel()
        descriptionLabel.textColor = .black
        descriptionLabel.numberOfLines = .zero
        return descriptionLabel
    }()
    private let stackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing
        return stackView
    }()
    lazy var favoriteButton: UIBarButtonItem = {
        let button = UIBarButtonItem()
        button.target = self
        button.action = #selector(addFavorites)
        return button
    }()
    
    private let stackView2 = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = Constants.stackViewSpacing2
        return stackView
    }()
    
    private let nameAndRatingView = UIView()
    private let scrollView = UIScrollView()
    let service = GameDescriptionService()
    private let favoritesService = FavoritesService()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        service.fetchInformation(with: String(gameId), completion: fillData)
        view.backgroundColor = .white
        
        addSubViews()
        addConstraints()
        
        self.navigationItem.largeTitleDisplayMode = .never
        
        if favoritesService.checkFavorites(data: .init(gameId: gameId)) {
            favoriteButton.image = UIImage(named: "heart_full")
        } else {
            favoriteButton.image = UIImage(named: "heart_empty")
        }
    }
    
//    override func viewWillAppear(_ animated: Bool) {
//        super.viewWillAppear(animated)
//        self.navigationController?.navigationBar.prefersLargeTitles = false
//    }
    
    
    func fillData(completionType: CompletionType<GameInformation>) {
        switch completionType {
        case .success(let gameInformation):
            self.nameLabel.text = gameInformation.name
            self.ratingLabel.text = String(format: "%.2f", gameInformation.rating)
            self.ratingLabel.textColor = getColor(by: gameInformation.rating)
            self.descriptionLabel.text = gameInformation.description
            let url = URL(string: gameInformation.image)
            self.image.kf.setImage(with: url)
        case .error: break
        }
    }
    
    func getColor(by rating: Double) -> UIColor {
        switch rating {
        case 0..<6: return UIColor(hex: 0xC23535)
        case 6..<8: return UIColor(hex: 0xC0C235)
        default: return UIColor(hex: 0x37C235)
        }
    }
    
    private func addSubViews() {
        nameAndRatingView.addSubview(nameLabel)
        nameAndRatingView.addSubview(ratingLabel)
        scrollView.addSubview(stackView)
        stackView.addArrangedSubview(image)
        stackView.addArrangedSubview(stackView2)
        stackView2.addArrangedSubview(nameAndRatingView)
        stackView2.addArrangedSubview(descriptionLabel)
        stackView2.addArrangedSubview(UIView())
        navigationItem.setRightBarButtonItems([favoriteButton], animated: true)
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
            make.right.left.equalToSuperview()
            make.height.equalTo(Constants.imageHeight)
        }
        
        stackView2.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
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
    
    @objc func addFavorites(sender: UIButton) {
        
        if favoritesService.checkFavorites(data: .init(gameId: gameId)) {
            favoriteButton.image = UIImage(named: "heart_empty")
            favoritesService.removeFavorites(data: .init(gameId: gameId))
        } else {
            favoriteButton.image = UIImage(named: "heart_full")
            favoritesService.sendFavoritesData(data: .init(gameId: gameId))
        }
    }
}

extension GameDescriptionViewController {
    enum Constants {
        static let imageHeight = 400
        static let stackViewSpacing: CGFloat = 20
        static let stackViewSpacing2: CGFloat = 10
        static let titleFont = UIFont(name: ".SFUI-Regular", size: 25)
    }
}


