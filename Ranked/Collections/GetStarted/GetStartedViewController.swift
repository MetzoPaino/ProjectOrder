//
//  GetStartedViewController.swift
//  Project Order
//
//  Created by William Robinson on 30/04/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol GetStartedViewControllerDelegate: class {
    func finishedPickingCollections(collections: [CollectionModel])
}

class GetStartedViewController: UIViewController {

    var collections = createPreMadeCollectionsArray()

    var pickedCollections = [CollectionModel]()

    @IBOutlet weak var option1View: UIView!
    @IBOutlet weak var option2View: UIView!
    @IBOutlet weak var option3View: UIView!
    @IBOutlet var optionViewCollection: [UIView]!
    
    @IBOutlet weak var option1Label: UILabel!
    @IBOutlet weak var option2Label: UILabel!
    @IBOutlet weak var option3Label: UILabel!
    @IBOutlet var optionLabelCollection: [UILabel]!
    
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet weak var option3Button: UIButton!
    
    @IBOutlet weak var option1CenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var option2CenterConstraint: NSLayoutConstraint!
    @IBOutlet weak var option3CenterConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var refreshButton: UIButton!
    @IBOutlet weak var refreshButtonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var doneButtonBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet var buttonCollection: [UIButton]!
    
    weak var delegate: GetStartedViewControllerDelegate?

    var option1Index: Int?
    var option2Index: Int?
    var option3Index: Int?
    
    var firstTime = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        moveEverythingOffScreen()
        styleView()

