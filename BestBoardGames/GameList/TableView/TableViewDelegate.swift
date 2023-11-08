//
//  TableViewDelegate.swift
//  BestBoardGames
//
//  Created by Kate on 07.06.2023.
//

import UIKit
import SnapKit

class TableViewDelegate: NSObject, UITableViewDelegate {
    
    weak var delegate: GameListDelegate?
    var favoritesService: FavoritesService?
    
    init(delegate: GameListDelegate, favoritesService: FavoritesService = FavoritesService()) {
        self.delegate = delegate
        self.favoritesService = favoritesService
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath as IndexPath, animated: true)

        let row = indexPath.row
        print("Row: \(row)")
        
        delegate?.goToNextVC(row: row)

    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        105
    }
    
    private func handleMarkAsFavourite(gameId: Int, action: UIContextualAction, isFavorite: Bool) {
       
        if isFavorite {
            favoritesService?.removeFavorites(data: .init(gameId: gameId))
            action.image = UIImage(named: "heart_empty")
        } else {
            favoritesService?.sendFavoritesData(data: .init(gameId: gameId))
            action.image = UIImage(named: "heart_full")
        }
    }
    
    func tableView(_ tableView: UITableView,
                   trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        guard let gameId = delegate?.games[indexPath.row].gameId else { return nil }
        guard  let favoritesService = favoritesService else { return nil }
        
        let isFavorite: Bool = favoritesService.checkFavorites(data: .init(gameId: gameId))

        let action = UIContextualAction(style: .normal, title: "") {
            [weak self] (action, view, completionHandler) in
            self?.handleMarkAsFavourite(gameId: gameId, action: action, isFavorite: isFavorite)
            completionHandler(true)
        }
        
        action.backgroundColor = UIColor(hex: 0xFF9F0A)
        
        if isFavorite {
            action.image = UIImage(named: "heart_full")
        } else {
            action.image = UIImage(named: "heart_empty")
        }
        
        return UISwipeActionsConfiguration(actions: [action])
    }
    
    func tableView(_ tableView: UITableView,
                   editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .none
    }
}
