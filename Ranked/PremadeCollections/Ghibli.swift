//
//  Ghibli.swift
//  Project Order
//
//  Created by William Robinson on 28/08/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation

private let collectionRecordType = "Collection"
private let itemRecordType = "Item"

func createGhibliCollection() -> CollectionModel {
    
    let collection = CollectionModel(name: "Ghibli Films", description: "", dateCreated: Date())
    collection.record = createRecordOfTypeWithUniqueIdentifier(collectionRecordType, uniqueIdentifier: collection.name.trim())
    collection.premade = true
    
    let item1 = ItemModel(name: "Castle in the Sky", image: nil)
    
    let item2 = ItemModel(name: "Grave of the Fireflies", image: nil)
    
    let item3 = ItemModel(name: "My Neighbor Totoro", image: nil)
    
    let item4 = ItemModel(name: "Kiki's Delivery Service", image: nil)
    
    let item5 = ItemModel(name: "Only Yesterday", image: nil)
    
    let item6 = ItemModel(name: "Porco Rosso", image: nil)
    
    let item7 = ItemModel(name: "Pom Poko", image: nil)
    
    let item8 = ItemModel(name: "Whisper of the Heart", image: nil)
    
    let item9 = ItemModel(name: "Princess Mononoke", image: nil)
    
    let item10 = ItemModel(name: "My Neighbors the Yamadas", image: nil)
    
    let item11 = ItemModel(name: "Spirited Away", image: nil)
    
    let item12 = ItemModel(name: "The Cat Returns", image: nil)
    
    let item13 = ItemModel(name: "Howl's Moving Castle", image: nil)
    
    let item14 = ItemModel(name: "Tales from Earthsea", image: nil)
    
    let item15 = ItemModel(name: "Ponyo", image: nil)
    
    let item16 = ItemModel(name: "Arrietty", image: nil)
    
    let item17 = ItemModel(name: "From Up on Poppy Hill", image: nil)
    
    let item18 = ItemModel(name: "The Wind Rises", image: nil)
    
    let item19 = ItemModel(name: "The Tale of the Princess Kaguya", image: nil)
    
    let item20 = ItemModel(name: "When Marnie Was There", image: nil)
    
    collection.items = [item1, item2, item3, item4, item5, item6, item7, item8, item9, item10, item11, item12, item13, item14, item15, item16, item17, item18, item19, item20]
    
    return collection
}
