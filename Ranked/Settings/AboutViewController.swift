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
    
    @IBOutlet weak var topButton: UIButton!
    @IBOutlet weak var bottomButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavBar()
        styleView()
    }
    
    func styleNavBar() {
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor.white
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
        let breakString = NSAttributedString(string: "\n")

        switch order {
        case 0:
            
            let topNameString = NSAttributedString(string: williamString, attributes: nameAttributes)
            let bottomNameString = NSAttributedString(string: robynString, attributes: nameAttributes)
            let topLinkString = NSAttributedString(string: williamLink, attributes: linkAttributes)
            let bottomLinkString = NSAttributedString(string: robynLink, attributes: linkAttributes)
            
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
            
            topButton.tag = 0
            bottomButton.tag = 1


        default:
            
            let topNameString = NSAttributedString(string: robynString, attributes: nameAttributes)
            let bottomNameString = NSAttributedString(string: williamString, attributes: nameAttributes)
            let topLinkString = NSAttributedString(string: robynLink, attributes: linkAttributes)
            let bottomLinkString = NSAttributedString(string: williamLink, attributes: linkAttributes)
            
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
            
            topButton.tag = 1
            bottomButton.tag = 0
        }

        if let versionString = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String {
            
            versionLabel.text = "Version: " + versionString
        }
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        var url: URL
        
        if sender.tag == 0 {
            
            // William
            url = URL(string: "twitter://user?screen_name=metzopaino")!
            
        } else {
            
            // Robyn
            url = URL(string: "twitter://user?screen_name=greenseaweed")!
        }
        
        if UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        } else {
            
            if sender.tag == 0 {
                
                // William
                url = URL(string: "https://www.twitter.com/metzopaino")!
                
            } else {
                
                // Robyn
                url = URL(string: "https://www.twitter.com/greenseaweed")!
            }
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            } else {
                // Fallback on earlier versions
            }
        }
    }
}
