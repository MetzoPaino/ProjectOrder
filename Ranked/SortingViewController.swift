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
    
    @IBOutlet weak var playingFieldView: UIView!
    
    var colorTheme = ColorTheme()
    
    let constantConstant = 0 as CGFloat
    
    var middleConstant = 0 as CGFloat
    
    var panGestureInUse: PanGestureInUse?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleView()
        styleNavBar()
        
        tournamentManager.delegate = self
        tournamentManager.createTournament(itemArray)

        setupBattle()
        
        moveViewsOffscreen()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        

    }
    
    override func viewDidAppear(animated: Bool) {
        animateViewsToArriveOrDepart(true)
    }
    
    override func viewDidLayoutSubviews() {
        
        middleConstant = playingFieldView.bounds.size.height / 2
        print(middleConstant)
    }
    
    func styleNavBar() {
        

    }
    
    func styleView() {
        
        topView.layer.cornerRadius = 12
        topView.layer.masksToBounds = true
        
        bottomView.layer.cornerRadius = 12
        bottomView.layer.masksToBounds = true
        
        topView.backgroundColor = colorTheme.titleColor
        bottomView.backgroundColor = colorTheme.titleColor
        topLabel.textColor = colorTheme.backgroundColors[0]
        bottomLabel.textColor = colorTheme.backgroundColors[0]

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
                
                animateViewsToArriveOrDepart(true)
            }
            
            panGestureInUse = nil

        } else {
            
            let velocity = sender.velocityInView(playingFieldView)
            
            if velocity.y > 0 || velocity.y < 0 {
                
                var newConstant: CGFloat = 0
                
                if sender == topViewPanGesture {
                    
                    newConstant = sender.locationInView(playingFieldView).y - topView.bounds.height
                    
                    if newConstant < 0 {
                        newConstant = 0
                        
                    }
                    else if newConstant > middleConstant - (topView.bounds.height / 2) {
                        
                        newConstant = middleConstant - (topView.bounds.height / 2)
                    }
                    
                    constraintToEdit.constant = newConstant

                    
                    
                } else {
                    
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
        
        UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
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
