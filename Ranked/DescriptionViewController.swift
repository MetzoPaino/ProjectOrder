//
//  DescriptionViewController.swift
//  Ranked
//
//  Created by William Robinson on 07/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol DescriptionViewControllerDelegate: class {
    func newDescription(text: String)
}

class DescriptionViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: DescriptionViewControllerDelegate?
    var providedDescription = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.text = providedDescription
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        textView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(animated: Bool) {
        
        super.viewWillDisappear(animated)
        if isMovingFromParentViewController() {
            
            self.delegate?.newDescription(textView.text)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
