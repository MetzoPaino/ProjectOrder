//
//  LaunchViewController.swift
//  Project Order
//
//  Created by William Robinson on 16/04/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class LaunchViewController: UIViewController, Injectable {

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
            let image = UIImage(named: fileName)
            
            if image != nil {
                foundImage = true
                
                animationArray.append(image!.CGImage!)
            } else {
                foundImage = false
            }
            index = index + 1
            
        } while foundImage
    }
    
    func inject(dataManager: AssociatedObject) {
        self.dataManager = dataManager
    }
    
    func assertDependencies() {
        assert(dataManager != nil)
    }
    
    override func animationDidStop(anim: CAAnimation, finished flag: Bool) {
        
        performSegueWithIdentifier("Start", sender: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        
        let animation = CAKeyframeAnimation(keyPath: "contents")
        animation.calculationMode = kCAAnimationDiscrete
        animation.duration = 0.5
        animation.values = animationArray.reverse()
        animation.repeatCount = 1
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        animation.delegate = self
        imageView.layer.addAnimation(animation, forKey: "animation")
    }
    
    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let navigationController = segue.destinationViewController as? UINavigationController {
    
            let controller = navigationController.topViewController as! CollectionsViewController
                controller.inject(dataManager)
            }
    }
}
