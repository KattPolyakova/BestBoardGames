//
//  GameListService.swift
//  BestBoardGames
//
//  Created by Kate on 11.09.2023.
//

import Foundation
import Alamofire

class GameListService: CommonService<[Game]> {
    
    init() {
        super.init(urlString: "http://bgg-json.azurewebsites.net/hot")
    }
//    override var urlString: String {
//        "http://bgg-json.azurewebsites.net/hot"
//    }
}


// http://bgg-json.azurewebsites.net/hot
