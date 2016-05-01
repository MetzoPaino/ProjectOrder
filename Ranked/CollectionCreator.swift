//
//  CollectionCreator.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation
import CloudKit

let preMadeCollectionsArray = [createDavidBowieCollection(), createStarWarsCollection(), createHarryPotterCollection(),createInternetBrowserCollection(), createDesktopOSCollection(), createMobileOSCollection(), createMarioCharactersCollection(), createHottestHobbitsCollection()]

//createFinalFantasyCollection()
//createDoctorWhoCollection()

private let itemRecordType = "Item"

func createDavidBowieCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "David Bowie Discography", description: "From Glam to Jazztronica, few have had so many hits in so many different genres. Take an out of this world trip from 1967 to 2016.", dateCreated: NSDate())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: "DavidBowie-Collection"))
    collection.premade = true

    let davidBowie1967 = ItemModel(string: "David Bowie (1967)")
    davidBowie1967.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "DavidBowie1967-Item"))
    
    let davidBowie1969 = ItemModel(string: "David Bowie (1969)")
    davidBowie1969.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "DavidBowie1969-Item"))

    let theManWhoSoldTheWorld = ItemModel(string: "The Man Who Sold The World")
    theManWhoSoldTheWorld.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "TheManWhoSoldTheWorld-Item"))

    let hunkyDory = ItemModel(string: "Hunky Dory")
    hunkyDory.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "HunkyDory-Item"))

    let ziggyStardust = ItemModel(string: "The Rise and Fall of Ziggy Stardust and the Spiders from Mars")
    ziggyStardust.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "ZiggyStardust-Item"))

    let aladdinSane = ItemModel(string: "Aladdin Sane")
    aladdinSane.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "AladdinSane-Item"))

    let pinUps = ItemModel(string: "Pin Ups")
    pinUps.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "PinUps-Item"))

    let diamondDogs = ItemModel(string: "Diamond Dogs")
    diamondDogs.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "DiamondDogs-Item"))

    let youngAmericans = ItemModel(string: "Young Americans")
    youngAmericans.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "YoungAmericans-Item"))

    let stationToStation = ItemModel(string: "Station to Station")
    stationToStation.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "StationToStation-Item"))

    let low = ItemModel(string: "Low")
    low.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "Low-Item"))

    let heroes = ItemModel(string: "\"Heroes\"")
    heroes.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "Heroes-Item"))

    let lodger = ItemModel(string: "Lodger")
    lodger.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "Lodger-Item"))

    let scaryMonsters = ItemModel(string: "Scary Monsters (And Super Creeps)")
    scaryMonsters.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "ScaryMonsters-Item"))

    let letsDance = ItemModel(string: "Let's Dance")
    letsDance.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "LetsDance-Item"))

    let tonight = ItemModel(string: "Tonight")
    tonight.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "Tonight-Item"))

    let neverLetMeDown = ItemModel(string: "Never Let Me Down")
    neverLetMeDown.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "NeverLetMeDown-Item"))

    let blackTieWhiteNoise = ItemModel(string: "Black Tie White Noise")
    blackTieWhiteNoise.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "BlackTieWhiteNoise-Item"))

    let outside = ItemModel(string: "1. Outside")
    outside.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "Outside-Item"))

    let earthling = ItemModel(string: "Earthling")
    earthling.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "Earthling-Item"))

    let hours = ItemModel(string: "'Hours...'")
    hours.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "Hours-Item"))

    let heathen = ItemModel(string: "Heathen")
    heathen.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "Heathen-Item"))

    let reality = ItemModel(string: "Reality")
    reality.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "Reality-Item"))

    let theNextDay = ItemModel(string: "The Next Day")
    theNextDay.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "TheNextDay-Item"))

    let blackstar = ItemModel(string: "Blackstar")
    blackstar.record = CKRecord(recordType: "Item", recordID: CKRecordID(recordName: "Blackstar-Item"))

    collection.items = [davidBowie1967, davidBowie1969, theManWhoSoldTheWorld, hunkyDory, ziggyStardust, aladdinSane, pinUps, diamondDogs, youngAmericans, stationToStation, low, heroes, lodger, scaryMonsters, letsDance, tonight, neverLetMeDown, blackTieWhiteNoise, outside, earthling, hours, heathen, reality, theNextDay, blackstar]
    
    return collection
}

func createStarWarsCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Star Wars", description: "Star Wars is an American epic space opera franchise, centered on a film series created by George Lucas. It depicts the adventures of various characters \"a long time ago in a galaxy far, far away\"", dateCreated: NSDate())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: "StarWars-Collection"))
    collection.premade = true
    
    let phantomMenace = ItemModel(string: "The Phantom Menace")
    phantomMenace.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "PhantomMenace-Item"))

    let theCloneWars = ItemModel(string: "The Clone Wars")
    theCloneWars.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "TheCloneWars-Item"))

    let revengeOfTheSith = ItemModel(string: "Revenge of the Sith")
    revengeOfTheSith.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "RevengeOfTheSith-Item"))

    let aNewHope = ItemModel(string: "A New Hope")
    aNewHope.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "ANewHope-Item"))

    let theEmpireStrikesBack = ItemModel(string: "The Empire Strikes Back")
    theEmpireStrikesBack.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "TheEmpireStrikesBack-Item"))

    let returnOfTheJedi = ItemModel(string: "Return of the Jedi")
    returnOfTheJedi.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "ReturnOfTheJedi-Item"))

    let theForceAwakens = ItemModel(string: "The Force Awakens")
    theForceAwakens.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "TheForceAwakens-Item"))
    
    collection.items = [phantomMenace, theCloneWars, revengeOfTheSith, aNewHope, theEmpireStrikesBack, returnOfTheJedi, theForceAwakens]
    
    return collection
}

func createHarryPotterCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Harry Potter", description: "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. The series chronicles the life of a young wizard, Harry Potter, and his friends Hermione Granger and Ron Weasley, all of whom are students at Hogwarts School of Witchcraft and Wizardry.", dateCreated: NSDate())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: "HarryPotter-Collection"))
    collection.premade = true
    
    let stone = ItemModel(string: "Philosopher's Stone")
    stone.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "ThePhilosophersStone-Item"))

    let chamber = ItemModel(string: "Chamber of Secrets")
    chamber.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "ChamberOfSecrets-Item"))

    let prisoner = ItemModel(string: "Prisoner of Azkaban")
    prisoner.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "PrisonerOfAzkaban-Item"))

    let goblet = ItemModel(string: "Goblet of Fire")
    goblet.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "GobletOfFire-Item"))

    let phoenix = ItemModel(string: "Order of the Phoenix")
    phoenix.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "OrderOfThePhoenix-Item"))

    let prince = ItemModel(string: "Half-Blood Prince")
    prince.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "HalfBloodPrince-Item"))

    let hallows = ItemModel(string: "Deathly Hallows")
    hallows.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "DeathlyHallows-Item"))
    
    collection.items = [stone, chamber, prisoner, goblet, phoenix, prince, hallows]
    
    return collection
}

func createFinalFantasyCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Final Fantasy", description: "Final Fantasy (ファイナルファンタジー Fainaru Fantajī?) is a science fiction and fantasy media franchise created by Hironobu Sakaguchi, and developed and owned by Square Enix (formerly Square). The franchise centers on a series of fantasy and science fantasy role-playing video games (RPGs). The eponymous first game in the series, published in 1987, was conceived by Sakaguchi as his last-ditch effort in the game industry; the title was a success and spawned sequels.", dateCreated: NSDate())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: "FinalFantasy-Collection"))
    collection.premade = true
    
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
    
    let collection = CollectionModel(name: "Browsers", description: "A web browser (commonly referred to as a browser) is a software application for retrieving, presenting, and traversing information resources on the World Wide Web.", dateCreated: NSDate())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: "Browsers-Collection"))
    collection.premade = true
    
    let internetExplorer = ItemModel(string: "Internet Explorer")
    internetExplorer.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "InternetExplorer-Item"))

    let chrome = ItemModel(string: "Chrome")
    chrome.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Chrome-Item"))

    let safari = ItemModel(string: "Safari")
    safari.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Safari-Item"))

    let firefox = ItemModel(string: "Firefox")
    firefox.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Firefox-Item"))

    let opera = ItemModel(string: "Opera")
    opera.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Opera-Item"))

    let edge = ItemModel(string: "Edge")
    edge.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Edge-Item"))

    collection.items = [internetExplorer, chrome, safari, firefox, opera, edge]
    
    return collection
}

func createDesktopOSCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Desktop OS", description: "An operating system (OS) is system software that manages computer hardware and software resources and provides common services for computer programs. The operating system is a component of the system software in a computer system. Application programs usually require an operating system to function.", dateCreated: NSDate())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: "DesktopOS-Collection"))
    collection.premade = true
    
    let mac = ItemModel(string: "Mac")
    mac.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Mac-Item"))

    let windows = ItemModel(string: "Windows")
    windows.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Windows-Item"))

    let linux = ItemModel(string: "Linux")
    linux.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Linux-Item"))
    
    collection.items = [mac, windows, linux]
    
    return collection
}

func createMobileOSCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Mobile OS", description: "A mobile operating system (or mobile OS) is an operating system for smartphones, tablets, PDAs, or other mobile devices. While computers such as the typical laptop are mobile, the operating systems usually used on them are not considered mobile ones as they were originally designed for bigger stationary desktop computers that historically did not have or need specific \"mobile\" features. This distinction is getting blurred in some newer operating systems that are hybrids made for both uses.", dateCreated: NSDate())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: "MobileOS-Collection"))
    collection.premade = true
    
    let ios = ItemModel(string: "iOS")
    ios.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "IOS-Item"))

    let android = ItemModel(string: "Android")
    android.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Android-Item"))

    let blackberry = ItemModel(string: "Blackberry")
    blackberry.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Blackberry-Item"))

    let windows = ItemModel(string: "Windows Mobile")
    windows.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Windows Mobile-Item"))

    collection.items = [ios, android, blackberry, windows]
    
    return collection
}

func createDoctorWhoCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Doctor Who", description: "Doctor Who is a British science-fiction television programme produced by the BBC from 1963 to the present day. The programme depicts the adventures of the Doctor, a Time Lord—a space and time-travelling humanoid alien. He explores the universe in his TARDIS, a sentient time-travelling space ship. Its exterior appears as a blue British police box, which was a common sight in Britain in 1963 when the series first aired. Accompanied by companions, the Doctor combats a variety of foes, while working to save civilisations and help people in need.", dateCreated: NSDate())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: "DoctorWho-Collection"))
    collection.premade = true
    
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
    
    let collection = CollectionModel(name: "Mario Characters", description: "The Mario series has an extensive cast of recurring characters. Among the most frequently recurring and significant ones are protagonist Mario, his antagonist Bowser, his brother Luigi, the Princess of the Mushroom Kingdom Peach, his sidekick and mount Yoshi, and his antihero doppelganger Wario.", dateCreated: NSDate())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: "MarioCharacters-Collection"))
    collection.premade = true
    
    let mario = ItemModel(string: "Mario")
    mario.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Mario-Item"))

    let luigi = ItemModel(string: "Luigi")
    luigi.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Luigi-Item"))

    let peach = ItemModel(string: "Peach")
    peach.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Peach-Item"))

    let bowser = ItemModel(string: "Bowser")
    bowser.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Bowser-Item"))

    let toad = ItemModel(string: "Toad")
    toad.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Toad-Item"))

    collection.items = [mario, luigi, peach, bowser, toad]
    
    return collection
}

func createHottestHobbitsCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Hottest Hobbits", description: "Get down with The Shire", dateCreated: NSDate())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: "HottestHobbits-Collection"))
    collection.premade = true
    
    let frodo = ItemModel(string: "Frodo")
    frodo.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Frodo-Item"))

    let sam = ItemModel(string: "Sam")
    sam.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Sam-Item"))

    let merry = ItemModel(string: "Merry")
    merry.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Merry-Item"))

    let pippin = ItemModel(string: "Pippin")
    pippin.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "Pippin-Item"))

    let bilboYoung = ItemModel(string: "Bilbo (Young)")
    bilboYoung.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "BilboYoung-Item"))

    let bilboOld = ItemModel(string: "Bilbo (Old)")
    bilboOld.record = CKRecord(recordType: itemRecordType, recordID: CKRecordID(recordName: "BilboOld-Item"))
    
    collection.items = [frodo, sam, merry, pippin, bilboYoung, bilboOld]
    
    return collection
}

          