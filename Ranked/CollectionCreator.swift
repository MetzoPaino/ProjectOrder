//
//  CollectionCreator.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation
import CloudKit

//let preMadeCollectionsArray = [createDavidBowieCollection(), createStarWarsCollection(), createHarryPotterCollection(),createInternetBrowserCollection(), createDesktopOSCollection(), createMobileOSCollection(), createMarioCharactersCollection(), createHottestHobbitsCollection()]

func createPreMadeCollectionsArray() -> [CollectionModel] {
    
    return [createDavidBowieCollection(), createStarWarsCollection(), createHarryPotterCollection(),createInternetBrowserCollection(), createDesktopOSCollection(), createMobileOSCollection(), createMarioCharactersCollection(), createHottestHobbitsCollection()]
}

//createFinalFantasyCollection()
//createDoctorWhoCollection()

private let collectionRecordType = "Collection"
private let itemRecordType = "Item"

func createRecordOfTypeWithUniqueIdentifier(type:String, uniqueIdentifier: String) -> CKRecord {
    
    return CKRecord(recordType: type, recordID: CKRecordID(recordName: uniqueIdentifier + "-" + type + "-" + NSUUID().UUIDString))
}

func createDavidBowieCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "David Bowie Discography", description: "From Glam to Jazztronica, few have had so many hits in so many different genres. Take an out of this world trip from 1967 to 2016.", dateCreated: NSDate())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: "DavidBowieDiscography")
    collection.premade = true

    let davidBowie1967 = ItemModel(string: "David Bowie (1967)")
    davidBowie1967.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "DavidBowie(1967)")
    
    let davidBowie1969 = ItemModel(string: "David Bowie (1969)")
    davidBowie1969.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "DavidBowie(1969)")

    let theManWhoSoldTheWorld = ItemModel(string: "The Man Who Sold The World")
    theManWhoSoldTheWorld.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "TheManWhoSoldTheWorld")

    let hunkyDory = ItemModel(string: "Hunky Dory")
    hunkyDory.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "HunkyDory")

    let ziggyStardust = ItemModel(string: "The Rise and Fall of Ziggy Stardust and the Spiders from Mars")
    ziggyStardust.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "ZiggyStardust")

    let aladdinSane = ItemModel(string: "Aladdin Sane")
    aladdinSane.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "AladdinSane")

    let pinUps = ItemModel(string: "Pin Ups")
    pinUps.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "PinUps")

    let diamondDogs = ItemModel(string: "Diamond Dogs")
    diamondDogs.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "DiamondDogs")

    let youngAmericans = ItemModel(string: "Young Americans")
    youngAmericans.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "YoungAmericans")

    let stationToStation = ItemModel(string: "Station to Station")
    stationToStation.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "StationToStation")

    let low = ItemModel(string: "Low")
    low.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Low")

    let heroes = ItemModel(string: "\"Heroes\"")
    heroes.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Heroes")

    let lodger = ItemModel(string: "Lodger")
    lodger.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Lodger")

    let scaryMonsters = ItemModel(string: "Scary Monsters (And Super Creeps)")
    scaryMonsters.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "ScaryMonsters")

    let letsDance = ItemModel(string: "Let's Dance")
    letsDance.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "LetsDance")

    let tonight = ItemModel(string: "Tonight")
    tonight.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Tonight")

    let neverLetMeDown = ItemModel(string: "Never Let Me Down")
    neverLetMeDown.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "NeverLetMeDown")

    let blackTieWhiteNoise = ItemModel(string: "Black Tie White Noise")
    blackTieWhiteNoise.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "BlackTieWhiteNoise")

    let outside = ItemModel(string: "1. Outside")
    outside.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Outside")

    let earthling = ItemModel(string: "Earthling")
    earthling.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Earthling")

    let hours = ItemModel(string: "'Hours...'")
    hours.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Hours")

    let heathen = ItemModel(string: "Heathen")
    heathen.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Heathen")

    let reality = ItemModel(string: "Reality")
    reality.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Reality")

    let theNextDay = ItemModel(string: "The Next Day")
    theNextDay.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "TheNextDay")

    let blackstar = ItemModel(string: "Blackstar")
    blackstar.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Blackstar")

    collection.items = [davidBowie1967, davidBowie1969, theManWhoSoldTheWorld, hunkyDory, ziggyStardust, aladdinSane, pinUps, diamondDogs, youngAmericans, stationToStation, low, heroes, lodger, scaryMonsters, letsDance, tonight, neverLetMeDown, blackTieWhiteNoise, outside, earthling, hours, heathen, reality, theNextDay, blackstar]
    
    return collection
}

func createStarWarsCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Star Wars", description: "Star Wars is an American epic space opera franchise, centered on a film series created by George Lucas. It depicts the adventures of various characters \"a long time ago in a galaxy far, far away\"", dateCreated: NSDate())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: "StarWars")
    collection.premade = true
    
    let phantomMenace = ItemModel(string: "The Phantom Menace")
    phantomMenace.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "PhantomMenace")

    let theCloneWars = ItemModel(string: "The Clone Wars")
    theCloneWars.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "CloneWars")

    let revengeOfTheSith = ItemModel(string: "Revenge of the Sith")
    revengeOfTheSith.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "RevengeOfTheSith")

    let aNewHope = ItemModel(string: "A New Hope")
    aNewHope.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "ANewHope")

    let theEmpireStrikesBack = ItemModel(string: "The Empire Strikes Back")
    theEmpireStrikesBack.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "EmpireStrikesBack")

    let returnOfTheJedi = ItemModel(string: "Return of the Jedi")
    returnOfTheJedi.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "ReturnOfTheJedi")

    let theForceAwakens = ItemModel(string: "The Force Awakens")
    theForceAwakens.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "ForceAwakens")
    
    collection.items = [phantomMenace, theCloneWars, revengeOfTheSith, aNewHope, theEmpireStrikesBack, returnOfTheJedi, theForceAwakens]
    
    return collection
}

func createHarryPotterCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Harry Potter", description: "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. The series chronicles the life of a young wizard, Harry Potter, and his friends Hermione Granger and Ron Weasley, all of whom are students at Hogwarts School of Witchcraft and Wizardry.", dateCreated: NSDate())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: "HarryPotter")
    collection.premade = true
    
    let stone = ItemModel(string: "Philosopher's Stone")
    stone.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "PhilosophersStone")

    let chamber = ItemModel(string: "Chamber of Secrets")
    chamber.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "ChamberOfSecrets")

    let prisoner = ItemModel(string: "Prisoner of Azkaban")
    prisoner.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "PrisonerOfAzkaban")

    let goblet = ItemModel(string: "Goblet of Fire")
    goblet.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "GobletOfFire")

    let phoenix = ItemModel(string: "Order of the Phoenix")
    phoenix.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "OrderOfThePhoenix")

    let prince = ItemModel(string: "Half-Blood Prince")
    prince.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "HalfBloodPrince")

    let hallows = ItemModel(string: "Deathly Hallows")
    hallows.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "DeathlyHallows")
    
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
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: "Browser")
    collection.premade = true
    
    let internetExplorer = ItemModel(string: "Internet Explorer")
    internetExplorer.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "InternetExplorer")

    let chrome = ItemModel(string: "Chrome")
    chrome.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Chrome")

    let safari = ItemModel(string: "Safari")
    safari.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Safari")

    let firefox = ItemModel(string: "Firefox")
    firefox.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Firefox")

    let opera = ItemModel(string: "Opera")
    opera.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Opera")

    let edge = ItemModel(string: "Edge")
    edge.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Edge")

    collection.items = [internetExplorer, chrome, safari, firefox, opera, edge]
    
    return collection
}

func createDesktopOSCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Desktop OS", description: "An operating system (OS) is system software that manages computer hardware and software resources and provides common services for computer programs. The operating system is a component of the system software in a computer system. Application programs usually require an operating system to function.", dateCreated: NSDate())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: "DesktopOS")
    collection.premade = true
    
    let mac = ItemModel(string: "Mac")
    mac.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Mac")

    let windows = ItemModel(string: "Windows")
    windows.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Windows")

    let linux = ItemModel(string: "Linux")
    linux.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Linux")
    
    collection.items = [mac, windows, linux]
    
    return collection
}

func createMobileOSCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Mobile OS", description: "A mobile operating system (or mobile OS) is an operating system for smartphones, tablets, PDAs, or other mobile devices. While computers such as the typical laptop are mobile, the operating systems usually used on them are not considered mobile ones as they were originally designed for bigger stationary desktop computers that historically did not have or need specific \"mobile\" features. This distinction is getting blurred in some newer operating systems that are hybrids made for both uses.", dateCreated: NSDate())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: "MobileOS")
    collection.premade = true
    
    let ios = ItemModel(string: "iOS")
    ios.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "IOS")

    let android = ItemModel(string: "Android")
    android.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Android")

    let blackberry = ItemModel(string: "Blackberry")
    blackberry.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Blackberry")

    let windows = ItemModel(string: "Windows Mobile")
    windows.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "WindowsMobile")

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
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: "MarioCharacters")
    collection.premade = true
    
    let mario = ItemModel(string: "Mario")
    mario.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Mario")

    let luigi = ItemModel(string: "Luigi")
    luigi.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Luigi")

    let peach = ItemModel(string: "Peach")
    peach.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Peach")

    let bowser = ItemModel(string: "Bowser")
    bowser.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Bowser")

    let toad = ItemModel(string: "Toad")
    toad.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Toad")

    collection.items = [mario, luigi, peach, bowser, toad]
    
    return collection
}

func createHottestHobbitsCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Hottest Hobbits", description: "Get down with The Shire", dateCreated: NSDate())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: "HottestHobbits")
    collection.premade = true
    
    let frodo = ItemModel(string: "Frodo")
    frodo.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Frodo")

    let sam = ItemModel(string: "Sam")
    sam.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Sam")

    let merry = ItemModel(string: "Merry")
    merry.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Merry")

    let pippin = ItemModel(string: "Pippin")
    pippin.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Pippin")

    let bilboYoung = ItemModel(string: "Bilbo (Young)")
    bilboYoung.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "BilboYoung")

    let bilboOld = ItemModel(string: "Bilbo (Old)")
    bilboOld.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "BilboOld")
    
    collection.items = [frodo, sam, merry, pippin, bilboYoung, bilboOld]
    
    return collection
}

          