//
//  WarningView.swift
//  BestBoardGames
//
//  Created by Kate on 21.11.2023.
//

import UIKit

class WarningView: UIView {
    
    var reload: (() -> ())? = nil
    
    private let warningImage = {
        let image = UIImageView()
        image.image = UIImage(named: "warning")
        return image
    }()
    
    private let textLabel = {
        let label = UILabel()
        label.text = "Что-то пошло не так..."
        label.font = UIFont(name: "Arial", size: 24)
        label.textColor = .black
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var resetButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(hex: 0x219653)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Reload", for: .normal)
        button.addTarget(self, action: #selector(reloadPage), for: .touchUpInside)
       
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addConstraints()
    }
    
    private func addSubViews() {
        addSubview(warningImage)
        addSubview(textLabel)
        addSubview(resetButton)
    }
    
   private func addConstraints(){

        warningImage.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.size.equalTo(170)
        }
        
        textLabel.snp.makeConstraints { make in
            make.top.equalTo(warningImage.snp.bottom).offset(25)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.lessThanOrEqualTo(resetButton).offset(-10)
            
        }
        
        resetButton.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(60)
        }
    }
    
    func updateText(text: String) {
        textLabel.text = text
    }
    
    @objc func reloadPage() {
        reload?()
        print("ok")
    }
}

