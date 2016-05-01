//
//  Models.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import CloudKit

class CollectionModel: NSObject, NSCoding {
    
    private let nameKey = "name"
    private let descriptionKey = "description"
    private let itemsKey = "items"
    private let dateCreatedKey = "dateCreated"
    private let sortedKey = "sorted"
    private var recordKey = "record"
    private var premadeKey = "premade"

    var record = CKRecord(recordType: "Collection")
    
    var name = ""
    var descriptionString = ""
    var sorted = false
    var dateCreated: NSDate
    
    var premade = false
    
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
        
        if let decodedRecord = aDecoder.decodeObjectForKey(recordKey) as? CKRecord {
            
            record = decodedRecord
        }
        
        if let decodedPremade = aDecoder.decodeObjectForKey(premadeKey) as? Bool {
            
            premade = decodedPremade
        } else {
            premade = false
        }
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(name, forKey: nameKey)
        aCoder.encodeObject(descriptionString, forKey: descriptionKey)
        aCoder.encodeObject(items, forKey: itemsKey)
        aCoder.encodeObject(dateCreated, forKey: dateCreatedKey)
        aCoder.encodeObject(sorted, forKey: sortedKey)
        aCoder.encodeObject(record, forKey: recordKey)
        aCoder.encodeObject(premade, forKey: premadeKey)
    }
    
    func returnArrayOfItems(sorted: Bool) -> [ItemModel] {
        
        var requestedItems = [ItemModel]()
        
        for item in self.items {
            
            if sorted && item.sorted{
                
                requestedItems.append(item)
                
            } else if !sorted && !item.sorted {
                
                requestedItems.append(item)
            }
        }
        return requestedItems
    }
}

class ItemModel: NSObject, NSCoding {
    
    private let textKey = "text"
    private let pointsKey = "points"
    private let sortedKey = "sorted"
    private var recordKey = "record"

    var text: String
    var tag = Int()
    var sorted = false
    var points = 0
    
    var record = CKRecord(recordType: "Item")
    
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
        
        if let decodedSorted = aDecoder.decodeObjectForKey(sortedKey) as? Bool {
            
            sorted = decodedSorted
        }
        
        if let decodedRecord = aDecoder.decodeObjectForKey(recordKey) as? CKRecord {
            
            record = decodedRecord
        }
        
        super.init()
    }
    
    func encodeWithCoder(aCoder: NSCoder) {
        
        aCoder.encodeObject(text, forKey: textKey)
        aCoder.encodeObject(points, forKey: pointsKey)
        aCoder.encodeObject(sorted, forKey: sortedKey)
        aCoder.encodeObject(record, forKey: recordKey)
    }
}
