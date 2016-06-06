//
//  Tarantino.swift
//  Project Order
//
//  Created by William Robinson on 06/06/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import CloudKit

private let collectionRecordType = "Collection"
private let itemRecordType = "Item"

func createTarantinoCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Tarantino", description: "From Pulp Fiction to The Hateful Eight because it's so much fun Jan!", dateCreated: NSDate())
    collection.record = CKRecord(recordType: "Collection", recordID: CKRecordID(recordName: collection.name.trim()))
    collection.premade = true
    //collection.image = UIImage(named: "")
    
    let item1 = ItemModel(name: "Reservoir Dogs", image: nil)
    
    let item2 = ItemModel(name: "Pulp Fiction", image: nil)
    
    let item3 = ItemModel(name: "Jackie Brown", image: nil)
    
    let item4 = ItemModel(name: "Kill Bill: Volume 1", image: nil)
    
    let item5 = ItemModel(name: "Kill Bill: Volume 2", image: nil)
    
    let item6 = ItemModel(name: "Death Proof", image: nil)
    
    let item7 = ItemModel(name: "Inglourious Basterds", image: nil)
    
    let item8 = ItemModel(name: "Django Unchained", image: nil)
    
    let item9 = ItemModel(name: "The Hateful Eight", image: nil)
    
    collection.items = [item1, item2, item3, item4, item5, item6, item7, item8, item9]
    
    return collection
}