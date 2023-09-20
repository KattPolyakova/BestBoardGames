//
//  GameDescriptionService.swift
//  BestBoardGames
//
//  Created by Kate on 27.06.2023.
//

import Foundation
import Alamofire

class GameDescriptionService: CommonService<GameInformation> {
    
    init() {
        super.init(urlString: "https://bgg-json.azurewebsites.net/thing/")
    }
}
    


