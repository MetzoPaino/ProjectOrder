//
//  SortingViewController.swift
//  Ranked
//
//  Created by William Robinson on 22/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import QuartzCore

protocol SortingViewControllerDelegate: class {
    func sortingFinished(_ items: [ItemModel])
    func sortingCancelled()
}

enum PanGestureInUse {
    
    case top
    case bottom
}

class SortingViewController: UIViewController {
    
    var itemArray = [ItemModel]()
    let tournamentManager = TournamentManager()
    var image: UIImage?
    
    weak var delegate: SortingViewControllerDelegate?
    
    @IBOutlet weak var progressView: UIProgressView!
    
    @IBOutlet var topViewPanGesture: UIPanGestureRecognizer!
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var topViewTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageView: UIImageView!
    @IBOutlet weak var topImageViewWidthConstraint: NSLayoutConstraint!

    @IBOutlet weak var topLabel: UILabel!
    @IBOutlet weak var topLabelLeadingConstraint: NSLayoutConstraint!

    
    @IBOutlet weak var centerView: UIView!
    
    @IBOutlet var bottomViewPanGesture: UIPanGestureRecognizer!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var bottomImageView: UIImageView!
    @IBOutlet weak var bottomImageViewWidthConstraint: NSLayoutConstraint!

    @IBOutlet weak var bottomLabel: UILabel!
    @IBOutlet weak var bottomLabelTrailingConstraint: NSLayoutConstraint!

    @IBOutlet weak var bottomViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet var holdingView: UIView!
    @IBOutlet weak var playingFieldView: UIView!
        
    @IBOutlet weak var decideLaterBarButton: UIBarButtonItem!
    
    var decideLaterImage: UIImageView!

    var blockColor = UIColor.secondaryColor()
    let losingBlockColor = UIColor(red:196/255, green:241/255, blue:236/255, alpha:1.0)
    
    var originalSortedItems = [ItemModel]()
    var originallySorted = false
    
    //Downy = UIColor(red:0.38, green:0.84, blue:0.79, alpha:1.00)
    //Light sea green = UIColor(red:0.16, green:0.71, blue:0.63, alpha:1.00)
    
    let constantConstant = 0 as CGFloat
    
    var middleConstant = 0 as CGFloat
    
    var panGestureInUse: PanGestureInUse?
    
    var animationArray = [UIImage]()
    var chooseLaterAnimationArray = [UIImage]()
    
    //MARK: - Setup

    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleView()
        styleNavBar()
        
        if originallySorted {
            originalSortedItems = itemArray
        }
        
        for item in itemArray {
            item.score = nil
        }
        
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
        
        index = 0
        foundImage = false
        
        repeat {
            
            let fileName = "ChooseLaterAnimation_" + String(index)
            let image = UIImage(named: fileName)?.withRenderingMode(.alwaysTemplate)
            
            if image != nil {
                foundImage = true
                chooseLaterAnimationArray.append(image!)
            } else {
                foundImage = false
            }
            index = index + 1
            
        } while foundImage
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        navigationController?.navigationBar.tintColor = .primaryColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        animateViewsToArriveOrDepart(true)
        
