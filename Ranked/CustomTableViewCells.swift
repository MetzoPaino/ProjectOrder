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

// MARK:- ColorCell

protocol ColorCellDelegate: class {
    func pickedNewColor(index: Int)
}

class ColorCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    
    let colorManager = ColorManager()
    var laidOut = false
    
    weak var delegate: ColorCellDelegate?
    
    override func layoutSubviews() {
        
        if !laidOut {
            laidOut = false
            
            let subviews = self.scrollView.subviews
            for subview in subviews{
                subview.removeFromSuperview()
            }
            
            self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.width * 3,
                self.scrollView.bounds.height)
            
            let scrollViewWidth:CGFloat = self.scrollView.bounds.width
            let scrollViewHeight:CGFloat = self.scrollView.bounds.height
            
            var itterator = 0
            
            if let colorPicker = NSBundle.mainBundle().loadNibNamed("ColorPicker", owner: self, options: nil).first as? ColorPickerView {
                colorPicker.frame = CGRectMake(0, 0,scrollViewWidth, scrollViewHeight)
                self.scrollView.addSubview(colorPicker)
                colorPicker.delegate = self

                for button in colorPicker.buttonCollection {

                    button.tag = itterator

                    if itterator < colorManager.colorThemes.count {
                        
                        button.backgroundColor = colorManager.colorThemes[itterator].titleColor
                    } else {
                        button.alpha = 0
                        button.userInteractionEnabled = false
                    }
                    itterator = itterator + 1
                }
            }
            
            if let colorPicker = NSBundle.mainBundle().loadNibNamed("ColorPicker", owner: self, options: nil).first as? ColorPickerView {
                colorPicker.frame = CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight)
                self.scrollView.addSubview(colorPicker)
                colorPicker.delegate = self

                for button in colorPicker.buttonCollection {
                    
                    button.tag = itterator

                    if itterator < colorManager.colorThemes.count {
                        
                        button.backgroundColor = colorManager.colorThemes[itterator].titleColor
                    } else {
                        button.alpha = 0
                        button.userInteractionEnabled = false
                    }
                    itterator = itterator + 1
                }
            }
            
            if let colorPicker = NSBundle.mainBundle().loadNibNamed("ColorPicker", owner: self, options: nil).first as? ColorPickerView {
                colorPicker.frame = CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight)
                self.scrollView.addSubview(colorPicker)
                colorPicker.delegate = self
                for button in colorPicker.buttonCollection {
                    
                    button.tag = itterator

                    if itterator < colorManager.colorThemes.count {
                        
                        button.backgroundColor = colorManager.colorThemes[itterator].titleColor
                    } else {
                        button.alpha = 0
                        button.userInteractionEnabled = false
                    }
                    itterator = itterator + 1
                }
            }
        }
    }
    
    func configureCell() {
        
//        scrollView.userInteractionEnabled = false
//        contentView.addGestureRecognizer(scrollView.panGestureRecognizer)
    }
}

extension ColorCell: ColorPickerViewDelegate {
    
    func pickedNewColor(index: Int) {
        
        self.delegate?.pickedNewColor(index)
    }
}

protocol AddItemTableViewCellDelegate: class {
    func createdNewItemWithText(text: String)
}


class AddItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addImageView: UIImageView!
    
    weak var delegate: AddItemTableViewCellDelegate?
    
    func configureCell() {
        
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.backgroundColor()])
        
        addImageView.backgroundColor = .secondaryColor()
        addImageView.layer.cornerRadius = 20
//        addImageView.layer.masksToBounds = true
        addImageView.clipsToBounds = true

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
