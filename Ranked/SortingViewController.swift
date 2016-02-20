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

//class BattleObject {
//    
//    var opponentTag = Int()
//    var won = Bool()
//    
//    init(opponentTag: Int, won: Bool) {
//        self.opponentTag = opponentTag
//        self.won = won
//    }
//}
//
//class BattleTracker {
//    
//    var battles = [(objects: [SortingModel], winner: SortingModel, loser: SortingModel)]()
//    
//    
//    var tournament = [(playerOne: SortingModel, playerTwo: SortingModel, winner: SortingModel?, loser: SortingModel?)]()
//
//}
//
//
//class SortingModel {
//    
//    var name: String
//    var battleArray = [BattleObject]()
//    var tag = Int()
//    var points = 0
//    
//    init(name: String) {
//        self.name = name
//    }
//}
//
//extension ItemModel {
//    
//
//}

//
//enum CreateBattleError: ErrorType {
//    
//    case AlreadyTakenPlace()
//}

class SortingViewController: UIViewController {
    
    var itemArray = [ItemModel]()
    let tournamentManager = TournamentManager()
    
    weak var delegate: SortingViewControllerDelegate?
    
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var passButton: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    @IBOutlet var buttonCollection: [UIButton]!
    
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var battleTextView: UITextView!
    
    @IBOutlet weak var percentageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleNavBar()
        styleButtons()
        
        tournamentManager.delegate = self
        tournamentManager.createTournament(itemArray)
        setupButtons()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        

    }
    
    func styleNavBar() {
        

    }
    
    func styleButtons() {
        
        for button in buttonCollection {
            
            button.titleLabel?.numberOfLines = 0
        }
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
}

extension SortingViewController: TournamentManagerDelegate {
    
    func percentageCompleteValueChanged(percentage: Double) {
        
        percentageLabel.text = "\(Int(percentage))% complete"
    }
}
