//
//  ProfileVC.swift
//  BestBoardGames
//
//  Created by Kate on 26.09.2023.
//

import UIKit

class ProfileVC: UIViewController {
    
    let normalProfileView = NormalProfileView()
    let editProfileView = EditProfileView()
    let service = ProfileService()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        normalProfileView.show = showEditView
        editProfileView.show = showNormalView
        editProfileView.showAlbum = showAlbum
        
        
        self.view.addSubview(normalProfileView)
        self.view.addSubview(editProfileView)
        view.backgroundColor = .white
        
        editProfileView.isHidden = true
        
        if let serviceData = service.getProfileData() {
            normalProfileView.userName.text = serviceData.name
            normalProfileView.userEmail.text = serviceData.email
        }
    }
    
    func showEditView() {
        normalProfileView.isHidden = true
        editProfileView.isHidden = false
        
        if let serviceData = service.getProfileData() {
            editProfileView.userName.text = serviceData.name
            editProfileView.userEmail.text = serviceData.email
        }
    }
    
    func showNormalView() {
        
        let name = editProfileView.userName.text ?? ""
        let email = editProfileView.userEmail.text ?? ""
        let profileData = ProfileData(name: name, email: email)
        service.sendProfileData(data: profileData)
        
        normalProfileView.userName.text = name
        normalProfileView.userEmail.text = email

        editProfileView.isHidden = true
        normalProfileView.isHidden = false
    }
    
    func showAlbum() {
        print("Album showed")
    }
}
