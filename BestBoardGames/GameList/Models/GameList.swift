//
//  GameList.swift
//  BestBoardGames
//
//  Created by Kate on 08.06.2023.
//

import Foundation

struct Game: Codable {
    let name: String
    let gameId: Int
    let yearPublished: Int
    let imageString: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case gameId
        case yearPublished
        case imageString = "thumbnail"
       }
}
