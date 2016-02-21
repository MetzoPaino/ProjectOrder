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

class SortingViewController: UIViewController {
    
    var itemArray = [ItemModel]()
    let tournamentManager = TournamentManager()
    
    weak var delegate: SortingViewControllerDelegate?
    
    @IBOutlet weak var progressView: UIProgressView!
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var passButton: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet var topViewPanGesture: UIPanGestureRecognizer!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topLabel: UILabel!
    
    @IBOutlet weak var centerView: UIView!
    
    @IBOutlet var bottomViewPanGesture: UIPanGestureRecognizer!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleView()
        styleNavBar()
        
        tournamentManager.delegate = self
        tournamentManager.createTournament(itemArray)
//        setupButtons()
        setupBattle()
        print(centerView.center.y)

    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        

    }
    
    override func viewDidLayoutSubviews() {
    }
    
    func styleNavBar() {
        

    }
    
    func styleView() {
        topView.layer.cornerRadius = 12
        topView.layer.masksToBounds = true
        
        bottomView.layer.cornerRadius = 12
        bottomView.layer.masksToBounds = true
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
            setupButtons()
        }
    }
    
    @IBAction func optionButtonPressed(sender: UIButton) {
        
        let victoriousItem = tournamentManager.participants[sender.tag];
        var defeatedItem: ItemModel
        
        if sender.tag == option1Button.tag {
            
            defeatedItem = tournamentManager.participants[option2Button.tag];
            
        } else {
            
            defeatedItem = tournamentManager.participants[option1Button.tag];
        }
        
        tournamentManager.assignPointsForCompletedBattle(victoriousItem, loser: defeatedItem)
        
        if tournamentManager.isTournamentResolved() {
            
            self.delegate?.sortingFinished(tournamentManager.participants)
            dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            setupButtons()
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
    
    func setupButtons() {
        
        do {
            
            let battle = try tournamentManager.pickBattle()
            
            option1Button.setTitle(battle.playerOne.text, forState: UIControlState.Normal)
            option1Button.tag = battle.playerOne.tag
            
            option2Button.setTitle(battle.playerTwo.text, forState: UIControlState.Normal)
            option2Button.tag = battle.playerTwo.tag
            
        } catch PickBattleError.AlreadyTakenPlace {
            
            setupButtons()
            
        } catch {
            print("We should never get here")
        }
    }
    
    @IBAction func panGestureAction(sender: UIPanGestureRecognizer) {
        
        var constraintToEdit = NSLayoutConstraint()
        
        if sender == topViewPanGesture {
            constraintToEdit = topViewTopConstraint
        } else {
            constraintToEdit = bottomViewBottomConstraint
        }
        
        if sender.state == .Ended {
            
            UIView.animateWithDuration(0.25, delay: 0.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                constraintToEdit.constant = 16
                self.view.layoutIfNeeded()

                }, completion: nil)
            
        } else {
            
            let velocity = sender.velocityInView(view)
            
            if velocity.y > 0 || velocity.y < 0 {
                
                print("\(view.bounds.size.height) - \(sender.locationInView(view).y) = \(view.bounds.size.height - sender.locationInView(view).y)")
                
                var newConstant: CGFloat = 0
                
                if sender == topViewPanGesture {
                    
                    newConstant = sender.locationInView(view).y - topView.bounds.height
                    
                    if newConstant < 16 {
                        newConstant = 16
                    } else if newConstant > centerView.frame.origin.y - 16 {
                        
                        newConstant = centerView.frame.origin.y - 16
                    }
                    
                    constraintToEdit.constant = newConstant

                    
                    
                } else {
                    
                    newConstant = (view.bounds.size.height - sender.locationInView(view).y) + 16 - bottomView.bounds.size.height
                    
                    if newConstant < 16 {
                        newConstant = 16
                    }
                    
                }
                
                

                constraintToEdit.constant = newConstant

                
            }
        }
        


    }
}

extension SortingViewController: TournamentManagerDelegate {
    
    func percentageCompleteValueChanged(percentage: Double) {
        
        let fractionalPercentage = Float(percentage) / 100
        
        progressView.setProgress(fractionalPercentage, animated: true)
    }
}
