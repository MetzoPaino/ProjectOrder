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
    
        let height = UIScreen.main().bounds.height
        let width = UIScreen.main().bounds.width
    
        if height > width {
            return height
        } else {
            return width
        }
    }
}

extension String {
    
    func trim() -> String {
        
        let components = self.components(separatedBy: CharacterSet.whitespaces).filter { !$0.isEmpty }
        return components.joined(separator: "")
    }
}
