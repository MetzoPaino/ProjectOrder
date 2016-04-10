//
//  Helpers.swift
//  Project Order
//
//  Created by William Robinson on 10/04/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class Helper {
    
    static func largestDeviceSide() -> CGFloat {
    
        let height = UIScreen.mainScreen().bounds.height
        let width = UIScreen.mainScreen().bounds.width
    
        if height > width {
            return height
        } else {
            return width
        }
    }
}