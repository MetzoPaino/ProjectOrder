//
//  ColorManager.swift
//  Ranked
//
//  Created by William Robinson on 14/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation
import UIKit

class ColorTheme : NSObject {
    
    private let titleColorKey = "titleColor"
    private let subtitleColorKey = "subtitleColor"
    private let backgroundColorsKey = "backgroundColors"
    
    let titleColor: UIColor
    let subtitleColor: UIColor
    let backgroundColors: [UIColor]

    init(titleColor: UIColor, subtitleColor: UIColor, backgroundColors: [UIColor]) {
        
        self.titleColor = titleColor
        self.subtitleColor = subtitleColor
        self.backgroundColors = backgroundColors
    }
    
    convenience override init() {
        self.init(titleColor: .blackColor(), subtitleColor: .blackColor(), backgroundColors: [.whiteColor()])
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        if let decodedTitleColor = aDecoder.decodeObjectForKey(titleColorKey) as? UIColor {
            
            titleColor = decodedTitleColor
            
        } else {
            titleColor = .blackColor()
        }
        
        if let decodedSubtitleColor = aDecoder.decodeObjectForKey(subtitleColorKey) as? UIColor {
            
            subtitleColor = decodedSubtitleColor
            
        } else {
            subtitleColor = .blackColor()
        }
        
        if let decodedBackgroundColors = aDecoder.decodeObjectForKey(backgroundColorsKey) as? [UIColor] {
            
            backgroundColors = decodedBackgroundColors
            
        } else {
            backgroundColors = [.whiteColor()]
        }
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(titleColor, forKey: titleColorKey)
        aCoder.encodeObject(subtitleColor, forKey: subtitleColorKey)
        aCoder.encodeObject(backgroundColors, forKey: backgroundColorsKey)
    }
}

class ColorManager {
    
    let colorThemes = [
        createColorTheme1(),
        createColorTheme2(),
        createColorTheme3(),
        createColorTheme4(),
        createColorTheme5(),
        createColorTheme6(),
        createColorTheme7(),
        createColorTheme8(),
        createColorTheme9()]
}

func createColorTheme1() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 0, green: 0, blue: 0),
        subtitleColor: UIColor(red: 0, green: 0, blue: 0),
        backgroundColors:[
            UIColor(red: 255, green: 255, blue: 255)])
}

func createColorTheme2() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 84, green: 153, blue: 230),
        subtitleColor: UIColor(red: 123, green: 135, blue: 180),
        backgroundColors: [
            UIColor(red: 255, green: 255, blue: 255)])
}

func createColorTheme3() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 255, green: 91, blue: 126),
        subtitleColor: UIColor(red: 184, green: 97, blue: 116),
        backgroundColors: [
            UIColor(red: 255, green: 255, blue: 255)])
}

func createColorTheme4() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 83, green: 84, blue: 166),
        subtitleColor: UIColor(red: 158, green: 158, blue: 222),
        backgroundColors: [
            UIColor(red: 255, green: 255, blue: 255)])
}

func createColorTheme5() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 87, green: 71, blue: 122),
        subtitleColor: UIColor(red: 255, green: 255, blue: 255),
        backgroundColors: [
            UIColor(red: 255, green: 255, blue: 255)])
}

func createColorTheme6() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 249, green: 116, blue: 100),
        subtitleColor: UIColor(red: 255, green: 255, blue: 255),
        backgroundColors: [
            UIColor(red: 255, green: 255, blue: 255)])
}

func createColorTheme7() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 61, green: 139, blue: 199),
        subtitleColor: UIColor(red: 162, green: 208, blue: 243),
        backgroundColors: [UIColor(red: 255, green: 255, blue: 255)])
}

func createColorTheme8() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 255, green: 82, blue: 94),
        subtitleColor: UIColor(red: 198, green: 121, blue: 136),
        backgroundColors: [UIColor(red: 255, green: 255, blue: 255)])
}

func createColorTheme9() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 82, green: 192, blue: 178),
        subtitleColor: UIColor(red: 132, green: 207, blue: 197),
        backgroundColors: [
            UIColor(red: 255, green: 255, blue: 255)])
}

func createColorTheme100() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 255, green: 91, blue: 126),
        subtitleColor: UIColor(red: 179, green: 66, blue: 115),
        backgroundColors:[
            UIColor(red: 255, green: 255, blue: 255),
            UIColor(red: 168, green: 208, blue: 231)])
}

func createColorTheme101() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 84, green: 153, blue: 230),
        subtitleColor: UIColor(red: 123, green: 135, blue: 180),
        backgroundColors: [UIColor(red: 221, green: 235, blue: 249)])
}

func createColorTheme102() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 255, green: 91, blue: 126),
        subtitleColor: UIColor(red: 184, green: 97, blue: 116),
        backgroundColors: [UIColor(red: 254, green: 222, blue: 229)])
}

func createColorTheme103() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 83, green: 84, blue: 166),
        subtitleColor: UIColor(red: 158, green: 158, blue: 222),
        backgroundColors: [
            UIColor(red: 255, green: 252, blue: 252),
            UIColor(red: 181, green: 182, blue: 233)])
}

func createColorTheme104() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 87, green: 71, blue: 122),
        subtitleColor: UIColor(red: 255, green: 255, blue: 255),
        backgroundColors: [
            UIColor(red: 255, green: 226, blue: 195),
            UIColor(red: 125, green: 124, blue: 218)])
}

func createColorTheme105() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 249, green: 116, blue: 100),
        subtitleColor: UIColor(red: 255, green: 255, blue: 255),
        backgroundColors: [
            UIColor(red: 255, green: 226, blue: 155),
            UIColor(red: 255, green: 161, blue: 78)])
}

func createColorTheme106() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 61, green: 139, blue: 199),
        subtitleColor: UIColor(red: 162, green: 208, blue: 243),
        backgroundColors: [UIColor(red: 49, green: 51, blue: 76)])
}

func createColorTheme107() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 255, green: 82, blue: 94),
        subtitleColor: UIColor(red: 198, green: 121, blue: 136),
        backgroundColors: [UIColor(red: 69, green: 49, blue: 76)])
}

func createColorTheme108() -> ColorTheme {
    
    return ColorTheme(
        titleColor: UIColor(red: 82, green: 192, blue: 178),
        subtitleColor: UIColor(red: 132, green: 207, blue: 197),
        backgroundColors: [
            UIColor(red: 255, green: 255, blue: 255),
            UIColor(red: 204, green: 233, blue: 226)])
}

extension UIColor
{
    convenience init(red: Int, green: Int, blue: Int)
    {
        let newRed = CGFloat(red)/255
        let newGreen = CGFloat(green)/255
        let newBlue = CGFloat(blue)/255
        
        self.init(red: newRed, green: newGreen, blue: newBlue, alpha: 1.0)
    }
}