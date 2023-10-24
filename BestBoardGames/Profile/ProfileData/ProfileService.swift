//
//  ProfileService.swift
//  BestBoardGames
//
//  Created by Kate on 04.10.2023.
//

import UIKit

class ProfileService {
    
    func getProfileData() -> ProfileData? {  //  извлечение данных

        let name = UserDefaults.standard.string(forKey: "name") ?? "Unknown"
        let email = UserDefaults.standard.string(forKey: "email") ?? "Unknown"
        
        guard let imageData = UserDefaults.standard.data(forKey: "image") else {
            return ProfileData(name: name, email: email, image: nil)
        }
        
            let decoded = try! PropertyListDecoder().decode(Data.self, from: imageData)
            let image = UIImage(data: decoded)
        
        let data = ProfileData(name: name , email: email, image: image)
        
        return data
    }
    
    func sendProfileData(data: ProfileData) {  // сохранение данных
    
        
        UserDefaults.standard.set(data.name, forKey: "name")
        UserDefaults.standard.set(data.email, forKey: "email")
        
        guard let image = data.image?.jpegData(compressionQuality: 0.5) else { return }
            let encoded = try! PropertyListEncoder().encode(image)
            
        UserDefaults.standard.set(encoded, forKey: "image")
        
        
    }    
}
