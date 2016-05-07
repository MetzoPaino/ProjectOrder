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
    @IBOutlet weak var person1Label: UILabel!
    @IBOutlet weak var andLabel: UILabel!
    @IBOutlet weak var person2ImageView: UIImageView!
    @IBOutlet weak var person2Label: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleNavBar()
        styleView()
    }
    
    func styleNavBar() {
        
        navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.translucent = false
        navigationController?.view.backgroundColor = UIColor.whiteColor()
        navigationController?.navigationBar.tintColor = .primaryColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.primaryColor()]
    }

    func styleView() {
        
        person1ImageView.layer.cornerRadius = 50 / 2
        person1ImageView.clipsToBounds = true
        person2ImageView.layer.cornerRadius = 50 / 2
        person2ImageView.clipsToBounds = true
        
        let williamString = "William Robinson"
        let robynString = "Robyn Nevison"
        
        let order = Int(arc4random_uniform(UInt32(2)))
                
        switch order {
        case 0:
            person1Label.text = williamString
            person1ImageView.image = UIImage(named: "William")
            person2Label.text = robynString
            person2ImageView.image = UIImage(named: "Robyn")

        default:
            person1Label.text = robynString
            person1ImageView.image = UIImage(named: "Robyn")
            person2Label.text = williamString
            person2ImageView.image = UIImage(named: "William")
        }

        if let versionString = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            
            versionLabel.text = "Version: " + versionString
        }
    }
}
