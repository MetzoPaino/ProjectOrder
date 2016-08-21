//
//  SettingsTableViewCells.swift
//  Project Order
//
//  Created by William Robinson on 21/08/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class SyncingTableViewCell: SettingsTableViewCell {
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    func configureCell(syncing: Bool) {
        
        if syncing == true {
            activityIndicator.startAnimating()
        } else {
            activityIndicator.stopAnimating()
        }
    }
}

class SettingsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var descriptionImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var accessoryImageView: UIImageView!
    
    func configureCell() {
        
        if isHighlighted {
            titleLabel.textColor = .white
            
        } else {
            titleLabel.textColor = .headingColor()
        }
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .secondaryColor()
        selectedBackgroundView = backgroundView
    }
}
