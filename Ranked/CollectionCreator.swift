//
//  CollectionCreator.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation

func createDavidBowieCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "David Bowie Discography", description: "From Glam to Jazztronica, few have had so many hits in so many different genres. Take an out of this world trip from 1967 to 2016.", category: .music, dateCreated: NSDate())

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
    
    let collection = CollectionModel(name: "Star Wars", description: "Star Wars is an American epic space opera franchise, centered on a film series created by George Lucas. It depicts the adventures of various characters \"a long time ago in a galaxy far, far away\"", category: .films, dateCreated: NSDate())
    
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
    
    let collection = CollectionModel(name: "Harry Potter", description: "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. The series chronicles the life of a young wizard, Harry Potter, and his friends Hermione Granger and Ron Weasley, all of whom are students at Hogwarts School of Witchcraft and Wizardry.", category: .books, dateCreated: NSDate())
    
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
    
    let collection = CollectionModel(name: "Final Fantasy", description: "Final Fantasy (ファイナルファンタジー Fainaru Fantajī?) is a science fiction and fantasy media franchise created by Hironobu Sakaguchi, and developed and owned by Square Enix (formerly Square). The franchise centers on a series of fantasy and science fantasy role-playing video games (RPGs). The eponymous first game in the series, published in 1987, was conceived by Sakaguchi as his last-ditch effort in the game industry; the title was a success and spawned sequels.", category: .games, dateCreated: NSDate())
    
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

func createInternetBrowserCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Browsers", description: "A web browser (commonly referred to as a browser) is a software application for retrieving, presenting, and traversing information resources on the World Wide Web.", category: .computers, dateCreated: NSDate())
    
    let internetExplorer = ItemModel(string: "Internet Explorer")
    let chrome = ItemModel(string: "Chrome")
    let safari = ItemModel(string: "Safari")
    let firefox = ItemModel(string: "Firefox")
    let opera = ItemModel(string: "Opera")
    let edge = ItemModel(string: "Edge")
    
    collection.items = [internetExplorer, chrome, safari, firefox, opera, edge]
    
    return collection
}

func createDesktopOSCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Desktop OS", description: "An operating system (OS) is system software that manages computer hardware and software resources and provides common services for computer programs. The operating system is a component of the system software in a computer system. Application programs usually require an operating system to function.", category: .computers, dateCreated: NSDate())
    
    let mac = ItemModel(string: "Mac")
    let windows = ItemModel(string: "Windows")
    let linux = ItemModel(string: "Linux")
    
    collection.items = [mac, windows, linux]
    
    return collection
}

func createMobileOSCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Mobile OS", description: "A mobile operating system (or mobile OS) is an operating system for smartphones, tablets, PDAs, or other mobile devices. While computers such as the typical laptop are mobile, the operating systems usually used on them are not considered mobile ones as they were originally designed for bigger stationary desktop computers that historically did not have or need specific \"mobile\" features. This distinction is getting blurred in some newer operating systems that are hybrids made for both uses.", category: .computers, dateCreated: NSDate())
    
    let ios = ItemModel(string: "iOS")
    let android = ItemModel(string: "Android")
    let blackberry = ItemModel(string: "Blackberry")
    let windows = ItemModel(string: "Windows Mobile")

    collection.items = [ios, android, blackberry, windows]
    
    return collection
}

func createDoctorWhoCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Doctor Who", description: "Doctor Who is a British science-fiction television programme produced by the BBC from 1963 to the present day. The programme depicts the adventures of the Doctor, a Time Lord—a space and time-travelling humanoid alien. He explores the universe in his TARDIS, a sentient time-travelling space ship. Its exterior appears as a blue British police box, which was a common sight in Britain in 1963 when the series first aired. Accompanied by companions, the Doctor combats a variety of foes, while working to save civilisations and help people in need.", category: .films, dateCreated: NSDate())
    
    let hartnell = ItemModel(string: "First William Hartnell")
    let troughton = ItemModel(string: "Second Patrick Troughton")
    let pertwee = ItemModel(string: "Third Jon Pertwee")
    let tomBaker = ItemModel(string: "Fourth Tom Baker")
    let davison = ItemModel(string: "Fifth Peter Davison")
    let colinBaker = ItemModel(string: "Sixth Colin Baker")
    let mcCoy = ItemModel(string: "Seventh Sylvester McCoy")
    let mcGann = ItemModel(string: "Eighth Paul McGann")
    let eccleston = ItemModel(string: "Ninth Christopher Eccleston")
    let tennant = ItemModel(string: "Tenth David Tennant")
    let smith = ItemModel(string: "Eleventh Matt Smith")
    let capaldi = ItemModel(string: "Twelfth Peter Capaldi")

    collection.items = [hartnell, troughton, pertwee, tomBaker, davison, colinBaker, mcCoy, mcGann, eccleston, tennant, smith, capaldi]
    
    return collection
}

func createMarioCharactersCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Mario Characters", description: "The Mario series has an extensive cast of recurring characters. Among the most frequently recurring and significant ones are protagonist Mario, his antagonist Bowser, his brother Luigi, the Princess of the Mushroom Kingdom Peach, his sidekick and mount Yoshi, and his antihero doppelganger Wario.", category: .games, dateCreated: NSDate())
    
    let mario = ItemModel(string: "Mario")
    let luigi = ItemModel(string: "Lugi")
    let peach = ItemModel(string: "Peach")
    let bowser = ItemModel(string: "Bowser")
    let toad = ItemModel(string: "Toad")
    
    collection.items = [mario, luigi, peach, bowser, toad]
    
    return collection
}


          