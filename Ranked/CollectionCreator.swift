//
//  CollectionCreator.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import CloudKit

//let preMadeCollectionsArray = [createDavidBowieCollection(), createStarWarsCollection(), createHarryPotterCollection(),createInternetBrowserCollection(), createDesktopOSCollection(), createMobileOSCollection(), createMarioCharactersCollection(), createHottestHobbitsCollection()]

func createPreMadeCollectionsArray() -> [CollectionModel] {
    
    return [createDavidBowieCollection(), createStarWarsCollection(), createHarryPotterCollection(), createMarioCharactersCollection(), createHottestHobbitsCollection(), createTarantinoCollection(), createFlagsCollection(), createSeasonsCollection(), createPokémonCollection(), createGhibliCollection(), createSinglesCollection()]
}

//createFinalFantasyCollection()
//createDoctorWhoCollection()

private let collectionRecordType = "Collection"
private let itemRecordType = "Item"

func createRecordOfTypeWithUniqueIdentifier(_ type:String, uniqueIdentifier: String) -> CKRecord {
    
    return CKRecord(recordType: type, recordID: CKRecordID(recordName: uniqueIdentifier + "-" + type + "-" + UUID().uuidString))
}

func createDavidBowieCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "David Bowie Albums", description: "From Glam to Jazztronica, few have had so many hits in so many different genres. Take an out of this world trip from 1967 to 2016.", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.premade = true
    //collection.image = UIImage(named: "DavidBowie")

    let davidBowie1967 = ItemModel(string: "David Bowie (1967)", dateCreated: Date())
    davidBowie1967.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "DavidBowie(1967)")
    
    let davidBowie1969 = ItemModel(string: "David Bowie (1969)", dateCreated: Date())
    davidBowie1969.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "DavidBowie(1969)")

    let theManWhoSoldTheWorld = ItemModel(string: "The Man Who Sold The World", dateCreated: Date())
    theManWhoSoldTheWorld.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "TheManWhoSoldTheWorld")

    let hunkyDory = ItemModel(string: "Hunky Dory", dateCreated: Date())
    hunkyDory.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "HunkyDory")

    let ziggyStardust = ItemModel(string: "The Rise and Fall of Ziggy Stardust and the Spiders from Mars", dateCreated: Date())
    ziggyStardust.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "ZiggyStardust")

    let aladdinSane = ItemModel(string: "Aladdin Sane", dateCreated: Date())
    aladdinSane.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "AladdinSane")

    let pinUps = ItemModel(string: "Pin Ups", dateCreated: Date())
    pinUps.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "PinUps")

    let diamondDogs = ItemModel(string: "Diamond Dogs", dateCreated: Date())
    diamondDogs.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "DiamondDogs")

    let youngAmericans = ItemModel(string: "Young Americans", dateCreated: Date())
    youngAmericans.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "YoungAmericans")

    let stationToStation = ItemModel(string: "Station to Station", dateCreated: Date())
    stationToStation.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "StationToStation")

    let low = ItemModel(string: "Low", dateCreated: Date())
    low.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Low")

    let heroes = ItemModel(string: "\"Heroes\"", dateCreated: Date())
    heroes.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Heroes")

    let lodger = ItemModel(string: "Lodger", dateCreated: Date())
    lodger.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Lodger")

    let scaryMonsters = ItemModel(string: "Scary Monsters (And Super Creeps)", dateCreated: Date())
    scaryMonsters.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "ScaryMonsters")

    let letsDance = ItemModel(string: "Let's Dance", dateCreated: Date())
    letsDance.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "LetsDance")

    let tonight = ItemModel(string: "Tonight", dateCreated: Date())
    tonight.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Tonight")

    let neverLetMeDown = ItemModel(string: "Never Let Me Down", dateCreated: Date())
    neverLetMeDown.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "NeverLetMeDown")

    let blackTieWhiteNoise = ItemModel(string: "Black Tie White Noise", dateCreated: Date())
    blackTieWhiteNoise.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "BlackTieWhiteNoise")

    let outside = ItemModel(string: "1. Outside", dateCreated: Date())
    outside.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Outside")

    let earthling = ItemModel(string: "Earthling", dateCreated: Date())
    earthling.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Earthling")

    let hours = ItemModel(string: "'Hours...'", dateCreated: Date())
    hours.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Hours")

    let heathen = ItemModel(string: "Heathen", dateCreated: Date())
    heathen.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Heathen")

    let reality = ItemModel(string: "Reality", dateCreated: Date())
    reality.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Reality")

    let theNextDay = ItemModel(string: "The Next Day", dateCreated: Date())
    theNextDay.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "TheNextDay")

    let blackstar = ItemModel(string: "Blackstar", dateCreated: Date())
    blackstar.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Blackstar")

    collection.items = [davidBowie1967, davidBowie1969, theManWhoSoldTheWorld, hunkyDory, ziggyStardust, aladdinSane, pinUps, diamondDogs, youngAmericans, stationToStation, low, heroes, lodger, scaryMonsters, letsDance, tonight, neverLetMeDown, blackTieWhiteNoise, outside, earthling, hours, heathen, reality, theNextDay, blackstar]
    
    return collection
}

func createHarryPotterCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Harry Potter", description: "Harry Potter is a series of seven fantasy novels written by British author J. K. Rowling. The series chronicles the life of a young wizard, Harry Potter, and his friends Hermione Granger and Ron Weasley, all of whom are students at Hogwarts School of Witchcraft and Wizardry.", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.premade = true
    

    let stone = ItemModel(string: "Philosopher's Stone", dateCreated: Date())
    stone.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "PhilosophersStone")

    let chamber = ItemModel(string: "Chamber of Secrets", dateCreated: Date())
    chamber.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "ChamberOfSecrets")

    let prisoner = ItemModel(string: "Prisoner of Azkaban", dateCreated: Date())
    prisoner.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "PrisonerOfAzkaban")

    let goblet = ItemModel(string: "Goblet of Fire", dateCreated: Date())
    goblet.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "GobletOfFire")

    let phoenix = ItemModel(string: "Order of the Phoenix", dateCreated: Date())
    phoenix.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "OrderOfThePhoenix")

    let prince = ItemModel(string: "Half-Blood Prince", dateCreated: Date())
    prince.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "HalfBloodPrince")

    let hallows = ItemModel(string: "Deathly Hallows", dateCreated: Date())
    hallows.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "DeathlyHallows")
    
    collection.items = [stone, chamber, prisoner, goblet, phoenix, prince, hallows]
    
    return collection
}

func createInternetBrowserCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Browsers", description: "A web browser (commonly referred to as a browser) is a software application for retrieving, presenting, and traversing information resources on the World Wide Web.", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.premade = true
    
    let internetExplorer = ItemModel(string: "Internet Explorer", dateCreated: Date())
    internetExplorer.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "InternetExplorer")

    let chrome = ItemModel(string: "Chrome", dateCreated: Date())
    chrome.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Chrome")

    let safari = ItemModel(string: "Safari", dateCreated: Date())
    safari.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Safari")

    let firefox = ItemModel(string: "Firefox", dateCreated: Date())
    firefox.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Firefox")

    let opera = ItemModel(string: "Opera", dateCreated: Date())
    opera.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Opera")

    let edge = ItemModel(string: "Edge", dateCreated: Date())
    edge.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Edge")

    collection.items = [internetExplorer, chrome, safari, firefox, opera, edge]
    
    return collection
}

func createDesktopOSCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Desktop OS", description: "An operating system (OS) is system software that manages computer hardware and software resources and provides common services for computer programs. The operating system is a component of the system software in a computer system. Application programs usually require an operating system to function.", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.premade = true
    
    let mac = ItemModel(string: "Mac", dateCreated: Date())
    mac.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Mac")

    let windows = ItemModel(string: "Windows", dateCreated: Date())
    windows.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Windows")

    let linux = ItemModel(string: "Linux", dateCreated: Date())
    linux.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Linux")
    
    collection.items = [mac, windows, linux]
    
    return collection
}

func createMobileOSCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Mobile OS", description: "A mobile operating system (or mobile OS) is an operating system for smartphones, tablets, PDAs, or other mobile devices. While computers such as the typical laptop are mobile, the operating systems usually used on them are not considered mobile ones as they were originally designed for bigger stationary desktop computers that historically did not have or need specific \"mobile\" features. This distinction is getting blurred in some newer operating systems that are hybrids made for both uses.", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.premade = true
    
    let ios = ItemModel(string: "iOS", dateCreated: Date())
    ios.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "IOS")

    let android = ItemModel(string: "Android", dateCreated: Date())
    android.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Android")

    let blackberry = ItemModel(string: "Blackberry", dateCreated: Date())
    blackberry.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Blackberry")

    let windows = ItemModel(string: "Windows Mobile", dateCreated: Date())
    windows.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "WindowsMobile")

    collection.items = [ios, android, blackberry, windows]
    
    return collection
}

func createDoctorWhoCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Doctor Who", description: "Doctor Who is a British science-fiction television programme produced by the BBC from 1963 to the present day. The programme depicts the adventures of the Doctor, a Time Lord—a space and time-travelling humanoid alien. He explores the universe in his TARDIS, a sentient time-travelling space ship. Its exterior appears as a blue British police box, which was a common sight in Britain in 1963 when the series first aired. Accompanied by companions, the Doctor combats a variety of foes, while working to save civilisations and help people in need.", dateCreated: Date())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: collection.name.trim()))
    collection.premade = true
    
    let hartnell = ItemModel(string: "First William Hartnell", dateCreated: Date())
    let troughton = ItemModel(string: "Second Patrick Troughton", dateCreated: Date())
    let pertwee = ItemModel(string: "Third Jon Pertwee", dateCreated: Date())
    let tomBaker = ItemModel(string: "Fourth Tom Baker", dateCreated: Date())
    let davison = ItemModel(string: "Fifth Peter Davison", dateCreated: Date())
    let colinBaker = ItemModel(string: "Sixth Colin Baker", dateCreated: Date())
    let mcCoy = ItemModel(string: "Seventh Sylvester McCoy", dateCreated: Date())
    let mcGann = ItemModel(string: "Eighth Paul McGann", dateCreated: Date())
    let eccleston = ItemModel(string: "Ninth Christopher Eccleston", dateCreated: Date())
    let tennant = ItemModel(string: "Tenth David Tennant", dateCreated: Date())
    let smith = ItemModel(string: "Eleventh Matt Smith", dateCreated: Date())
    let capaldi = ItemModel(string: "Twelfth Peter Capaldi", dateCreated: Date())

    collection.items = [hartnell, troughton, pertwee, tomBaker, davison, colinBaker, mcCoy, mcGann, eccleston, tennant, smith, capaldi]
    
    return collection
}

func createMarioCharactersCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Mario Characters", description: "The Mario series has an extensive cast of recurring characters. Among the most frequently recurring and significant ones are protagonist Mario, his antagonist Bowser, his brother Luigi, the Princess of the Mushroom Kingdom Peach, his sidekick and mount Yoshi, and his antihero doppelganger Wario.", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.premade = true
    
    let mario = ItemModel(string: "Mario", dateCreated: Date())
    mario.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Mario")

    let luigi = ItemModel(string: "Luigi", dateCreated: Date())
    luigi.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Luigi")

    let peach = ItemModel(string: "Peach", dateCreated: Date())
    peach.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Peach")

    let bowser = ItemModel(string: "Bowser", dateCreated: Date())
    bowser.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Bowser")

    let toad = ItemModel(string: "Toad", dateCreated: Date())
    toad.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Toad")

    collection.items = [mario, luigi, peach, bowser, toad]
    
    return collection
}

func createHottestHobbitsCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Hottest Hobbits", description: "Get down with The Shire", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.premade = true
    collection.image = UIImage(named: "Hobbits")

    let frodo = ItemModel(string: "Frodo", dateCreated: Date())
    frodo.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Frodo")
    frodo.image = UIImage(named: "Frodo")

    let sam = ItemModel(string: "Sam", dateCreated: Date())
    sam.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Sam")
    sam.image = UIImage(named: "Sam")
    
    let merry = ItemModel(string: "Merry", dateCreated: Date())
    merry.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Merry")
    merry.image = UIImage(named: "Merry")
    
    let pippin = ItemModel(string: "Pippin", dateCreated: Date())
    pippin.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "Pippin")
    pippin.image = UIImage(named: "Pippin")
    
    let bilboYoung = ItemModel(string: "Bilbo (Young)", dateCreated: Date())
    bilboYoung.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "BilboYoung")
    bilboYoung.image = UIImage(named: "BilboYoung")
    
    let bilboOld = ItemModel(string: "Bilbo (Old)", dateCreated: Date())
    bilboOld.record = createRecordOfTypeWithUniqueIdentifier(itemRecordType, uniqueIdentifier: "BilboOld")
    bilboOld.image = UIImage(named: "BilboOld")
    
    collection.items = [frodo, sam, merry, pippin, bilboYoung, bilboOld]
    
    return collection
}

          
