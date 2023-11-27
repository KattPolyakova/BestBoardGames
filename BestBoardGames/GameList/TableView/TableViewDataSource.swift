//
//  TableViewDataSource.swift
//  BestBoardGames
//
//  Created by Kate on 07.06.2023.
//

import UIKit
import SnapKit

class TableViewDataSource: NSObject, UITableViewDataSource {
    
    var savedGames: [Game] = []
    var filteredGames: [Game] = []
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "CustomTableViewCell", for: indexPath) as? CustomTableViewCell else { return UITableViewCell() }
        let game = filteredGames[indexPath.row]
        cell.configure(game: CustomTableViewCell.ViewModel(
            name: game.name,
            yearPublished: game.yearPublished,
            imageString: game.imageString
        ))
       return cell
    }
    
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       switch tableView {
       case tableView:
          return filteredGames.count
        default:
          return 0
       }
    }
    
    
}
