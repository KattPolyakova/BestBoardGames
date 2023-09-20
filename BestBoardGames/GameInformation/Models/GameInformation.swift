//
//  GameInformation.swift
//  BestBoardGames
//
//  Created by Kate on 08.06.2023.
//

import Foundation
import UIKit

struct GameInformation: Codable {
    let gameId: Int
    let name: String
    let description: String
    let image: String
    let minPlayers: Int
    let maxPlayers: Int
    let playingTime: Int
    let yearPublished: Int
    let rating: Double
    
    enum CodingKeys: String, CodingKey {
        case gameId
        case name
        case description
        case image
        case minPlayers
        case maxPlayers
        case playingTime
        case yearPublished
        case rating = "averageRating"
       }
}
