//
//  TabBar.swift
//  BestBoardGames
//
//  Created by Kate on 02.10.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    // 1 controller
    let gameList: UINavigationController = {
        let gameList = UINavigationController()
        gameList.viewControllers = [MyViewController()]
        gameList.tabBarItem.title = "Games"
        gameList.tabBarItem.image = UIImage(named:"gamelist")
        return gameList
    }()

    
    // 2 controller
    let favorites: FavoritesGamesVC = {
        let favorites = FavoritesGamesVC()
        favorites.tabBarItem.title = "Favorites"
        favorites.tabBarItem.image = UIImage(named:"favorite")
        return favorites
    }()

    // 3 controller
    
    let profile: ProfileVC = {
        let profile = ProfileVC()
        profile.tabBarItem.title = "Profile"
        profile.tabBarItem.image = UIImage(named:"profile")
        return profile
    }()
}

