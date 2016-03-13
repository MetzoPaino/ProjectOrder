//
//  SettingsViewController.swift
//  Project Order
//
//  Created by William Robinson on 13/03/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {

    @IBOutlet weak var closeBarButton: UIBarButtonItem!
    @IBOutlet weak var versionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let version = NSBundle.mainBundle().infoDictionary?["CFBundleShortVersionString"] as? String {
            versionLabel.text = "Version: \(version)"
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func closeButtonPressed(sender: UIBarButtonItem) {
        
        dismissViewControllerAnimated(true, completion: nil)
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
