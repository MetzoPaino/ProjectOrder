//
//  Models.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

enum CollectionType: Int {
    case music
    case films
    case books
    case games
    case none
}

class CategoriesManager {
    
    let music = Category(title: "Music", type: .music)
    let films = Category(title: "Films", type: .films)
    let books = Category(title: "Books", type: .books)
    let games = Category(title: "Games", type: .games)
    let none = Category(title: "None", type: .none)
    
    var categories: [Category] {
        get{
            return [music, films, books, games, none]
        }
    }
}

struct Category {
    
    let title: String
    let type: CollectionType
}

class CollectionModel: NSObject, NSCoding {
    
    let nameKey = "name"
    let descriptionKey = "description"
    let itemsKey = "items"
    let categoryKey = "category"
    let dateCreatedKey = "dateCreated"
    let sortedKey = "sorted"

    var name = ""
    var descriptionString = ""
    var category: CollectionType
    var sorted = false
    var dateCreated: NSDate

    var items = [ItemModel]()
    
    init(name: String, description: String, category: CollectionType, dateCreated: NSDate) {
        self.name = name
        self.descriptionString = description
        self.category = category
        self.dateCreated = dateCreated
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        if let decodedName = aDecoder.decodeObjectForKey(nameKey) as? String {
            
            name = decodedName
            
        } else {
            name = "Unable to decode Collection name"
        }
        
        if let decodedDescription = aDecoder.decodeObjectForKey(descriptionKey) as? String {
            
            descriptionString = decodedDescription
            
        } else {
            descriptionString = "Unable to decode Collection description"
        }
        
        if let decodedMotifs = aDecoder.decodeObjectForKey(itemsKey) as? [ItemModel] {
            
            items = decodedMotifs
        }
        
        if let decodedName = aDecoder.decodeObjectForKey(nameKey) as? String {
            
            name = decodedName
            
        } else {
            name = "Unable to decode Collection name"
        }
        
        if let decodedCategory = aDecoder.decodeObjectForKey(categoryKey) as? Int {
            
            category = CollectionType(rawValue: decodedCategory)!
            
        } else {
            category = .none
        }
        
        if let decodedDateCreated = aDecoder.decodeObjectForKey(dateCreatedKey) as? NSDate {
            
            dateCreated = decodedDateCreated
        } else {
            dateCreated = NSDate()
        }
        
        if let decodedSorted = aDecoder.decodeObjectForKey(sortedKey) as? Bool {
            
            sorted = decodedSorted
        } else {
            sorted = false
        }
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        print("Saving Theme")
        aCoder.encodeObject(name, forKey: nameKey)
        aCoder.encodeObject(descriptionString, forKey: descriptionKey)
        aCoder.encodeObject(items, forKey: itemsKey)
        aCoder.encodeObject(category.hashValue, forKey: categoryKey)
        aCoder.encodeObject(dateCreated, forKey: dateCreatedKey)
        aCoder.encodeObject(sorted, forKey: sortedKey)
    }
}

class ItemModel: NSObject, NSCoding {
    
    let textKey = "text"
    
    var text: String
    var tag = Int()
    var points = 0
    
    init(string: String) {
        text = string
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        if let decodedText = aDecoder.decodeObjectForKey(textKey) as? String {
            
            text = decodedText
            
        } else {
            text = "Unable to decode Item text"
        }
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        print("Saving Motif")
        aCoder.encodeObject(text, forKey: textKey)
    }
}
