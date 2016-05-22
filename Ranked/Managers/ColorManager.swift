//
//  ColorManager.swift
//  Project Order
//
//  Created by William Robinson on 09/04/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

extension UIColor {
    
    public class func primaryColor() -> UIColor {
        
        return UIColor(red: 255/255, green: 26/255, blue: 115/255, alpha: 1.0)
    }
    
    public class func secondaryColor() -> UIColor {
        
        return UIColor(red: 107/255, green: 220/255, blue: 208/255, alpha: 1.0)
    }
    
    public class func tertiaryColor() -> UIColor {
        
        return UIColor(red: 44/255, green: 49/255, blue: 70/255, alpha: 1.0)
    }
    
    public class func warningColor() -> UIColor {
        
        return UIColor(red: 219/255, green: 33/255, blue: 66/255, alpha: 1.0)
    }
    
    public class func backgroundColor() -> UIColor {

        return UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
    }
    
    public class func headingColor() -> UIColor {
        
        return UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1.0)
    }
    
    public class func subHeadingColor() -> UIColor {
        
        return UIColor(red: 114/255, green: 113/255, blue: 110/255, alpha: 1.0)
    }
    
    public class func titleColor() -> UIColor {
        
        return UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1.0)
    }
    
    public class func secondColor() -> UIColor {
        
        return UIColor(red: 103/255, green: 169/255, blue: 178/255, alpha: 1.0)
    }
    
    public class func thirdColor() -> UIColor {
        
        return UIColor(red: 91/255, green: 129/255, blue: 153/255, alpha: 1.0)
    }
    
    public class func loserColor() -> UIColor {
        
        return UIColor(red: 58/255, green: 69/255, blue: 113/255, alpha: 1.0)
    }
    
    public class func blockNeutralColor() -> UIColor {

        //return UIColor(red: 226/255, green: 47/255, blue: 117/255, alpha: 1.0)
        return UIColor(red: 66/255, green: 77/255, blue: 116/255, alpha: 1.0)

    }
    
    public class func blockPreferredColor() -> UIColor {
        
        return .primaryColor()
//        return UIColor(red: 66/255, green: 77/255, blue: 116/255, alpha: 1.0)
    }
    
    public class func blockLosingColor() -> UIColor {
        
//        return UIColor(red: 190/255, green: 54/255, blue: 107/255, alpha: 1.0)
        return UIColor(red: 153/255, green: 177/255, blue: 208/255, alpha: 1.0)

    }
    
    public class func sortColor() -> UIColor {
        
        return UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1.0)
    }
    
    public class func disabledColor() -> UIColor {
        
        return UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
    }
    
    public class func sortingNeutralBackgroundColor() -> UIColor {
        
        return .whiteColor()
    }
    
    public class func sortingPreferredBackgroundColor() -> UIColor {
        return .whiteColor()

//        return UIColor(red: 230/255, green: 252/255, blue: 252/255, alpha: 1.0)
    }
}

extension UIColor {
    
    class func colorFromPercentageInRange(percentage: Float, startColor: UIColor, endColor: UIColor) -> UIColor {
        
        let coreImage1 = startColor.coreImageColor
        let coreImage2 = endColor.coreImageColor
        
        if coreImage1 != nil && coreImage2 != nil {
            
            let redMinimum = Float((coreImage1!.red / 100) * 255 * 100)
            let greenMinimum = Float((coreImage1!.green / 100) * 255 * 100)
            let blueMinimum = Float((coreImage1!.blue / 100) * 255 * 100)

            let redMaximum = Float((coreImage2!.red / 100) * 255 * 100)
            let greenMaximum = Float((coreImage2!.green / 100) * 255 * 100)
            let blueMaximum = Float((coreImage2!.blue / 100) * 255 * 100)

            let newRed = CGFloat((percentage * (redMaximum - redMinimum) / 100) + redMinimum)
            let newGreen = CGFloat((percentage * (greenMaximum - greenMinimum) / 100) + greenMinimum)
            let newBlue = CGFloat((percentage * (blueMaximum - blueMinimum) / 100) + blueMinimum)

            return UIColor(red: newRed/255, green: newGreen/255, blue: newBlue/255, alpha: 1.0)

        } else {
            
            return .whiteColor()
        }
    }
}

extension UIColor {
    var coreImageColor: CoreImage.CIColor? {
        return CoreImage.CIColor(color: self)  // The resulting Core Image color, or nil
    }
}