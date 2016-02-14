//
//  ColorPickerView.swift
//  Ranked
//
//  Created by William Robinson on 14/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import QuartzCore

protocol ColorPickerViewDelegate: class {
    func pickedNewColor(index: Int)
}

class ColorPickerView: UIView {

    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    
    @IBOutlet var buttonCollection: [UIButton]!

    weak var delegate: ColorPickerViewDelegate?

    override func drawRect(rect: CGRect) {
        
        for button in buttonCollection {
            
            button.layer.cornerRadius = button.bounds.size.width / 2.0;
        }
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        print(sender.tag)
        self.delegate?.pickedNewColor(sender.tag)
    }
}
