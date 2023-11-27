//
//  FavoritesService.swift
//  BestBoardGames
//
//  Created by Kate on 19.10.2023.
//

import UIKit

class FavoritesService {
    
    var gameCount: Int {
        let count = UserDefaults.standard.array(forKey: "gameId")?.count
        UserDefaults.standard.array(forKey: "gameId")?.forEach({ item in
            print(item)
        })
        return count ?? 0
    }
    
    func sendFavoritesData(data: FavoritesData) { // сохранение данных
        //gameID
        
        guard let array: [Int] = UserDefaults.standard.array(forKey: "gameId") as? [Int] else {
            let array = [data.gameId]
            UserDefaults.standard.set(array, forKey: "gameId")
            return
        }
        
        var set = Set.init(array)       // превратили массив в сет (не имеет одинаковых элементов)
        set.insert(data.gameId)         // добавили новый ID (если есть, не добавится)
        let arrayNew = Array(set)       // превратили сет обратно в массив
        
        UserDefaults.standard.set(arrayNew, forKey: "gameId")
        
        // save array to UserDefaults
    }
    
    func checkFavorites(data: FavoritesData) -> Bool {
        guard let array = UserDefaults.standard.array(forKey: "gameId") as? [Int] else {
            return false
        }
        return array.contains(data.gameId)
        
    }
    
    func removeFavorites(data: FavoritesData) {
            
        guard var array: [Int] = UserDefaults.standard.array(forKey: "gameId") as? [Int] else { return }
        
        array.removeAll(where: { $0 == data.gameId })
        UserDefaults.standard.set(array, forKey: "gameId")
     
        // remove game from UserDefaults
    }
}
