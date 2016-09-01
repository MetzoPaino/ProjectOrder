//
//  Singles.swift
//  Project Order
//
//  Created by William Robinson on 28/08/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation

private let collectionRecordType = "Collection"
private let itemRecordType = "Item"

func createSinglesCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "1. Singles 2010 - 2015", description: "", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.descriptionString = "Number 1 singles from the Billboard chart"
    collection.premade = true
    
    let item1 = ItemModel(name: "Tik Tok - Kesha", image: nil)
    
    let item2 = ItemModel(name: "Imma Be - The Black Eyed Peas", image: nil)
    
    let item3 = ItemModel(name: "Break Your Heart - Taio Cruz featuring Ludacris", image: nil)
    
    let item4 = ItemModel(name: "Rude Boy - Rihanna", image: nil)
    
    let item5 = ItemModel(name: "Nothin' on You - B.o.B featuring Bruno Mars", image: nil)
    
    let item6 = ItemModel(name: "OMG - Usher featuring will.i.am", image: nil)
    
    let item7 = ItemModel(name: "Not Afraid - Eminem", image: nil)
    
    let item8 = ItemModel(name: "California Gurls - Katy Perry featuring Snoop Dogg", image: nil)
    
    let item9 = ItemModel(name: "Love the Way You Lie - Eminem featuring Rihanna", image: nil)
    
    let item10 = ItemModel(name: "Teenage Dream - Katy Perry", image: nil)
    
    let item11 = ItemModel(name: "Just the Way You Are - Bruno Mars", image: nil)
    
    let item12 = ItemModel(name: "Like a G6 - Far East Movement featuring The Cataracs and Dev", image: nil)
    
    let item13 = ItemModel(name: "We R Who We R - Kesha", image: nil)
    
    let item14 = ItemModel(name: "What's My Name? - Rihanna featuring Drake", image: nil)
    
    let item15 = ItemModel(name: "Only Girl (In the World) - Rihanna", image: nil)
    
    let item16 = ItemModel(name: "Raise Your Glass - Pink", image: nil)
    
    let item17 = ItemModel(name: "Firework - Katy Perry", image: nil)
    
    let item18 = ItemModel(name: "Grenade - Bruno Mars", image: nil)
    
    let item19 = ItemModel(name: "Hold It Against Me - Britney Spears", image: nil)
    
    let item20 = ItemModel(name: "Black and Yellow - Wiz Khalifa", image: nil)
    
    let item21 = ItemModel(name: "Born This Way - Lady Gaga", image: nil)
    
    let item22 = ItemModel(name: "E.T. - Katy Perry featuring Kanye West", image: nil)
    
    let item23 = ItemModel(name: "S&M - Rihanna featuring Britney Spears", image: nil)
    
    let item24 = ItemModel(name: "Rolling in the Deep - Adele", image: nil)
    
    let item25 = ItemModel(name: "Give Me Everything - Pitbull featuring Ne-Yo, Afrojack and Nayer", image: nil)
    
    let item26 = ItemModel(name: "Party Rock Anthem - LMFAO featuring Lauren Bennett and GoonRock", image: nil)
    
    let item27 = ItemModel(name: "Last Friday Night (T.G.I.F.) - Katy Perry", image: nil)
    
    let item28 = ItemModel(name: "Moves Like Jagger - Maroon 5 featuring Christina Aguilera", image: nil)
    
    let item29 = ItemModel(name: "Someone Like You - Adele", image: nil)
    
    let item30 = ItemModel(name: "We Found Love - Rihanna featuring Calvin Harris", image: nil)
    
    let item31 = ItemModel(name: "Sexy and I Know It - LMFAO", image: nil)
    
    let item32 = ItemModel(name: "Set Fire to the Rain - Adele", image: nil)
    
    let item33 = ItemModel(name: "Stronger (What Doesn't Kill You) - Kelly Clarkson", image: nil)
    
    let item34 = ItemModel(name: "Part of Me - Katy Perry", image: nil)
    
    let item35 = ItemModel(name: "We Are Young - Fun featuring Janelle Monáe", image: nil)
    
    let item36 = ItemModel(name: "Somebody That I Used to Know - Gotye featuring Kimbra", image: nil)
    
    let item37 = ItemModel(name: "Call Me Maybe - Carly Rae Jepsen", image: nil)
    
    let item38 = ItemModel(name: "Whistle - Flo Rida", image: nil)
    
    let item39 = ItemModel(name: "We Are Never Ever Getting Back Together - Taylor Swift", image: nil)
    
    let item40 = ItemModel(name: "One More Night - Maroon 5", image: nil)
    
    let item41 = ItemModel(name: "Diamonds - Rihanna", image: nil)
    
    let item42 = ItemModel(name: "Locked Out of Heaven - Bruno Mars", image: nil)
    
    let item43 = ItemModel(name: "Thrift Shop - Macklemore & Ryan Lewis featuring Wanz", image: nil)
    
    let item44 = ItemModel(name: "Harlem Shake - Baauer", image: nil)
    
    let item45 = ItemModel(name: "When I Was Your Man - Bruno Mars", image: nil)
    
    let item46 = ItemModel(name: "Just Give Me a Reason - Pink featuring Nate Ruess", image: nil)
    
    let item47 = ItemModel(name: "Can't Hold Us - Macklemore & Ryan Lewis featuring Ray Dalton", image: nil)
    
    let item48 = ItemModel(name: "Blurred Lines - Robin Thicke featuring T.I. and Pharrell", image: nil)
    
    let item49 = ItemModel(name: "Roar - Katy Perry", image: nil)
    
    let item50 = ItemModel(name: "Wrecking Ball - Miley Cyrus", image: nil)
    
    let item51 = ItemModel(name: "Royals - Lorde", image: nil)
    
    let item52 = ItemModel(name: "The Monster - Eminem featuring Rihanna", image: nil)
    
    let item53 = ItemModel(name: "Timber - Pitbull featuring Kesha", image: nil)
    
    let item54 = ItemModel(name: "Dark Horse - Katy Perry featuring Juicy J", image: nil)
    
    let item55 = ItemModel(name: "Happy - Pharrell Williams", image: nil)
    
    let item56 = ItemModel(name: "All of Me - John Legend", image: nil)
    
    let item57 = ItemModel(name: "Fancy - Iggy Azalea featuring Charli XCX", image: nil)
    
    let item58 = ItemModel(name: "Rude - Magic!", image: nil)
    
    let item59 = ItemModel(name: "Shake It Off - Taylor Swift", image: nil)
    
    let item60 = ItemModel(name: "All About That Bass - Meghan Trainor", image: nil)
    
    let item61 = ItemModel(name: "Blank Space - Taylor Swift", image: nil)
    
    let item62 = ItemModel(name: "Uptown Funk - Mark Ronson featuring Bruno Mars", image: nil)
    
    let item63 = ItemModel(name: "See You Again - Wiz Khalifa featuring Charlie Puth", image: nil)
    
    let item64 = ItemModel(name: "Bad Blood - Taylor Swift featuring Kendrick Lamar", image: nil)
    
    let item65 = ItemModel(name: "Cheerleader - OMI", image: nil)
    
    let item66 = ItemModel(name: "Can't Feel My Face - The Weeknd", image: nil)
    
    let item67 = ItemModel(name: "What Do You Mean? - Justin Bieber", image: nil)
    
    let item68 = ItemModel(name: "The Hills - The Weeknd", image: nil)
    
    let item69 = ItemModel(name: "Hello - Adele", image: nil)
    
    collection.items = [item1, item2, item3, item4, item5, item6, item7, item8, item9,
                        item10, item11, item12, item13, item14, item15, item16, item17, item18, item19,
                        item20, item21, item22, item23, item24, item25, item26, item27, item28, item29,
                        item30, item31, item32, item33, item34, item35, item36, item37, item38, item39,
                        item40, item41, item42, item43, item44, item45, item46, item47, item48, item49,
                        item50, item51, item52, item53, item54, item55, item56, item57, item58, item59,
                        item60, item61, item62, item63, item64, item65, item66, item67, item68, item69]
    
    return collection
}
