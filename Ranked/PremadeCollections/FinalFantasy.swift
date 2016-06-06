//
//  FinalFantasy.swift
//  Project Order
//
//  Created by William Robinson on 22/05/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import CloudKit

private let collectionRecordType = "Collection"
private let itemRecordType = "Item"

func createFinalFantasyCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Final Fantasy", description: "Final Fantasy (ファイナルファンタジー Fainaru Fantajī?) is a science fiction and fantasy media franchise created by Hironobu Sakaguchi, and developed and owned by Square Enix (formerly Square). The franchise centers on a series of fantasy and science fantasy role-playing video games (RPGs). The eponymous first game in the series, published in 1987, was conceived by Sakaguchi as his last-ditch effort in the game industry; the title was a success and spawned sequels.", dateCreated: NSDate())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: collection.name.trim()))
    collection.premade = true
    //collection.image = UIImage(named: "")
    
    let item1 = ItemModel(name: "Final Fantasy I", image: "FinalFantasy1")
    
    let item2 = ItemModel(name: "Final Fantasy II", image: nil)

    let item3 = ItemModel(name: "Final Fantasy III", image: "FinalFantasy3")

    let item4 = ItemModel(name: "Final Fantasy IV", image: "FinalFantasy4")

    let item5 = ItemModel(name: "Final Fantasy V", image: "FinalFantasy5")

    let item6 = ItemModel(name: "Final Fantasy VI", image: "FinalFantasy6")

    let item7 = ItemModel(name: "Final Fantasy VII", image: "FinalFantasy7")

    let item8 = ItemModel(name: "Final Fantasy VIII", image: "FinalFantasy8")

    let item9 = ItemModel(name: "Final Fantasy IX", image: "FinalFantasy9")

    let item10 = ItemModel(name: "Final Fantasy X", image: nil)

    let item11 = ItemModel(name: "Final Fantasy XI", image: nil)

    let item12 = ItemModel(name: "Final Fantasy XII", image: nil)

    let item13 = ItemModel(name: "Final Fantasy XIII", image: nil)

    let item14 = ItemModel(name: "Final Fantasy XIV", image: nil)

    let item15 = ItemModel(name: "Final Fantasy XV", image: nil)
    
    collection.items = [item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14, item15]
    
    return collection
}