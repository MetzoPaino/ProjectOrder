//
//  TournamentMaker.swift
//  Ranked
//
//  Created by William Robinson on 30/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation

protocol TournamentManagerDelegate: class {
    func percentageCompleteValueChanged(percentage: Double)
}

class Battle {
    
    var playerOne: ItemModel
    var playerTwo: ItemModel
    var winner: ItemModel?
    var loser: ItemModel?

    init(playerOne: ItemModel, playerTwo: ItemModel) {
        self.playerOne = playerOne
        self.playerTwo = playerTwo
    }
}

enum PickBattleError: ErrorType {
    
    case AlreadyTakenPlace
}

class TournamentManager {
    
    var tournament = [Battle]()
    var participants = [ItemModel]()
    var printDetails = false
    var currentBattleIndex = 0
    
    weak var delegate: TournamentManagerDelegate?
    
    func createTournament(items:[ItemModel]) {
        
        participants = items
        
        for (index, participant) in participants.enumerate() {
            
            participant.tag = index
        }
        
        var itterator = 0
        
        while itterator < participants.count {
            
            for participant in participants {
                
                let firstObject = participants[itterator]
                
                if participant.tag > itterator {
                    
                    printString("\(firstObject.text) v \(participant.text)")
                    
                    //tournament.append((playerOne: firstObject, playerTwo: sortingObject, winner: nil, loser: nil))
                    tournament.append(Battle(playerOne: firstObject, playerTwo: participant))
                }
            }
            itterator++
        }
        
        printString(" ")
    }
    
    func isTournamentResolved() -> Bool {
        
        var finishedMatches = 0
        
        for battle in tournament {
            
            if let _ = battle.winner {
                
                finishedMatches += 1
            }
        }
        
        if finishedMatches == tournament.count {
            
            print("All matches decided")
            return true
        }
        return false
    }
    
    func pickBattle() throws -> (playerOne: ItemModel, playerTwo: ItemModel) {
        
        currentBattleIndex = randomNumberInRange(tournament.count)
        
        let battle = tournament[currentBattleIndex]
        
        if battle.winner != nil {
            
            throw PickBattleError.AlreadyTakenPlace
            
        } else {
            
            // NEED TO RANDOMISE LEFT RIGHT ORDER
            
            let order = randomNumberInRange(2)
            
            if order == 0 {
               
                return (battle.playerOne, battle.playerTwo)

            } else {
                
                return (battle.playerTwo, battle.playerOne)
            }
        }
    }
    
    func assignPointsForCompletedBattle(winner:ItemModel, loser:ItemModel) {
        
        tournament[currentBattleIndex].winner = participants[winner.tag]
        tournament[currentBattleIndex].loser = participants[loser.tag]
        participants[winner.tag].points += 1
        
        autoResolveBattlesFromWinnerAndLoserInTournament(winner, loser: loser)

        calculatePercentageComplete()
    }
    
    func calculatePercentageComplete() {
        
        var finishedBattles = 0
        
        for battle in tournament {
            
            if battle.winner != nil {
                
                finishedBattles += 1
            }
        }
        
        if finishedBattles > 0 {
            self.delegate?.percentageCompleteValueChanged((Double(finishedBattles) / Double(tournament.count) * 100))
        }
        
    }
    
    func randomNumberInRange(range: Int) -> Int {
        
        return Int(arc4random_uniform(UInt32(range)))
    }
    
    func autoResolveBattlesFromWinnerAndLoserInTournament(winner: ItemModel, loser: ItemModel) {
        
        // A superLoser has lost to the Loser
        var superLoser: ItemModel
        
        for loserBattle in tournament {
            
            if loser.tag == loserBattle.winner?.tag {
                
               // Loser of recent battle has been a winner elsewhere
                
                superLoser = loserBattle.loser!
                
                for (index, unresolvedBattle) in tournament.enumerate() {
                    
                    if unresolvedBattle.winner == nil {
                        
                        let comparisonArray = [unresolvedBattle.playerOne, unresolvedBattle.playerTwo]
                        
                        if comparisonArray.containsReference(winner) && comparisonArray.containsReference(superLoser) {
                            
                            printString("Because \(winner.text) defeated \(loser.text), but \(loser.text) defeated \(superLoser.text) & \(winner.text) hasn't fought \(superLoser.text) we can safely say \(winner.text) would defeat \(superLoser.text)")
                            printString("We can auto resolve!")
                            
                            tournament[index].winner = winner
                            tournament[index].loser = superLoser
                            participants[winner.tag].points += 1
                            
                            outputState()
                            printTournamentOverview()
                        }
                    }
                }
            }
        }
    }

}

extension TournamentManager {
    
    func printTournamentOverview() {
        
        var string = String()
        
        for battle in tournament {
            
            if let winnerString = battle.winner?.text {
                
                string += "\(battle.playerOne.text) v \(battle.playerTwo.text) = \(winnerString)\n"
            } else {
                string += "\(battle.playerOne.text) v \(battle.playerTwo.text)\n"
            }
        }
        printString(" ")
        printString("Tournament Overview")
        printString(string)
        printString(" ")
    }
    
    func outputState() {
        
        var string = String()
        
        for participant in participants {
            
            string += ("\(participant.text) = \(participant.text)\n")
        }
        
        var finishedBattles = 0
        
        for battle in tournament {
            
            if battle.winner != nil {
                
                finishedBattles += 1
            }
        }
        
        if finishedBattles > 0 {
            let percent = (Double(finishedBattles) / Double(tournament.count) * 100)
            string += "\(Int(percent))% complete"
        }
        
        printString(" ")
        printString("Tournament Results")
        printString(string)
        printString(" ")
    }
    
    func printString(string: String) {
        
        if printDetails {
            
            print(string)
        }
    }
}

extension Array {
    func containsReference(obj: AnyObject) -> Bool {
        for ownedItem in self {
            if let ownedObject: AnyObject = ownedItem as? AnyObject {
                if (ownedObject === obj) {
                    return true
                }
            }
        }
        
        return false
    }
}