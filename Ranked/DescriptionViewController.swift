//
//  DescriptionViewController.swift
//  Ranked
//
//  Created by William Robinson on 07/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol DescriptionViewControllerDelegate: class {
    func newTitle(_ text: String)
    func newItem(_ text: String)
    func newDescription(_ text: String)
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
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(DescriptionViewController.receivedKeyboardNotification(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        notificationCenter.addObserver(self, selector: #selector(DescriptionViewController.receivedKeyboardNotification(_:)), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
        
        textView.textContainerInset = UIEdgeInsetsMake(0, 16, 0, 16)
        textView.text = providedDescription
        
        if context == .title {
            textView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.title1)
        } else {
            textView.font = UIFont.preferredFont(forTextStyle: UIFontTextStyle.body)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
        
        if isMovingFromParentViewController {
            
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
    
    func receivedKeyboardNotification(_ notification: Notification) {
        
        if notification.name == NSNotification.Name.UIKeyboardDidShow {
            
            let info = (notification as NSNotification).userInfo! as Dictionary

            if let keyboardSize = (info[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
                
                textView.contentInset = UIEdgeInsetsMake(0, 0, keyboardSize.height, 0)
                textView.scrollIndicatorInsets = textView.contentInset

            }
            
        } else if notification.name == NSNotification.Name.UIKeyboardDidHide {
            
            textView.contentInset = UIEdgeInsets.zero
            textView.scrollIndicatorInsets = textView.contentInset
        }
    }


}
