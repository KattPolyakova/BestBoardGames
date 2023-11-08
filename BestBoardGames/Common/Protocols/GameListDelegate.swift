//
//  GameListDelegate.swift
//  BestBoardGames
//
//  Created by Kate on 07.11.2023.
//
import CoreGraphics

protocol GameListDelegate: AnyObject {
    var games: [Game] { get }
    func goToNextVC(row: Int)
}
