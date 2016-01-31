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

    
//    var currentBattleIndex = 0
    //    var battleTracker = BattleTracker()
    //    var sortingList = [SortingModel]()
    
    @IBOutlet weak var option1Button: UIButton!
    @IBOutlet weak var passButton: UIButton!
    @IBOutlet weak var option2Button: UIButton!
    
    @IBOutlet weak var outputLabel: UILabel!
    @IBOutlet weak var battleTextView: UITextView!
    
    @IBOutlet weak var percentageLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        sortingList = createList()
//        sortingList = createHarryPotterList()
        
        tournamentManager.delegate = self
        tournamentManager.createTournament(itemArray)
        setupButtons()
    
        
//        
//        createTournament()
//        outputState()
//        
//        createMatch()
        
        
        print("")
//        createBattle()
//        outputState()
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
        
//        tournamentManager.tournament[currentBattleIndex].winner = tournamentManager.participants[sender.tag]
//        tournamentManager.tournament[currentBattleIndex].loser = tournamentManager.participants[defeatedItem.tag]
//        tournamentManager.participants[sender.tag].points += 1
//    
//        tournamentManager.autoResolveBattlesFromWinnerAndLoserInTournament(tournamentManager.participants[sender.tag], loser: defeatedItem)
        
        if tournamentManager.isTournamentResolved() {
            
            self.delegate?.sortingFinished(tournamentManager.participants)
            dismissViewControllerAnimated(true, completion: nil)
            
        } else {
            setupButtons()
        }

        
//        attemptToAutoResolveFromWinnerAndLoser(sortingList[sender.tag], loser: defeatedSortingObject)
        
        
//        outputState()
//        outputTournament()
//        print("    \(sortingList[option2Button.tag].name) defeated \(defeatedSortingObject.name)")
        
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

//    func createTournament() {
//        
//        var itterator = 0
//        
//        while itterator < sortingList.count {
//            
//            for sortingObject in sortingList {
//                
//                let firstObject = sortingList[itterator]
//                
//                if sortingObject.tag > itterator {
//                    
//                    print("\(firstObject.name) v \(sortingObject.name)")
//                    
//                    battleTracker.tournament.append((playerOne: firstObject, playerTwo: sortingObject, winner: nil, loser: nil))
//                }
//            }
//            itterator++
//        }
//        
//        print(" ")
//    }
    
//    func outputTournament() {
//        
//        var string = String()
//        
//        for battle in battleTracker.tournament {
//            
//            if let winnerString = battle.winner?.name {
//                
//                string += "\(battle.playerOne.name) v \(battle.playerTwo.name) = \(winnerString)\n"
//            } else {
//                string += "\(battle.playerOne.name) v \(battle.playerTwo.name)\n"
//            }
////            print("\(battle.playerOne.name) v \(battle.playerTwo.name) = \(battle.winner?.name)")
//        }
//        
//        battleTextView.text = string
//    }
    
//    func checkValidity() -> Bool {
//        
//        var finishedMatches = 0
//        
//        for battle in battleTracker.tournament {
//            
//            if let _ = battle.winner {
//                
//                finishedMatches += 1
//            }
//        }
//        
//        if finishedMatches == battleTracker.tournament.count {
//            
//            outputState()
//            
//            print("All matches decided")
//            return true
//        }
//        return false
//    }
    
//    func createMatch() {
//        
//        if checkValidity() {
//            return
//        }
//        
//        currentBattleIndex = randomNumberInRange(battleTracker.tournament.count)
//        
//        let battle = battleTracker.tournament[currentBattleIndex]
//        
//        if battle.winner != nil {
//            
//            createMatch()
//            return
//            
//        } else {
//            
//            option1Button.setTitle(battle.playerOne.name, forState: UIControlState.Normal)
//            option1Button.tag = battle.playerOne.tag
//            
//            option2Button.setTitle(battle.playerTwo.name, forState: UIControlState.Normal)
//            option2Button.tag = battle.playerTwo.tag
//        }
//    }
    
