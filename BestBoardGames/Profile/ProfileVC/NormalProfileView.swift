//
//  NormalProfileVC.swift
//  BestBoardGames
//
//  Created by Kate on 29.09.2023.
//

import UIKit

class NormalProfileView: UIView {
    
    var show: (()->())?
    
    let userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "add-photo")
        imageView.layer.cornerRadius = 121
        imageView.clipsToBounds = true
        return imageView
    }()
    var userName: UILabel = {
        let label = UILabel()
        label.text = "Имя"
        label.font = UIFont(name: "Arial-BoldMT", size: 24)
        return label
    }()
    var userEmail: UILabel = {
        let label = UILabel()
        label.text = "Почта"
        label.font = UIFont(name: "ArialHebrew", size: 16)
        label.textColor = UIColor(hex: 0x777777)
        return label
    }()
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "edit_pencil"), for: .normal)
        button.addTarget(self, action: #selector(onTouch), for: .touchUpInside)
        return button
    }()
   
    init() {
        super.init(frame: .zero)
        addSubViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didMoveToSuperview() {
        super.didMoveToSuperview()
        addConstraints()
    }
    
    func addSubViews() {
        addSubview(userPhoto)
        addSubview(userName)
        addSubview(userEmail)
        addSubview(editButton)
    }
    
    func addConstraints() {
        
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userPhoto.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(112)
            make.size.width.equalTo(242)
            make.width.equalTo(userPhoto.snp.height)
            make.centerX.equalToSuperview()
            
        }
        
        userName.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userPhoto.snp.bottom).offset(20)
        }
        
        userEmail.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }
        editButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(74)
            make.right.equalToSuperview().offset(-36)
            make.size.width.equalTo(24)
            make.width.equalTo(editButton.snp.height)
        }
    }
    
    @objc func onTouch() {
        show?()
    }
}
