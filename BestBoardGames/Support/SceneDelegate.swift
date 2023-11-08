//
//  SceneDelegate.swift
//  BestBoardGames
//
//  Created by Kate on 26.05.2023.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    
    var window: UIWindow?
    
    
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        if let windowScene = scene as? UIWindowScene {
            let window = UIWindow(windowScene: windowScene) // 0x1256
                        
            let tabBarController = TabBarController() // 0x1257
            
            tabBarController.viewControllers = [tabBarController.favorites, tabBarController.gameList, tabBarController.profile]
            
            window.rootViewController = tabBarController
            self.window = window
            window.makeKeyAndVisible()
        
        }
    }
}