//    func attemptToAutoResolveFromWinnerAndLoser(winner: SortingModel, loser: SortingModel) {
//        
//        // After picking a winner, we look at the loser & see if it has won any matches anywhere else in the tournament
//        // If we know RoJ has defeated PM, but RoJ just lost to ESB && we know PM & ESM has not been resolved we can auto resolve
//        
//        
//        autoCompleteLoop(winner, loser: loser)
//        
//        
////        var test = autoCompleteLoop(winner, loser: loser)
////        
////        if test.count > 0 {
////            print("!")
////        }
//
//        
//        
//        
////        var superLoser: SortingModel
////        
////        
////        for battle in battleTracker.tournament {
////            
////            if loser.tag == battle.winner?.tag {
////                
////                // Current loser has been a winner elsewhere
////                
////                superLoser = battle.loser!
////                
////                for (index, battle2) in battleTracker.tournament.enumerate() {
////                    
////                    if battle2.winner == nil {
////                        
////                        let comparisonArray = [battle2.playerOne, battle2.playerTwo]
////                        
////                        if comparisonArray.containsReference(winner) && comparisonArray.containsReference(superLoser) {
////                            
////                            print("Because \(winner.name) defeated \(loser.name), but \(loser.name) defeated \(superLoser.name) & \(winner.name) hasn't fought \(superLoser.name) we can safely say \(winner.name) would defeat \(superLoser.name)")
////                            print("We can auto resolve!")
////                            
////                            battleTracker.tournament[index].winner = winner
////                            battleTracker.tournament[index].loser = superLoser
////                            sortingList[winner.tag].points += 1
////                            
////                            outputState()
////                            outputTournament()
////                        }
////                    } else {
////                        
////                        print("We could auto figure this out, but its already been done")
////                    }
////                }
////            }
////        }
//    }
    
//    func autoCompleteLoop(winner: SortingModel, loser: SortingModel) {
//        
//        var superLoser: SortingModel
//        var superLoserArray = [SortingModel]()
//        
//        for battle in battleTracker.tournament {
//            
//            if loser.tag == battle.winner?.tag {
//    
//                // Current loser has been a winner elsewhere
//                
//                superLoser = battle.loser!
//                
//                if superLoser.tag == winner.tag {
//                    print("What the fuck?")
//                    break
//                } else {
//                    superLoserArray.append(superLoser)
//                }
//                
//                for (index, battle2) in battleTracker.tournament.enumerate() {
//                    
//                    if battle2.winner == nil {
//                        
//                        let comparisonArray = [battle2.playerOne, battle2.playerTwo]
//                        
//                        if comparisonArray.containsReference(winner) && comparisonArray.containsReference(superLoser) {
//                        
//                            
//                            print("Because \(winner.name) defeated \(loser.name), but \(loser.name) defeated \(superLoser.name) & \(winner.name) hasn't fought \(superLoser.name) we can safely say \(winner.name) would defeat \(superLoser.name)")
//                            print("We can auto resolve!")
//                            
//                            battleTracker.tournament[index].winner = winner
//                            battleTracker.tournament[index].loser = superLoser
//                            sortingList[winner.tag].points += 1
//                            
//                            outputState()
//                            outputTournament()
//                        }
//                    } else {
//                        
////                        print("We could auto figure this out, but its already been done")
//                    }
//                }
//            }
//        }
//        
//        for uberLoser in superLoserArray {
//            
//            print("Time to go deeper")
//            autoCompleteLoop(winner, loser: uberLoser)
//        }
//    }
    
//    func randomNumberInRange(range: Int) -> Int {
//        
//        return Int(arc4random_uniform(UInt32(range)))
//    }
//    
    // MARK: - IBAction
    
    
    
    


    
    

    
//    func outputState() {
//        
//        var string = String()
//        
//        for sortingObject in sortingList {
//            
//            string += ("\(sortingObject.name) = \(sortingObject.points)\n")
//        }
//        
//        var finishedBattles = 0
//        
//        for battle in battleTracker.tournament {
//            
//            if battle.winner != nil {
//                
//                finishedBattles += 1
//            }
//        }
//        
//        if finishedBattles > 0 {
//            let percent = (Double(finishedBattles) / Double(battleTracker.tournament.count) * 100)
//            string += "\(Int(percent))% complete"
//            
//        }
//        
//        
//        
//        outputLabel.text = string
//    }
//    
//    func outputBattles() {
//        
//        var string = String()
//        
//        for battle in battleTracker.battles {
//            
//            string += ("\(battle.objects[0].name) v \(battle.objects[1].name) = \(battle.winner.name)\n")
//        }
//        
//        battleTextView.text = string
//    }
//}



// http://stackoverflow.com/questions/24090698/swift-contains-extension-for-array

//extension Array {
//    func containsReference(obj: AnyObject) -> Bool {
//        for ownedItem in self {
//            if let ownedObject: AnyObject = ownedItem as? AnyObject {
//                if (ownedObject === obj) {
//                    return true
//                }
//            }
//        }
//        
//        return false
//    }
//}
