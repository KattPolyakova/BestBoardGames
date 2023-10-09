//
//  EditProfileVC.swift
//  BestBoardGames
//
//  Created by Kate on 29.09.2023.
//

import UIKit

class EditProfileView: UIView {
    
    var show: (()->())?
    var showAlbum: (()->())?
    
    let userPhoto: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "add-photo")
        imageView.layer.cornerRadius = 121
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let userName: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.placeholder = "   Имя"
        return textField
    }()
    let userEmail: UITextField = {
        let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.backgroundColor = .white
        textField.placeholder = "   Почта"
        return textField
    }()
    
    lazy var editButton: UIButton = {
        let button = UIButton()
        button.setTitle("Изменить", for: .normal)
        button.setTitleColor(.blue, for: .normal)
        button.addTarget(self, action: #selector(editButtonAction), for: .touchUpInside)
        return button
    }()
    lazy var doneButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "Done"), for: .normal)
        button.addTarget(self, action:  #selector(onTouch), for: .touchUpInside)
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
    
    
    private func addSubViews() {
        
        addSubview(userPhoto)
        addSubview(editButton)
        addSubview(userName)
        addSubview(userEmail)
        addSubview(doneButton)
        
    }
    
    private func addConstraints() {
        
        snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        userPhoto.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(112)
            make.size.width.equalTo(242)
            make.width.equalTo(userPhoto.snp.height)
            make.centerX.equalToSuperview()
            
        }
        
        editButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(userPhoto.snp.bottom).offset(10)
        }
        
        userName.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(editButton.snp.bottom).offset(20)
        }
        
        userEmail.snp.makeConstraints { make in
            make.top.equalTo(userName.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
        doneButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(74)
            make.right.equalToSuperview().offset(-36)
            make.size.width.equalTo(24)
            make.width.equalTo(doneButton.snp.height)
        }
    }
    
    @objc func onTouch() {
        show?()
    }
    
    @objc func editButtonAction() {
        showAlbum?()
    }
}
