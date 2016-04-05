//
//  Models.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class CollectionModel: NSObject, NSCoding {
    
    private let nameKey = "name"
    private let descriptionKey = "description"
    private let itemsKey = "items"
    private let dateCreatedKey = "dateCreated"
    private let sortedKey = "sorted"

    var name = ""
    var descriptionString = ""
    var sorted = false
    var dateCreated: NSDate

    var items = [ItemModel]()
    
    private let uuid = NSUUID().UUIDString
    
    init(name: String, description: String, dateCreated: NSDate) {
        self.name = name
        self.descriptionString = description
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
        aCoder.encodeObject(dateCreated, forKey: dateCreatedKey)
        aCoder.encodeObject(sorted, forKey: sortedKey)
    }
}

class ItemModel: NSObject, NSCoding {
    
    private let textKey = "text"
    private let pointsKey = "points"

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
        
        if let decodedPoints = aDecoder.decodeObjectForKey(pointsKey) as? Int {
            
            points = decodedPoints
            
        } else {
            points = 0
        }
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(text, forKey: textKey)
        aCoder.encodeObject(points, forKey: pointsKey)
    }
}
