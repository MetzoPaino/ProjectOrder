//
//  CustomNavigationController.swift
//  Ranked
//
//  Created by William Robinson on 20/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class CustomNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        navigationBar.shadowImage = UIImage()
        navigationBar.translucent = true
        view.backgroundColor = UIColor.clearColor()
    }
}