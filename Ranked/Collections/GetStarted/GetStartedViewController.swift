//
//  GetStartedViewController.swift
//  Project Order
//
//  Created by William Robinson on 30/04/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol GetStartedViewControllerDelegate: class {
    func finishedPickingCollections(_ collections: [CollectionModel])
}

class GetStartedViewController: UIViewController {

    var collections = createPreMadeCollectionsArray()

    var pickedCollections = [CollectionModel]()

    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var infoLabelTopConstraint: NSLayoutConstraint!
    
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
    
    var laidOutSubviews = false
    
    //MARK:- Load
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //moveEverythingOffScreen()
        styleView()
    }
    
    override func viewDidLayoutSubviews() {
        
        if laidOutSubviews == false {
            laidOutSubviews = true
            reset()
        }
        
        
//        if laidOutSubviews == false {
//            pickOptions()
//            updateOptions()
//            //presentOptions()
//            laidOutSubviews = true
//        }
    }
    
    func reset() {
        
        if laidOutSubviews == false {
            return
        }
        
        option1View.isHidden = false
        option2View.isHidden = false
        option3View.isHidden = false

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
            view.backgroundColor = .secondaryColor()

            view.layer.shadowColor = UIColor.black.cgColor;
            view.layer.shadowOpacity = 0.25
            view.layer.shadowRadius = 2
            view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            view.layer.masksToBounds = false
        }
        
        for label in optionLabelCollection {
            
            label.textColor = .white
        }
        
        for button in buttonCollection {
            
            button.layer.cornerRadius = 64 / 2
            button.tintColor = .white
            
            button.layer.shadowColor = UIColor.black.cgColor;
            button.layer.shadowOpacity = 0.25
            button.layer.shadowRadius = 2
            button.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
            button.layer.masksToBounds = false
        }
        
        doneButton.backgroundColor = .disabledColor()
        doneButton.isUserInteractionEnabled = false
        doneButton.setImage(UIImage(named: "Tick")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        doneButton.tintColor = .backgroundColor()

        refreshButton.backgroundColor = .primaryColor()
        refreshButton.setImage(UIImage(named: "Refresh")?.withRenderingMode(.alwaysTemplate), for: UIControlState())

        infoLabel.textColor = .subHeadingColor()
    }

    func pickOptions() {
        
        if collections.count >= 1 {
            
            option1Index = Int(arc4random_uniform(UInt32(collections.count)))
            
        } else {
            
            option1Index = nil
            option1View.isHidden = true
            doneButtonPressed(doneButton)
        }
        
        if collections.count >= 2 {
            
            repeat {
                option2Index = Int(arc4random_uniform(UInt32(collections.count)))
            } while (option2Index == option1Index);
            
        } else {
            
            option2Index = nil
            option2View.isHidden = true

        }
        
        if collections.count >= 3 {
            
            repeat {
                option3Index = Int(arc4random_uniform(UInt32(collections.count)))
            } while (option3Index == option1Index || option3Index == option2Index);
            
        } else {
            
            option3Index = nil
            option3View.isHidden = true

        }
        
        if pickedCollections.count > 0 {
            
            UIView.animate(withDuration: 0.25, animations: { 
                
                self.doneButton.backgroundColor = .primaryColor()
                self.doneButton.isUserInteractionEnabled = true
                self.doneButton.tintColor = .white
            })
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
        
        self.infoLabel.alpha = 0
        
        option1CenterConstraint.constant = 0 - view.frame.width
        option2CenterConstraint.constant = 0 + view.frame.width
        option3CenterConstraint.constant = 0 - view.frame.width

        doneButtonBottomConstraint.constant = 0 - 16 - 48
        refreshButtonBottomConstraint.constant = 0 - 16 - 48
        
        view.layoutIfNeeded()
    }
    
    func presentNewOptions() {
        
        option1CenterConstraint.constant = 0 - view.bounds.width
        option2CenterConstraint.constant = 0 + view.bounds.width
        option3CenterConstraint.constant = 0 - view.bounds.width
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            
            self.view.layoutIfNeeded()
            
        }) { (completion) in
            
            self.pickOptions()
            self.updateOptions()
            
            self.option1View.backgroundColor = .secondaryColor()
            self.option2View.backgroundColor = .secondaryColor()
            self.option3View.backgroundColor = .secondaryColor()
            
            self.option1CenterConstraint.constant = 0
            self.option2CenterConstraint.constant = 0
            self.option3CenterConstraint.constant = 0
            
            UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                
                self.view.layoutIfNeeded()

                }, completion: nil)
        }
    }
    
    func presentOptions() {
        
        option1CenterConstraint.constant = 0
        option2CenterConstraint.constant = 0
        option3CenterConstraint.constant = 0
        
        doneButtonBottomConstraint.constant = 16
        refreshButtonBottomConstraint.constant = 16
        
        UIView.animate(withDuration: 0.5, delay: 0.5, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.infoLabel.alpha = 1
            self.view.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    // MARK: - IBActions
    
    @IBAction func optionButtonPressed(_ sender: UIButton) {

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
        
        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveLinear, animations: {
            
            selectedView.backgroundColor = .primaryColor()
            
        }, completion: nil)
        
        pickedCollections.append(collections[selectedIndex])
        collections.remove(at: selectedIndex)
        
        presentNewOptions()
    }
    
    @IBAction func refreshButtonPressed(_ sender: UIButton) {
        
        option1CenterConstraint.constant = 0 - view.bounds.width
        option2CenterConstraint.constant = 0 + view.bounds.width
        option3CenterConstraint.constant = 0 - view.bounds.width
        
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2)
        rotateAnimation.duration = 0.25
        
        refreshButton.imageView!.clipsToBounds = false;
        refreshButton.imageView!.contentMode = .center;
        refreshButton.imageView!.layer.add(rotateAnimation, forKey: "rotationAnimation");

        UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: {
            
            self.view.layoutIfNeeded()

            }) { (completion) in
                
                self.pickOptions()
                self.updateOptions()
                
                self.option1View.backgroundColor = .secondaryColor()
                self.option2View.backgroundColor = .secondaryColor()
                self.option3View.backgroundColor = .secondaryColor()
                
                self.option1CenterConstraint.constant = 0
                self.option2CenterConstraint.constant = 0
                self.option3CenterConstraint.constant = 0
                
                UIView.animate(withDuration: 0.5, delay: 0.25, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                    
                    self.view.layoutIfNeeded()
                    
                }, completion: nil)
        }
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        option1CenterConstraint.constant = 0 - view.bounds.width
        option2CenterConstraint.constant = 0 + view.bounds.width
        option3CenterConstraint.constant = 0 - view.bounds.width
        
        doneButtonBottomConstraint.constant = 0 - 16 - 48
        refreshButtonBottomConstraint.constant = 0 - 16 - 48
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.infoLabel.alpha = 0

            self.option1View.layoutIfNeeded()
            self.option2View.layoutIfNeeded()
            self.option3View.layoutIfNeeded()
            
            self.doneButton.layoutIfNeeded()
            self.refreshButton.layoutIfNeeded()
            
        }) { (completion) in
        
            self.delegate?.finishedPickingCollections(self.pickedCollections)
        }
    }
}
