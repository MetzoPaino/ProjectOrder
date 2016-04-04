//
//  DescriptionViewController.swift
//  Ranked
//
//  Created by William Robinson on 07/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol DescriptionViewControllerDelegate: class {
    func newTitle(text: String)
    func newItem(text: String)
    func newDescription(text: String)
}

enum Context {
    case title
    case description
    case item
}

class DescriptionViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var context = Context.title
    
    weak var delegate: DescriptionViewControllerDelegate?
    var providedDescription = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(DescriptionViewController.receivedKeyboardNotification(_:)), name: UIKeyboardDidShowNotification, object: nil)
        notificationCenter.addObserver(self, selector: #selector(DescriptionViewController.receivedKeyboardNotification(_:)), name: UIKeyboardDidHideNotification, object: nil)
        
        textView.textContainerInset = UIEdgeInsetsMake(0, 16, 0, 16)
        textView.text = providedDescription
        
        if context == .title {
            textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleTitle1)
        } else {
            textView.font = UIFont.preferredFontForTextStyle(UIFontTextStyleBody)
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        if isMovingFromParentViewController() {
            
            if context == .title {
                self.delegate?.newTitle(textView.text)
            } else if context == .item {
                self.delegate?.newItem(textView.text)
            } else {
                self.delegate?.newDescription(textView.text)
            }
        }
    }
    // MARK: - NSNotification
    
    func receivedKeyboardNotification(notification: NSNotification) {
        
        let info = notification.userInfo! as Dictionary
        
        if notification.name == UIKeyboardDidShowNotification {
            
            if let keyboardSize = info[UIKeyboardFrameEndUserInfoKey]?.CGRectValue.size {
                
                textView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
                textView.scrollIndicatorInsets = textView.contentInset

            }
            
        } else if notification.name == UIKeyboardDidHideNotification {
            
            textView.contentInset = UIEdgeInsetsZero
            textView.scrollIndicatorInsets = textView.contentInset
        }
    }


}
