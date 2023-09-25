//
//  SkeletonTableViewDataSource.swift
//  BestBoardGames
//
//  Created by Kate on 25.09.2023.
//

import UIKit
import SnapKit

class SkeletonTableViewDataSource: NSObject, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SkeletonViewCell", for: indexPath) as? SkeletonViewCell else { return UITableViewCell() }

       return cell
    }
    
    
    @objc func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       switch tableView {
       case tableView:
          return 10
        default:
          return 0
       }
    }
    
    
}

