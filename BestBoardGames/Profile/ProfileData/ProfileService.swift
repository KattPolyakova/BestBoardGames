//
//  ProfileService.swift
//  BestBoardGames
//
//  Created by Kate on 04.10.2023.
//

import UIKit

class ProfileService {
    
    func getProfileData() -> ProfileData? {
        ProfileDataStore.data 
    }
    
    func sendProfileData(data: ProfileData) {
        ProfileDataStore.data = data
    }
    
}
