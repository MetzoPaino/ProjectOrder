//
//  CustomViews.swift
//  Ranked
//
//  Created by William Robinson on 20/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol AddItemViewDelegate: class {
    func createdNewItemWithText(text: String)
}


class AddItemView: UIView {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var addImageView: UIImageView!
    
    weak var delegate: AddItemViewDelegate?
    
    override func awakeFromNib() {
        textField.delegate = self
        textField.attributedPlaceholder = NSAttributedString(string: textField.placeholder!, attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
    }
}

extension AddItemView: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        let string = textField.text! as NSString
        
        if string.length > 0 {
            
            self.delegate?.createdNewItemWithText(textField.text!)
            textField.text = ""
        }
        return true
    }
}
