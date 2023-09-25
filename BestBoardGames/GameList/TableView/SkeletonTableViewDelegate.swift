//
//  SkeletonTableViewDelegate.swift
//  BestBoardGames
//
//  Created by Kate on 25.09.2023.
//

import UIKit
import SnapKit

class SkeletonTableViewDelegate: NSObject, UITableViewDelegate {
    
//    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//
//        tableView.deselectRow(at: indexPath as IndexPath, animated: true)
//
//        let row = indexPath.row
//        print("Row: \(row)")
//
//        delegate?.goToNextVC(row: row)
//
//    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        105
    }
}

