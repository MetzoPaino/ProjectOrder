//
//  Seasons.swift
//  Project Order
//
//  Created by William Robinson on 26/08/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation

private let collectionRecordType = "Collection"
private let itemRecordType = "Item"

func createSeasonsCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Seasons", description: "", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.premade = true
    
    let item1 = ItemModel(name: "Spring", image: nil)
    
    let item2 = ItemModel(name: "Summer", image: nil)
    
    let item3 = ItemModel(name: "Autumn", image: nil)
    
    let item4 = ItemModel(name: "Winter", image: nil)
    
    collection.items = [item1, item2, item3, item4]
    
    return collection
}
