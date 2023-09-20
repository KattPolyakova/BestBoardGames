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
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "UITableViewCell", for: indexPath)
        cell.textLabel?.text = savedGames[indexPath.row].name
        cell.backgroundColor = .clear
        cell.textLabel?.textColor = .orange
       return cell
    }
    
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       switch tableView {
       case tableView:
          return savedGames.count
        default:
          return 0
       }
    }
}
