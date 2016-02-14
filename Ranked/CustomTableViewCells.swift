//
//  TableViewCells.swift
//  Ranked
//
//  Created by William Robinson on 07/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol ColorCellDelegate: class {
    func pickedNewColor(index: Int)
}

class ColorCell: UITableViewCell {

    @IBOutlet weak var scrollView: UIScrollView!
    
    let colorManager = ColorManager()
    var laidOut = false
    
    weak var delegate: ColorCellDelegate?
    
    override func layoutSubviews() {
        
        if !laidOut {
            laidOut = false
            
            let subviews = self.scrollView.subviews
            for subview in subviews{
                subview.removeFromSuperview()
            }
            
            self.scrollView.contentSize = CGSizeMake(self.scrollView.bounds.width * 3,
                self.scrollView.bounds.height)
            
            let scrollViewWidth:CGFloat = self.scrollView.bounds.width
            let scrollViewHeight:CGFloat = self.scrollView.bounds.height
            
            var itterator = 0
            
            if let colorPicker = NSBundle.mainBundle().loadNibNamed("ColorPicker", owner: self, options: nil).first as? ColorPickerView {
                colorPicker.frame = CGRectMake(0, 0,scrollViewWidth, scrollViewHeight)
                self.scrollView.addSubview(colorPicker)
                colorPicker.delegate = self

                for button in colorPicker.buttonCollection {

                    button.tag = itterator

                    if itterator < colorManager.colorThemes.count {
                        
                        button.backgroundColor = colorManager.colorThemes[itterator].titleColor
                    } else {
                        button.alpha = 0
                        button.userInteractionEnabled = false
                    }
                    itterator = itterator + 1
                }
            }
            
            if let colorPicker = NSBundle.mainBundle().loadNibNamed("ColorPicker", owner: self, options: nil).first as? ColorPickerView {
                colorPicker.frame = CGRectMake(scrollViewWidth, 0,scrollViewWidth, scrollViewHeight)
                self.scrollView.addSubview(colorPicker)
                colorPicker.delegate = self

                for button in colorPicker.buttonCollection {
                    
                    button.tag = itterator

                    if itterator < colorManager.colorThemes.count {
                        
                        button.backgroundColor = colorManager.colorThemes[itterator].titleColor
                    } else {
                        button.alpha = 0
                        button.userInteractionEnabled = false
                    }
                    itterator = itterator + 1
                }
            }
            
            if let colorPicker = NSBundle.mainBundle().loadNibNamed("ColorPicker", owner: self, options: nil).first as? ColorPickerView {
                colorPicker.frame = CGRectMake(scrollViewWidth*2, 0,scrollViewWidth, scrollViewHeight)
                self.scrollView.addSubview(colorPicker)
                colorPicker.delegate = self
                for button in colorPicker.buttonCollection {
                    
                    button.tag = itterator

                    if itterator < colorManager.colorThemes.count {
                        
                        button.backgroundColor = colorManager.colorThemes[itterator].titleColor
                    } else {
                        button.alpha = 0
                        button.userInteractionEnabled = false
                    }
                    itterator = itterator + 1
                }
            }
        }
    }
    
    func configureCell() {
        
//        scrollView.userInteractionEnabled = false
//        contentView.addGestureRecognizer(scrollView.panGestureRecognizer)
    }
}

extension ColorCell: ColorPickerViewDelegate {
    
    func pickedNewColor(index: Int) {
        
        self.delegate?.pickedNewColor(index)
    }
}
