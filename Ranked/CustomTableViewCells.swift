//
//  TableViewCells.swift
//  Ranked
//
//  Created by William Robinson on 07/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

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

// MARK:- ItemTableViewCell

class ItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var numberImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var numberLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberLabelTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabelLeadingConstraint: NSLayoutConstraint!
    
    override func layoutSubviews() {
        super.layoutSubviews()
        numberImageView.layer.cornerRadius = numberImageView.frame.width / 2
        numberImageView.clipsToBounds = true
    }
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
        
//        textField.resignFirstResponder()
        
        let string = textField.text! as NSString
        
        if string.length > 0 {
                    
            self.delegate?.createdNewItemWithText(textField.text!)
            textField.text = ""
        }
        return false
    }
}
