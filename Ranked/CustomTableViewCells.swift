//
//  TableViewCells.swift
//  Ranked
//
//  Created by William Robinson on 07/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class LabelCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
}

//MARK: - CollectionsViewController

class CollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryImageView: UIImageView!
    @IBOutlet weak var lowerStackView: UIStackView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    @IBOutlet weak var summaryImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var summaryImageViewLeadingConstraint: NSLayoutConstraint!

    @IBOutlet weak var masterStackViewBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var masterStackViewTopConstraint: NSLayoutConstraint!
    
    func configureCell() {
        
        summaryImageView.layer.cornerRadius = 32 / 2
        summaryImageView.clipsToBounds = true
    }
}

//MARK: - ItemsViewController

class TitleCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var summaryImageView: UIImageView!
    //@IBOutlet weak var summaryImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var summaryImageViewHeightConstraint: NSLayoutConstraint!
    //@IBOutlet weak var summaryImageViewLeadingConstraint: NSLayoutConstraint!

    let textViewValues = (color: UIColor.blackColor(), placeholderColor: UIColor.lightGrayColor(), placeholderText: "Title")
    
    func configureCell() {
        summaryImageView.layer.cornerRadius = 64 / 2
        //summaryImageView.clipsToBounds = true
    }
}

class DescriptionCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func configureCell() {
    }
}

class SortedItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var firstPlaceImageView: UIImageView!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    func configureCell() {
        
        circleView.layer.cornerRadius = 32 / 2
        circleView.clipsToBounds = true
    }
}

class UnsortedItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var tintView: UIView!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var circleImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var circleImageViewWidthConstraint: NSLayoutConstraint!
    
    func configureCell() {
        
        circleImageView.layer.cornerRadius = circleImageViewWidthConstraint.constant / 2
        circleImageView.clipsToBounds = true
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
        
        circleView.backgroundColor = .primaryColor()
        circleView.layer.cornerRadius = 32 / 2
        circleView.clipsToBounds = true
        
        addImageView.image = UIImage(named: "PlusButton" )?.imageWithRenderingMode(.AlwaysTemplate)
        addImageView.tintColor = .whiteColor()
    }
}

extension AddItemTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
                
        let string = textField.text! as NSString
        
        if string.length > 0 {
            
            let whitespaceSet = NSCharacterSet.whitespaceCharacterSet()
            if !string.stringByTrimmingCharactersInSet(whitespaceSet).isEmpty {
                
                print("Not whitespace")
                self.delegate?.createdNewItemWithText(textField.text!)
                textField.text = ""
                
            } else {
                
                print("Just whitespace")
            }
        }
        return false
    }
}
