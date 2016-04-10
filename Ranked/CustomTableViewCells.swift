//
//  TableViewCells.swift
//  Ranked
//
//  Created by William Robinson on 07/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

//MARK: - CollectionsViewController

class CollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var sortedImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
}

//MARK: - ItemsViewController

class TitleCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    let textViewValues = (color: UIColor.blackColor(), placeholderColor: UIColor.lightGrayColor(), placeholderText: "Title")
    
    func configureCell(title: String?, enableEditing: Bool?) {
        
    }
}

class DescriptionCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func configureCell() {
    }
}

class SortedItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configureCell() {
        
        circleView.layer.cornerRadius = 32 / 2
        circleView.clipsToBounds = true
    }
}

class UnsortedItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
}

protocol AddItemTableViewCellDelegate: class {
    func createdNewItemWithText(text: String)
}


class AddItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var circleView: UIView!
    
    weak var delegate: AddItemTableViewCellDelegate?
    
    func configureCell() {
        
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.backgroundColor()])
        
        circleView.backgroundColor = .secondaryColor()
        circleView.layer.cornerRadius = 32 / 2
        circleView.clipsToBounds = true
    }
}

extension AddItemTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
                
        let string = textField.text! as NSString
        
        if string.length > 0 {
                    
            self.delegate?.createdNewItemWithText(textField.text!)
            textField.text = ""
        }
        return false
    }
}