        // First time setting middleConstant via viewDidLayoutSubviews is incorrect. Don't know why
        middleConstant = playingFieldView.bounds.size.height / 2
    }
    
    override func viewDidLayoutSubviews() {
        
        middleConstant = playingFieldView.bounds.size.height / 2
    }
    
    //MARK: - Style
    
    func styleNavBar() {
        
        if let image = image {
            
            let imageView = UIImageView(image:image)
            imageView.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
            imageView.clipsToBounds = true
            imageView.layer.cornerRadius = 18
            //
            //imageView.layer.masksToBounds = true
            imageView.contentMode = .scaleAspectFit

            //self.navigationItem.titleView = imageView
        }
    }
    
    func styleView() {
        
        progressView.layer.cornerRadius = 6
        progressView.layer.masksToBounds = true
        progressView.backgroundColor = .backgroundColor()
        progressView.tintColor = .secondaryColor()
        progressView.trackTintColor = .backgroundColor()
        progressView.progressTintColor = .secondaryColor()
        
        holdingView.layer.masksToBounds = true
        holdingView.backgroundColor = .sortingNeutralBackgroundColor()
        
        topView.layer.cornerRadius = 12
        topView.layer.masksToBounds = true
        
        bottomView.layer.cornerRadius = 12
        bottomView.layer.masksToBounds = true
        
        topView.backgroundColor = blockColor
        bottomView.backgroundColor = blockColor

        topLabel.textColor = .white
        bottomLabel.textColor = .white
        
        topImageView.layer.cornerRadius = 64 / 2
        bottomImageView.layer.cornerRadius = 64 / 2
        
        topImageView.layer.masksToBounds = true
        bottomImageView.layer.masksToBounds = true

        topView.layer.shadowColor = UIColor.black.cgColor;
        topView.layer.shadowOpacity = 0.25
        topView.layer.shadowRadius = 2
        topView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        topView.layer.masksToBounds = false
        
        bottomView.layer.shadowColor = UIColor.black.cgColor;
        bottomView.layer.shadowOpacity = 0.25
        bottomView.layer.shadowRadius = 2
        bottomView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        bottomView.layer.masksToBounds = false
        
        decideLaterImage = UIImageView(image: UIImage(named: "ChooseLaterAnimation_0"))
        decideLaterImage.tintColor = .green
        decideLaterImage.animationImages = chooseLaterAnimationArray
        
        let button = UIButton(type: .custom)
        button.bounds = decideLaterImage.bounds
        button.addTarget(self, action: #selector(SortingViewController.decideLaterButtonPressed(_:)), for: .touchUpInside)
        button.addSubview(decideLaterImage)
        button.tintColor = .green
        decideLaterBarButton.customView = button
        decideLaterBarButton.tintColor = .green

    }
    
    // MARK: - IBAction
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        
        if originallySorted {
            itemArray = originalSortedItems
        } else {
            tournamentManager.wipeTournamentProgress()
        }

        self.delegate?.sortingCancelled()
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func decideLaterButtonPressed(_ sender: UIBarButtonItem) {

        if tournamentManager.isTournamentResolved() {
            
            self.delegate?.sortingFinished(tournamentManager.participants)
            dismiss(animated: true, completion: nil)
            
        } else {
            
            decideLaterImage.animationImages = chooseLaterAnimationArray
            decideLaterImage.animationDuration = 0.25
            decideLaterImage.animationRepeatCount = 1
            decideLaterImage.startAnimating()
            
            UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions.curveEaseIn, animations: { () -> Void in
                
                self.topViewTopConstraint.constant = 0 - self.view.bounds.size.height
                self.bottomViewBottomConstraint.constant = 0 - self.view.bounds.size.height

                self.topView.backgroundColor = self.blockColor
                self.bottomView.backgroundColor = self.blockColor
                
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
            
            if let image = battle.playerOne.image {
                topImageView.image = image
                topImageViewWidthConstraint.constant = 64
                topLabelLeadingConstraint.constant = 16
                topLabel.textAlignment = .left

            } else {
                topImageViewWidthConstraint.constant = 0
                topLabelLeadingConstraint.constant = 0
                topLabel.textAlignment = .center

            }
            
            bottomLabel.text = battle.playerTwo.text
            bottomView.tag = battle.playerTwo.tag
            
            if let image = battle.playerTwo.image {
                bottomImageView.image = image
                bottomImageViewWidthConstraint.constant = 64
                bottomLabelTrailingConstraint.constant = 16
                bottomLabel.textAlignment = .right
            } else {
                bottomImageViewWidthConstraint.constant = 0
                bottomLabelTrailingConstraint.constant = 0
                bottomLabel.textAlignment = .center
            }
            
        } catch PickBattleError.alreadyTakenPlace {
            
            setupBattle()
            
        } catch {
            print("We should never get here")
        }

    }
    
    @IBAction func panGestureAction(_ sender: UIPanGestureRecognizer) {
        
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
        
        decideLaterBarButton.isEnabled = false
        
        if sender.state == .ended {
            
            decideLaterBarButton.isEnabled = true

            let y = constraintToEdit.constant + view.bounds.height
            
            if y >= middleConstant - (centerView.bounds.height / 2) {
                
                let victoriousItem = tournamentManager.participants[view.tag];
                let defeatedItem = tournamentManager.participants[otherView.tag];
                
                tournamentManager.assignPointsForCompletedBattle(victoriousItem, loser: defeatedItem)
                
                if tournamentManager.isTournamentResolved() {
                    
                    self.delegate?.sortingFinished(tournamentManager.participants)
                    dismiss(animated: true, completion: nil)
                    
                } else {
                    
                    imageView.image = animationArray.first
                    imageView.animationImages = animationArray.reversed()
                    imageView.animationDuration = 0.25
                    imageView.animationRepeatCount = 1
                    imageView.startAnimating()
                    
                    UIView.animate(withDuration: 0.25, delay: 0.0, options: UIViewAnimationOptions(), animations: { () -> Void in
                        
                        self.topViewTopConstraint.constant = 0 - self.view.bounds.size.height
                        self.bottomViewBottomConstraint.constant = 0 - self.view.bounds.size.height
                        self.topView.backgroundColor = self.blockColor
                        self.bottomView.backgroundColor = self.blockColor
                        
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
                imageView.animationImages = shortenedAnimationArray.reversed()
                imageView.animationDuration = 0.25
                imageView.animationRepeatCount = 1
                imageView.startAnimating()
                
                animateViewsToArriveOrDepart(true)
            }
            
            panGestureInUse = nil

        } else {
            
            let velocity = sender.velocity(in: playingFieldView)
            
            if velocity.y > 0 || velocity.y < 0 {
                
                var newConstant: CGFloat = 0
                
                if sender == topViewPanGesture {
                    
                    let fullAlpha = middleConstant - (topView.bounds.height / 2)
                    let percentage = (topViewTopConstraint.constant / fullAlpha) * 100
                    let animationPercentage = (topViewTopConstraint.constant / (fullAlpha - 90)) * 100
                    var animationIndex = animationArray.count * Int(animationPercentage) / 100
                    
                    holdingView.backgroundColor = UIColor.colorFromPercentageInRange(Float(percentage), startColor: .sortingNeutralBackgroundColor(), endColor: .sortingPreferredBackgroundColor())
                    
                    bottomView.backgroundColor = UIColor.colorFromPercentageInRange(Float(percentage), startColor: self.blockColor, endColor: self.losingBlockColor)
                    
                    topView.backgroundColor = UIColor.colorFromPercentageInRange(Float(percentage), startColor: self.blockColor, endColor: .blockPreferredColor())
                    
                    if animationIndex >= animationArray.count - 1 {
                        animationIndex = animationArray.count - 1
                    }
                    
                    imageView.image = animationArray[Int(animationIndex)]
                    
                    newConstant = sender.location(in: playingFieldView).y - topView.bounds.height
                    
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
                    
                    topView.backgroundColor = UIColor.colorFromPercentageInRange(Float(percentage), startColor: self.blockColor, endColor: self.losingBlockColor)
                    
                    bottomView.backgroundColor = UIColor.colorFromPercentageInRange(Float(percentage), startColor: self.blockColor, endColor: .blockPreferredColor())
                    
                    if animationIndex >= animationArray.count - 1 {
                        animationIndex = animationArray.count - 1
                    }
                    
                    imageView.image = animationArray[Int(animationIndex)]
                    
                    newConstant = (playingFieldView.bounds.size.height - sender.location(in: playingFieldView).y) + self.constantConstant - bottomView.bounds.size.height
                    
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
    
    func animateViewsToArriveOrDepart(_ arrive: Bool) {
        
        var constant = 0 as CGFloat
        
        if !arrive {
            
            constant = 0 - self.view.bounds.size.height
        }
        
        UIView.animate(withDuration: 0.25, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.topViewTopConstraint.constant = constant
            self.bottomViewBottomConstraint.constant = constant
            
            self.topView.backgroundColor = self.blockColor
            self.bottomView.backgroundColor = self.blockColor
            
            self.holdingView.backgroundColor = .sortingNeutralBackgroundColor()
            
            self.view.layoutIfNeeded()
            
            }, completion: nil)
    }
    
    func moveViewsOffscreen() {
        
        topViewTopConstraint.constant = 0 - self.view.bounds.size.height
        bottomViewBottomConstraint.constant = 0 - self.view.bounds.size.height
        
        topView.backgroundColor = self.blockColor
        bottomView.backgroundColor = self.blockColor
        view.layoutIfNeeded()
    }
}

extension SortingViewController: TournamentManagerDelegate {
    
    func percentageCompleteValueChanged(_ percentage: Double) {
        
        let fractionalPercentage = Float(percentage) / 100
        
        progressView.setProgress(fractionalPercentage, animated: true)
    }
}
