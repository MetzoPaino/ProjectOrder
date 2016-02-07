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
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!

    @IBOutlet var buttonCollection: [UIButton]!
    
    weak var delegate: ColorCellDelegate?
    
    func configureCell() {
        
        userInteractionEnabled = false

        for (index, button) in buttonCollection.enumerate() {
            button.tag = index
            switch index {
                
            case 0:
                button.backgroundColor = .orangeColor()
                break
            case 1:
                button.backgroundColor = .redColor()
                break
            case 2:
                button.backgroundColor = .magentaColor()
                break
            case 3:
                button.backgroundColor = .blueColor()
                break
            case 4:
                button.backgroundColor = .yellowColor()
                break
            case 5:
                button.backgroundColor = .purpleColor()
                break
            case 6:
                button.backgroundColor = .cyanColor()
                break
            case 7:
                button.backgroundColor = .greenColor()
                break
            default:
                break
            }
        }
    }
    
    @IBAction func buttonPressed(sender: UIButton) {
        
        self.delegate?.pickedNewColor(sender.tag)
    }
}
