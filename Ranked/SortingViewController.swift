//
//  SortingViewController.swift
//  Ranked
//
//  Created by William Robinson on 22/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol SortingViewControllerDelegate: class {
    func sortingFinished(items: [ItemModel])
}

enum PanGestureInUse {
    
    case top
    case bottom
}

class SortingViewController: UIViewController {
    
    var itemArray = [ItemModel]()
    let tournamentManager = TournamentManager()
    
    weak var delegate: SortingViewControllerDelegate?
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet var topViewPanGesture: UIPanGestureRecognizer!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var centerView: UIView!
    
    @IBOutlet var bottomViewPanGesture: UIPanGestureRecognizer!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var holdingView: UIView!
    @IBOutlet weak var playingFieldView: UIView!
        
    let constantConstant = 0 as CGFloat
    
    var middleConstant = 0 as CGFloat
    
    var panGestureInUse: PanGestureInUse?
    
    var animationArray = [UIImage]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleView()
        styleNavBar()
        
        tournamentManager.delegate = self
        tournamentManager.createTournament(itemArray)

        setupBattle()
        
        moveViewsOffscreen()
        
        var index = 0
        var foundImage = false
        
        repeat {
        
            let fileName = "SortingAnimation_" + String(index)
            let image = UIImage(named: fileName)
            
            if image != nil {
                foundImage = true
                animationArray.append(image!)
            } else {
                foundImage = false
            }
            index = index + 1
        
        } while foundImage
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .primaryColor()


    }
    
    override func viewDidAppear(animated: Bool) {
        animateViewsToArriveOrDepart(true)
        
        // First time setting middleConstant via viewDidLayoutSubviews is incorrect. Don't know why
        middleConstant = playingFieldView.bounds.size.height / 2
    }
    
    override func viewDidLayoutSubviews() {
        
        middleConstant = playingFieldView.bounds.size.height / 2
    }
    
    func styleNavBar() {
        

    }
    
    func styleView() {
        
        progressView.layer.cornerRadius = 6
        progressView.layer.masksToBounds = true
        progressView.backgroundColor = .backgroundColor()
        progressView.tintColor = .secondaryColor()
        progressView.trackTintColor = .backgroundColor()
        progressView.progressTintColor = .primaryColor()
        
        holdingView.layer.masksToBounds = true
        holdingView.backgroundColor = .backgroundColor()
        
        topView.layer.cornerRadius = 12
        topView.layer.masksToBounds = true
        
        bottomView.layer.cornerRadius = 12
        bottomView.layer.masksToBounds = true
        
        topView.backgroundColor = .blockColor()
        bottomView.backgroundColor = .blockColor()
        topLabel.textColor = .whiteColor()
        bottomLabel.textColor = .whiteColor()

    }
    
    // MARK: - IBAction
    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func decideLaterButtonPressed(sender: AnyObject) {
        
        if tournamentManager.isTournamentResolved() {
            
            self.delegate?.sortingFinished(tournamentManager.participants)
            dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            
            UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
                
                self.topViewTopConstraint.constant = 0 - self.view.bounds.size.height
                self.bottomViewBottomConstraint.constant = 0 - self.view.bounds.size.height
                self.topView.alpha = 0
                self.bottomView.alpha = 0
                
                self.view.layoutIfNeeded()
                
                }, completion: { (complete: Bool) -> Void in
                    
                    self.setupBattle()
                    self.animateViewsToArriveOrDepart(true)
                    
            })
            
        }
    }

    func setupBattle() {
        
        do {
            
            let battle = try tournamentManager.pickBattle()
            
            topLabel.text = battle.playerOne.text
            topView.tag = battle.playerOne.tag
            
            bottomLabel.text = battle.playerTwo.text
            bottomView.tag = battle.playerTwo.tag
            
        } catch PickBattleError.AlreadyTakenPlace {
            
            setupBattle()
            
        } catch {
            print("We should never get here")
        }

    }
    
    @IBAction func panGestureAction(sender: UIPanGestureRecognizer) {
        
        var panGesture: PanGestureInUse
        var constraintToEdit = NSLayoutConstraint()
        var view = UIView()
        var otherView = UIView()
        
        if sender == topViewPanGesture {
            constraintToEdit = topViewTopConstraint
            view = topView
            otherView = bottomView
            panGesture = .top

        } else {
            constraintToEdit = bottomViewBottomConstraint
            view = bottomView
            otherView = topView
            panGesture = .bottom

        }
        
        if panGestureInUse == nil || panGestureInUse == panGesture {
            
            panGestureInUse = panGesture
            
        } else {
            return
        }
        
        if sender.state == .Ended {
            
            let y = constraintToEdit.constant + view.bounds.height
            
            if y >= middleConstant - (centerView.bounds.height / 2) {
                
                let victoriousItem = tournamentManager.participants[view.tag];
                let defeatedItem = tournamentManager.participants[otherView.tag];
                
                tournamentManager.assignPointsForCompletedBattle(victoriousItem, loser: defeatedItem)
                
                if tournamentManager.isTournamentResolved() {
                    
                    self.delegate?.sortingFinished(tournamentManager.participants)
                    dismissViewControllerAnimated(true, completion: nil)
                    
                } else {
                    
                    imageView.image = animationArray.first
                    imageView.animationImages = animationArray.reverse()
                    imageView.animationDuration = 0.25
                    imageView.animationRepeatCount = 1
                    imageView.startAnimating()
                    
                    UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                        
                        self.topViewTopConstraint.constant = 0 - self.view.bounds.size.height
                        self.bottomViewBottomConstraint.constant = 0 - self.view.bounds.size.height
                        self.topView.alpha = 0
                        self.bottomView.alpha = 0
                        
                        self.view.layoutIfNeeded()
                        
                        }, completion: { (complete: Bool) -> Void in
                            
                            self.setupBattle()
                            self.animateViewsToArriveOrDepart(true)

                    })
                }
    
            } else {
                
                var shortenedAnimationArray = [UIImage]()

                for image in animationArray {
                    
                    if image == imageView.image {
                        
                        break
                        
                    } else {
                        
                        shortenedAnimationArray.append(image)
                    }
                }
                
                imageView.image = animationArray.first
                imageView.animationImages = shortenedAnimationArray.reverse()
                imageView.animationDuration = 0.25
                imageView.animationRepeatCount = 1
                imageView.startAnimating()
                
                animateViewsToArriveOrDepart(true)
            }
            
            panGestureInUse = nil

        } else {
            
            let velocity = sender.velocityInView(playingFieldView)
            
            if velocity.y > 0 || velocity.y < 0 {
                
                var newConstant: CGFloat = 0
                
                if sender == topViewPanGesture {
                    
                    let fullAlpha = middleConstant - (topView.bounds.height / 2)
                    let percentage = (topViewTopConstraint.constant / fullAlpha) * 100
                    let animationPercentage = (topViewTopConstraint.constant / (fullAlpha - 70)) * 100
                    var animationIndex = animationArray.count * Int(animationPercentage) / 100

                    let takeAway = CGFloat((100 - percentage) / 100) + 0.2
                    bottomView.alpha = takeAway
                    
                    if animationIndex >= animationArray.count - 1 {
                        animationIndex = animationArray.count - 1
                    }
                    
                    imageView.image = animationArray[Int(animationIndex)]
                    
                    newConstant = sender.locationInView(playingFieldView).y - topView.bounds.height
                    
                    if newConstant < 0 {
                        newConstant = 0
                        
                    }
                    else if newConstant > middleConstant - (topView.bounds.height / 2) {
                        
                        newConstant = middleConstant - (topView.bounds.height / 2)
                    }
                    
                    constraintToEdit.constant = newConstant

                    
                } else {
                    
                    let fullAlpha = middleConstant - (bottomView.bounds.height / 2)
                    let percentage = (bottomViewBottomConstraint.constant / fullAlpha) * 100
                    let animationPercentage = (bottomViewBottomConstraint.constant / (fullAlpha - 70)) * 100
                    var animationIndex = animationArray.count * Int(animationPercentage) / 100
                    
                    let takeAway = CGFloat((100 - percentage) / 100) + 0.2
                    topView.alpha = takeAway
                    
                    if animationIndex >= animationArray.count - 1 {
                        animationIndex = animationArray.count - 1
                    }
                    
                    imageView.image = animationArray[Int(animationIndex)]
                    
                    newConstant = (playingFieldView.bounds.size.height - sender.locationInView(playingFieldView).y) + self.constantConstant - bottomView.bounds.size.height
                    
                    if newConstant < self.constantConstant {
                        newConstant = self.constantConstant
                        
                    }
                    else if newConstant > middleConstant - (bottomView.bounds.height / 2) {
                        
                        newConstant = middleConstant - (bottomView.bounds.height / 2)
                    }
                }
                constraintToEdit.constant = newConstant

            }
        }
    }
    
    func animateViewsToArriveOrDepart(arrive: Bool) {
        
        var constant = 0 as CGFloat
        var alpha = 1 as CGFloat
        
        if !arrive {
            
            constant = 0 - self.view.bounds.size.height
            alpha = 0
        }
        
        for i in (1...10).reverse() {
            print(i)
        }
        
        UIView.animateWithDuration(0.25, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.topViewTopConstraint.constant = constant
            self.bottomViewBottomConstraint.constant = constant
            self.topView.alpha = alpha
            self.bottomView.alpha = alpha
            
            self.view.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    func moveViewsOffscreen() {
        
        topViewTopConstraint.constant = 0 - self.view.bounds.size.height
        bottomViewBottomConstraint.constant = 0 - self.view.bounds.size.height
        self.topView.alpha = 0
        self.bottomView.alpha = 0
        view.layoutIfNeeded()
    }
}

extension SortingViewController: TournamentManagerDelegate {
    
    func percentageCompleteValueChanged(percentage: Double) {
        
        let fractionalPercentage = Float(percentage) / 100
        
        progressView.setProgress(fractionalPercentage, animated: true)
    }
}
