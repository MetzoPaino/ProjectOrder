//
//  StarWars.swift
//  Project Order
//
//  Created by William Robinson on 18/06/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import CloudKit

private let collectionRecordType = "Collection"
private let itemRecordType = "Item"

func createStarWarsCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Star Wars", description: "Star Wars is an American epic space opera franchise, centered on a film series created by George Lucas. It depicts the adventures of various characters \"a long time ago in a galaxy far, far away\"", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.premade = true
    collection.image = UIImage(named: "StarWars")
    
    let item1 = ItemModel(name: "The Phantom Menace", image: nil)
    
    let item2 = ItemModel(name: "The Clone Wars", image: nil)
    
    let item3 = ItemModel(name: "Revenge of the Sith", image: nil)
    
    let item4 = ItemModel(name: "A New Hope", image: nil)
    
    let item5 = ItemModel(name: "The Empire Strikes Back", image: nil)
    
    let item6 = ItemModel(name: "Return of the Jedi", image: nil)
    
    let item7 = ItemModel(name: "The Force Awakens", image: nil)
    
    collection.items = [item1, item2, item3, item4, item5, item6, item7]
    
    return collection
}
