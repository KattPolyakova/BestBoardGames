//
//  ProfileVC.swift
//  BestBoardGames
//
//  Created by Kate on 26.09.2023.
//

import UIKit

class ProfileVC: UIViewController, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    let normalProfileView = NormalProfileView()
    let editProfileView = EditProfileView()
    let service = ProfileService()
    var imagePickerController = UIImagePickerController()

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
            normalProfileView.userPhoto.image = serviceData.image
            
        }
    }
    
    func showEditView() {
        normalProfileView.isHidden = true
        editProfileView.isHidden = false
        
        if let serviceData = service.getProfileData() {
            editProfileView.userName.text = serviceData.name
            editProfileView.userEmail.text = serviceData.email
            editProfileView.userPhoto.image = serviceData.image
        }
    }
    
    func showNormalView() {
        
        let name = editProfileView.userName.text ?? ""
        let email = editProfileView.userEmail.text ?? ""
        let image = editProfileView.userPhoto.image
        
        let profileData = ProfileData(name: name, email: email, image: image)
        let photo = editProfileView.userPhoto.image ?? UIImage(named: "add-photo")
        service.sendProfileData(data: profileData)
        
        normalProfileView.userName.text = name
        normalProfileView.userEmail.text = email
        normalProfileView.userPhoto.image = photo

        editProfileView.isHidden = true
        normalProfileView.isHidden = false
    }
    
    func showAlbum() {
        imagePickerController.modalPresentationStyle = UIModalPresentationStyle.currentContext
        imagePickerController.delegate = self
            self.present(imagePickerController, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let tempImage = info[.originalImage] as? UIImage {
            editProfileView.userPhoto.image  = tempImage
        }
            
        imagePickerController.dismiss(animated: true)
    }
}