        pickOptions()
        updateOptions()
        presentOptions()
    }
    
    func reset() {
        
        option1View.hidden = false
        option2View.hidden = false
        option3View.hidden = false

        collections = createPreMadeCollectionsArray()
        pickedCollections = [CollectionModel]()
        moveEverythingOffScreen()
        styleView()
        
        pickOptions()
        updateOptions()
        presentOptions()
    }
    
    func styleView() {
        
        for view in optionViewCollection {
            
            view.layer.cornerRadius = 12
            view.layer.masksToBounds = true
            view.backgroundColor = .blockNeutralColor()

            view.layer.shadowColor = UIColor.blackColor().CGColor;
            view.layer.shadowOpacity = 0.25
            view.layer.shadowRadius = 2
            view.layer.shadowOffset = CGSizeMake(0.0, 2.0)
            view.layer.masksToBounds = false
        }
        
        for label in optionLabelCollection {
            
            label.textColor = .whiteColor()
        }
        
        for button in buttonCollection {
            
            button.layer.cornerRadius = 48 / 2
            button.setImage(UIImage(named: "" )?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
            button.tintColor = .whiteColor()
            
            button.layer.shadowColor = UIColor.blackColor().CGColor;
            button.layer.shadowOpacity = 0.25
            button.layer.shadowRadius = 2
            button.layer.shadowOffset = CGSizeMake(0.0, 2.0)
            button.layer.masksToBounds = false
        }
        
        doneButton.backgroundColor = .blockLosingColor()
        doneButton.userInteractionEnabled = false
        refreshButton.backgroundColor = .primaryColor()
    }

    func pickOptions() {
        
        if collections.count >= 1 {
            
            option1Index = Int(arc4random_uniform(UInt32(collections.count)))
            
        } else {
            
            option1Index = nil
            option1View.hidden = true
            delegate?.finishedPickingCollections(pickedCollections)
        }
        
        if collections.count >= 2 {
            
            repeat {
                option2Index = Int(arc4random_uniform(UInt32(collections.count)))
            } while (option2Index == option1Index);
            
        } else {
            
            option2Index = nil
            option2View.hidden = true

        }
        
        if collections.count >= 3 {
            
            repeat {
                option3Index = Int(arc4random_uniform(UInt32(collections.count)))
            } while (option3Index == option1Index || option3Index == option2Index);
            
        } else {
            
            option3Index = nil
            option3View.hidden = true

        }
        
        if pickedCollections.count > 0 {
            
            doneButton.backgroundColor = .secondaryColor()
            doneButton.userInteractionEnabled = true
        }
    }
    
    func updateOptions() {
        
        if let option1Index = option1Index {
            
            option1Label.text = collections[option1Index].name
        }
        
        if let option2Index = option2Index {
            
            option2Label.text = collections[option2Index].name
        }
        
        if let option3Index = option3Index {
            
            option3Label.text = collections[option3Index].name
        }
    }
    
    func moveEverythingOffScreen() {
        
        option1CenterConstraint.constant = 0 - view.bounds.width
        option2CenterConstraint.constant = 0 + view.bounds.width
        option3CenterConstraint.constant = 0 - view.bounds.width
        
        doneButtonBottomConstraint.constant = 0 - 16 - 48
        refreshButtonBottomConstraint.constant = 0 - 16 - 48

        view.layoutIfNeeded()
    }
    
    func presentNewOptions() {
        
        option1CenterConstraint.constant = 0 - view.bounds.width
        option2CenterConstraint.constant = 0 + view.bounds.width
        option3CenterConstraint.constant = 0 - view.bounds.width
        
        UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
            self.option1View.layoutIfNeeded()
            self.option2View.layoutIfNeeded()
            self.option3View.layoutIfNeeded()
            
        }) { (completion) in
            
            self.pickOptions()
            self.updateOptions()
            
            self.option1View.backgroundColor = .blockNeutralColor()
            self.option2View.backgroundColor = .blockNeutralColor()
            self.option3View.backgroundColor = .blockNeutralColor()
            
            self.option1CenterConstraint.constant = 0
            self.option2CenterConstraint.constant = 0
            self.option3CenterConstraint.constant = 0
            
            UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                self.option1View.layoutIfNeeded()
                self.option2View.layoutIfNeeded()
                self.option3View.layoutIfNeeded()
                
                }, completion: nil)
        }
    }
    
    func presentOptions() {
        
        option1CenterConstraint.constant = 0
        option2CenterConstraint.constant = 0
        option3CenterConstraint.constant = 0
        
        doneButtonBottomConstraint.constant = 16
        refreshButtonBottomConstraint.constant = 16
        
        UIView.animateWithDuration(0.5, delay: 0.5, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.option1View.layoutIfNeeded()
            self.option2View.layoutIfNeeded()
            self.option3View.layoutIfNeeded()
            self.doneButton.layoutIfNeeded()
            self.refreshButton.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    // MARK: - IBActions
    
    @IBAction func optionButtonPressed(sender: UIButton) {
        
        var selectedIndex: Int
        var selectedView: UIView
        
        if sender == option1Button {
            
            selectedIndex = option1Index!
            selectedView = option1View
            
        } else if sender == option2Button {
            
            selectedIndex = option2Index!
            selectedView = option2View

        } else {
            selectedIndex = option3Index!
            selectedView = option3View

        }
        
        UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveLinear, animations: {
            
            selectedView.backgroundColor = .blockPreferredColor()
            
        }, completion: nil)
        
        pickedCollections.append(collections[selectedIndex])
        collections.removeAtIndex(selectedIndex)
        
        presentNewOptions()
    }
    
    @IBAction func refreshButtonPressed(sender: UIButton) {
        
        option1CenterConstraint.constant = 0 - view.bounds.width
        option2CenterConstraint.constant = 0 + view.bounds.width
        option3CenterConstraint.constant = 0 - view.bounds.width
        
        UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
            self.option1View.layoutIfNeeded()
            self.option2View.layoutIfNeeded()
            self.option3View.layoutIfNeeded()
            
            }) { (completion) in
                
                self.pickOptions()
                self.updateOptions()
                
                self.option1View.backgroundColor = .blockNeutralColor()
                self.option2View.backgroundColor = .blockNeutralColor()
                self.option3View.backgroundColor = .blockNeutralColor()
                
                self.option1CenterConstraint.constant = 0
                self.option2CenterConstraint.constant = 0
                self.option3CenterConstraint.constant = 0
                
                UIView.animateWithDuration(0.5, delay: 0.2, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                    
                    self.option1View.layoutIfNeeded()
                    self.option2View.layoutIfNeeded()
                    self.option3View.layoutIfNeeded()
                    
                    }, completion: nil)
        }
    }
    
    @IBAction func doneButtonPressed(sender: UIButton) {
        
        delegate?.finishedPickingCollections(pickedCollections)
    }
}
