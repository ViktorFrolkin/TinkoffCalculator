//
//  HeaderView.swift
//  TinkoffCalculator
//
//  Created by macOS on 14.03.2024.
//

import Foundation
import UIKit

class CustomHeaderView   : UITableViewCell {
    
   
    @IBOutlet weak var dateLabel: UILabel!
    
    func configure(with date: String) {
        dateLabel.text = date
     
    }
}

