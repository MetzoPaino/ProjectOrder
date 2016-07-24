//
//  LaunchViewController.swift
//  Project Order
//
//  Created by William Robinson on 16/04/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController, CAAnimationDelegate, Injectable {

    @IBOutlet weak var imageView: UIImageView!
    var animationArray = [CGImage]()
    
    typealias AssociatedObject = DataManager
    private var dataManager: DataManager!

    override func viewDidLoad() {
        super.viewDidLoad()

        var index = 0
        var foundImage = false
        
        repeat {
            
            let fileName = "SortingAnimation_" + String(index)
            if let image = UIImage(named: fileName) {
                
                foundImage = true
                
                animationArray.append(image.cgImage!)
            } else {
                
                foundImage = false

            }
            
//            if image != nil {
//                foundImage = true
//                
//                animationArray.append(image!.CGImage!)
//            } else {
//                foundImage = false
//            }
            index = index + 1
            
        } while foundImage
    }
    
    func inject(_ dataManager: AssociatedObject) {
        self.dataManager = dataManager
    }
    
    func assertDependencies() {
        assert(dataManager != nil)
    }
    
    func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        
        performSegue(withIdentifier: "Start", sender: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        let animation = CAKeyframeAnimation(keyPath: "contents")
        animation.calculationMode = kCAAnimationDiscrete
        animation.duration = 0.5
        animation.values = animationArray.reversed()
        animation.repeatCount = 1
        animation.isRemovedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
        imageView.layer.add(animation, forKey: "animation")
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let navigationController = segue.destinationViewController as? UINavigationController {
    
            let controller = navigationController.topViewController as! CollectionsViewController
                controller.inject(dataManager)
            }
    }
}
