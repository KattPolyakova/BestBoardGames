//
//  TableViewDelegate.swift
//  BestBoardGames
//
//  Created by Kate on 07.06.2023.
//

import UIKit
import SnapKit

class TableViewDelegate: NSObject, UITableViewDelegate {
    
    weak var delegate: NavigationDelegate?
    
    init(delegate: NavigationDelegate) {
        self.delegate = delegate
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        tableView.deselectRow(at: indexPath as IndexPath, animated: true)

        let row = indexPath.row
        print("Row: \(row)")
        
        delegate?.goToNextVC(row: row)

    }
    
}

protocol NavigationDelegate: AnyObject {
    
    func goToNextVC(row: Int)
}
