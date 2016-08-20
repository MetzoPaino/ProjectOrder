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
        
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
        view.backgroundColor = UIColor.clear
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .primaryColor()
        navigationBar.barTintColor = .primaryColor()
    }
}
