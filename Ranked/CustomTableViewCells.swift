//
//  TableViewCells.swift
//  Ranked
//
//  Created by William Robinson on 07/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class LabelCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var titleLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var circleImageViewWidthConstraint: NSLayoutConstraint!
    
    func configureCell(_ hasImage:Bool) {
        
        layoutMargins = UIEdgeInsetsZero;
        selectionStyle = .none
        
        if hasImage {
            titleLabelLeadingConstraint.constant = 8
            circleImageView.layer.cornerRadius = circleImageViewWidthConstraint.constant / 2
            circleImageView.clipsToBounds = true
        } else {
            titleLabelLeadingConstraint.constant = 0
        }
    }
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
        
        summaryImageView.layer.cornerRadius = summaryImageViewWidthConstraint.constant / 2
        summaryImageView.clipsToBounds = true
    }
}

//MARK: - ItemsViewController

class TitleCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var summaryImageView: UIImageView!
    @IBOutlet weak var summaryImageViewHeightConstraint: NSLayoutConstraint!

    let textViewValues = (color: UIColor.black(), placeholderColor: UIColor.lightGray(), placeholderText: "Title")
    
    func configureCell() {
        summaryImageView.layer.cornerRadius = 64 / 2
        summaryImageView.clipsToBounds = true
    }
}

class ImageCell: UITableViewCell {
    
    @IBOutlet weak var summaryImageView: UIImageView!
    @IBOutlet weak var summaryImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var button: UIButton!
    
    func configureCell() {
        summaryImageView.backgroundColor = UIColor.disabledColor()
        summaryImageView.layer.cornerRadius = summaryImageViewWidthConstraint.constant / 2
        summaryImageView.clipsToBounds = true
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
    @IBOutlet weak var titleLabelLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var tintView: UIView!
    @IBOutlet weak var circleImageView: UIImageView!
    @IBOutlet weak var circleImageViewLeadingConstraint: NSLayoutConstraint!
    @IBOutlet weak var circleImageViewWidthConstraint: NSLayoutConstraint!

    func configureCell(_ sorted:Bool) {
        
        layoutMargins = UIEdgeInsetsZero;
        selectionStyle = .none
        
        numberLabel.textColor = .white()
        titleLabel.textColor = .titleColor()

        if sorted {
            
            titleLabelLeadingConstraint.constant = 8
            numberLabel.isHidden = false

            circleImageView.layer.cornerRadius = circleImageViewWidthConstraint.constant / 2
            tintView.layer.cornerRadius = circleImageViewWidthConstraint.constant / 2
            
            circleImageView.clipsToBounds = true
            tintView.clipsToBounds = true
            
            tintView.alpha = 0.5
            
        } else {
            

            numberLabel.isHidden = true
        }
        

    }
}

protocol AddItemTableViewCellDelegate: class {
    func createdNewItemWithText(_ text: String)
}


class AddItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addImageView: UIImageView!
    @IBOutlet weak var button: UIButton!

    @IBOutlet weak var circleView: UIView!
    @IBOutlet weak var circleViewWidthConstraint: NSLayoutConstraint!
    
    weak var delegate: AddItemTableViewCellDelegate?
    
    func configureCell() {
        
        textField.delegate = self
        textField.attributedPlaceholder = AttributedString(string: textField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.backgroundColor()])
        
        circleView.backgroundColor = .primaryColor()
        circleView.layer.cornerRadius = circleViewWidthConstraint.constant / 2
        circleView.clipsToBounds = true
        
        button.imageView!.image = UIImage(named: "PlusButton" )?.withRenderingMode(.alwaysTemplate)
        button.imageView!.tintColor = .white()
    }
}

extension AddItemTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
                
        let string = textField.text! as NSString
        
        if string.length > 0 {
            
            let whitespaceSet = CharacterSet.whitespaces
            if !string.trimmingCharacters(in: whitespaceSet).isEmpty {
                
                self.delegate?.createdNewItemWithText(textField.text!)
                textField.text = ""
                
            } else {
                
                print("Just whitespace")
            }
        }
        return false
    }
}
