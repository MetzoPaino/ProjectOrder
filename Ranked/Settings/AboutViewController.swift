//
//  AboutViewController.swift
//  Project Order
//
//  Created by William Robinson on 07/05/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var madeByLabel: UILabel!
    @IBOutlet weak var person1ImageView: UIImageView!
    @IBOutlet weak var person1ImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var person1Label: UILabel!
    @IBOutlet weak var andLabel: UILabel!
    @IBOutlet weak var person2ImageView: UIImageView!
    @IBOutlet weak var person2ImageViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var person2Label: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavBar()
        styleView()
    }
    
    func styleNavBar() {
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor.white()
        navigationController?.navigationBar.tintColor = .primaryColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.primaryColor()]
    }

    func styleView() {
        
        person1ImageView.layer.cornerRadius = person1ImageViewWidthConstraint.constant / 2
        person1ImageView.clipsToBounds = true
        person2ImageView.layer.cornerRadius = person2ImageViewWidthConstraint.constant / 2
        person2ImageView.clipsToBounds = true
        
        let williamString = "William Robinson"
        let williamLink = "@metzopaino"
        let robynString = "Robyn Nevison"
        let robynLink = "@greenseaweed"

        let order = Int(arc4random_uniform(UInt32(2)))
        
        let nameAttributes = [NSForegroundColorAttributeName: UIColor.headingColor(), NSFontAttributeName: UIFont.systemFont(ofSize: 22, weight: UIFontWeightRegular)]
        let linkAttributes = [NSForegroundColorAttributeName: UIColor.primaryColor(), NSFontAttributeName: UIFont.systemFont(ofSize: 16, weight: UIFontWeightLight)]
        let breakString = AttributedString(string: "\n")

        switch order {
        case 0:
            
            let topNameString = AttributedString(string: williamString, attributes: nameAttributes)
            let bottomNameString = AttributedString(string: robynString, attributes: nameAttributes)
            let topLinkString = AttributedString(string: williamLink, attributes: linkAttributes)
            let bottomLinkString = AttributedString(string: robynLink, attributes: linkAttributes)
            
            let topString = NSMutableAttributedString(attributedString: topNameString)
            topString.append(breakString)
            topString.append(topLinkString)
            
            let bottomString = NSMutableAttributedString(attributedString: bottomNameString)
            bottomString.append(breakString)
            bottomString.append(bottomLinkString)
            
            person1Label.attributedText = topString
            person1ImageView.image = UIImage(named: "William")
            person2Label.attributedText = bottomString
            person2ImageView.image = UIImage(named: "Robyn")

        default:
            
            let topNameString = AttributedString(string: robynString, attributes: nameAttributes)
            let bottomNameString = AttributedString(string: williamString, attributes: nameAttributes)
            let topLinkString = AttributedString(string: robynLink, attributes: linkAttributes)
            let bottomLinkString = AttributedString(string: williamLink, attributes: linkAttributes)
            
            let topString = NSMutableAttributedString(attributedString: topNameString)
            topString.append(breakString)
            topString.append(topLinkString)
            
            let bottomString = NSMutableAttributedString(attributedString: bottomNameString)
            bottomString.append(breakString)
            bottomString.append(bottomLinkString)
            
            person1Label.attributedText = topString
            person1ImageView.image = UIImage(named: "Robyn")
            person2Label.attributedText = bottomString
            person2ImageView.image = UIImage(named: "William")
        }

        if let versionString = Bundle.main().infoDictionary?["CFBundleShortVersionString"] as? String {
            
            versionLabel.text = "Version: " + versionString
        }
    }
}
