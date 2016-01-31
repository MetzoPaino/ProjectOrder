//
//  CollectionCreator.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation

func createDavidBowieCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "David Bowie Discography", description: "From Glam to Jazztronica, few have had so many hits in so many different genres. Take an out of this world trip from 1967 to 2016.", category: .music)

    let davidBowie1967 = ItemModel(string: "David Bowie (1967)")
    let davidBowie1969 = ItemModel(string: "David Bowie (1969)")
    let theManWhoSoldTheWorld = ItemModel(string: "The Man Who Sold The World")
    let hunkyDory = ItemModel(string: "Hunky Dory")
    let ziggyStardust = ItemModel(string: "The Rise and Fall of Ziggy Stardust and the Spiders from Mars")
    let aladdinSane = ItemModel(string: "Aladdin Sane")
    let pinUps = ItemModel(string: "Pin Ups")
    let diamondDogs = ItemModel(string: "Diamond Dogs")
    let youngAmericans = ItemModel(string: "Young Americans")
    let stationToStation = ItemModel(string: "Station to Station")
    let low = ItemModel(string: "Low")
    let heroes = ItemModel(string: "\"Heroes\"")
    let lodger = ItemModel(string: "Lodger")
    let scaryMonsters = ItemModel(string: "Scary Monsters (And Super Creeps)")
    let letsDance = ItemModel(string: "Let's Dance")
    let tonight = ItemModel(string: "Tonight")
    let neverLetMeDown = ItemModel(string: "Never Let Me Down")
    let blackTieWhiteNoise = ItemModel(string: "Black Tie White Noise")
    let outside = ItemModel(string: "Outside")
    let earthling = ItemModel(string: "Earthling")
    let hours = ItemModel(string: "'Hours...'")
    let heathen = ItemModel(string: "Heathen")
    let reality = ItemModel(string: "Reality")
    let theNextDay = ItemModel(string: "The Next Day")
    let blackstar = ItemModel(string: "Blackstar")
    
    collection.items = [davidBowie1967, davidBowie1969, theManWhoSoldTheWorld, hunkyDory, ziggyStardust, aladdinSane, pinUps, diamondDogs, youngAmericans, stationToStation, low, heroes, lodger, scaryMonsters, letsDance, tonight, neverLetMeDown, blackTieWhiteNoise, outside, earthling, hours, heathen, reality, theNextDay, blackstar]
    
    return collection
}

func createStarWarsCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Star Wars", description: "?", category: .films)
    
    let phantomMenace = ItemModel(string: "The Phantom Menace")
    let theCloneWars = ItemModel(string: "The Clone Wars")
    let revengeOfTheSith = ItemModel(string: "Revenge of the Sith")
    let aNewHope = ItemModel(string: "A New Hope")
    let theEmpireStrikesBack = ItemModel(string: "The Empire Strikes Back")
    let returnOfTheJedi = ItemModel(string: "Return of the Jedi")
    let theForceAwakens = ItemModel(string: "The Force Awakens")
    
    collection.items = [phantomMenace, theCloneWars, revengeOfTheSith, aNewHope, theEmpireStrikesBack, returnOfTheJedi, theForceAwakens]
    
    return collection
}

func createHarryPotterCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Harry Potter", description: "?", category: .books)
    
    let stone = ItemModel(string: "Philosopher's Stone")
    let chamber = ItemModel(string: "Chamber of Secrets")
    let prisoner = ItemModel(string: "Prisoner of Azkaban")
    let goblet = ItemModel(string: "Goblet of Fire")
    let phoenix = ItemModel(string: "Order of the Phoenix")
    let prince = ItemModel(string: "Half-Blood Prince")
    let hallows = ItemModel(string: "Deathly Hallows")
    
    collection.items = [stone, chamber, prisoner, goblet, phoenix, prince, hallows]
    
    return collection
}

func createFinalFantasyCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Final Fantasy", description: "?", category: .games)
    
    let I = ItemModel(string: "Final Fantasy I")
    let II = ItemModel(string: "Final Fantasy II")
    let III = ItemModel(string: "Final Fantasy III")
    let IV = ItemModel(string: "Final Fantasy IV")
    let V = ItemModel(string: "Final Fantasy V")
    let VI = ItemModel(string: "Final Fantasy VI")
    let VII = ItemModel(string: "Final Fantasy VII")
    let VIII = ItemModel(string: "Final Fantasy VIII")
    let IX = ItemModel(string: "Final Fantasy IX")
    let X = ItemModel(string: "Final Fantasy X")
    let XI = ItemModel(string: "Final Fantasy XI")
    let XII = ItemModel(string: "Final Fantasy XII")
    let XIII = ItemModel(string: "Final Fantasy XIII")
    let XIV = ItemModel(string: "Final Fantasy XIV")
    let XV = ItemModel(string: "Final Fantasy XV")
    
    collection.items = [I, II, III, IV, V, VI, VII, VIII, IX, X, XI, XII, XIII, XIV, XV]
    
    return collection
}