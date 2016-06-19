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
    private var imageKey = "image"

    var record = CKRecord(recordType: "Collection")
    
    var name = ""
    var descriptionString = ""
    var sorted = false
    var dateCreated: Date
    var image: UIImage?
    
    var premade = false
    
    var items = [ItemModel]()
    
    private let uuid = UUID().uuidString
    
    init(name: String, description: String, dateCreated: Date) {
        
        self.name = name
        self.descriptionString = description
        self.dateCreated = dateCreated
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        if let decodedName = aDecoder.decodeObject(forKey: nameKey) as? String {
            
            name = decodedName
            
        } else {
            name = "Unable to decode Collection name"
        }
        
        if let decodedDescription = aDecoder.decodeObject(forKey: descriptionKey) as? String {
            
            descriptionString = decodedDescription
            
        } else {
            descriptionString = "Unable to decode Collection description"
        }
        
        if let decodedMotifs = aDecoder.decodeObject(forKey: itemsKey) as? [ItemModel] {
            
            items = decodedMotifs
        }
        
        if let decodedName = aDecoder.decodeObject(forKey: nameKey) as? String {
            
            name = decodedName
            
        } else {
            name = "Unable to decode Collection name"
        }
        
        if let decodedDateCreated = aDecoder.decodeObject(forKey: dateCreatedKey) as? Date {
            
            dateCreated = decodedDateCreated
        } else {
            dateCreated = Date()
        }
        
        if let decodedSorted = aDecoder.decodeObject(forKey: sortedKey) as? Bool {
            
            sorted = decodedSorted
        } else {
            sorted = false
        }
        
        if let decodedRecord = aDecoder.decodeObject(forKey: recordKey) as? CKRecord {
            
            record = decodedRecord
        }
        
        if let decodedPremade = aDecoder.decodeObject(forKey: premadeKey) as? Bool {
            
            premade = decodedPremade
        } else {
            premade = false
        }
        
        if let decodedImage = aDecoder.decodeObject(forKey: imageKey) as? UIImage {
            
            image = decodedImage
        }
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(descriptionString, forKey: descriptionKey)
        aCoder.encode(items, forKey: itemsKey)
        aCoder.encode(dateCreated, forKey: dateCreatedKey)
        aCoder.encode(sorted, forKey: sortedKey)
        aCoder.encode(record, forKey: recordKey)
        aCoder.encode(premade, forKey: premadeKey)
        aCoder.encode(image, forKey: imageKey)
    }
    
    func returnArrayOfItems(_ sorted: Bool) -> [ItemModel] {
        
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
    private let scoreKey = "score"
    private let sortedKey = "sorted"
    private var recordKey = "record"
    private let dateCreatedKey = "dateCreated"
    private var imageKey = "image"
    private var collectionReferenceKey = "collectionReference"

    var text: String
    var tag = Int()
    var sorted = false
    var score = 0
    var dateCreated: Date
    var image: UIImage?

    var record = CKRecord(recordType: "Item")
    var collectionReference = ""
    
    init(string: String, dateCreated: Date) {
        text = string
        self.dateCreated = dateCreated
    }
    
    convenience init(name: String, image: String?) {
        
        self.init(string: name, dateCreated: Date())
        record = createRecordOfTypeWithUniqueIdentifier("Item", uniqueIdentifier: name.trim())
        
        if let image = image {
            self.image = UIImage(named: image)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        
        if let decodedText = aDecoder.decodeObject(forKey: textKey) as? String {
            
            text = decodedText
            
        } else {
            text = "Unable to decode Item text"
        }
        
        if let decodedScore = aDecoder.decodeObject(forKey: scoreKey) as? Int {
            
            score = decodedScore
            
        } else {
            score = 0
        }
        
        if let decodedSorted = aDecoder.decodeObject(forKey: sortedKey) as? Bool {
            
            sorted = decodedSorted
        }
        
        if let decodedRecord = aDecoder.decodeObject(forKey: recordKey) as? CKRecord {
            
            record = decodedRecord
        }
        
        if let decodedDateCreated = aDecoder.decodeObject(forKey: dateCreatedKey) as? Date {
            
            dateCreated = decodedDateCreated
        } else {
            dateCreated = Date()
        }
        
        if let decodedImage = aDecoder.decodeObject(forKey: imageKey) as? UIImage {
            
            image = decodedImage
        }
        
        if let decodedCollectionReference = aDecoder.decodeObject(forKey: collectionReferenceKey) as? String {
            
            collectionReference = decodedCollectionReference
        }
        
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        
        aCoder.encode(text, forKey: textKey)
        aCoder.encode(score, forKey: scoreKey)
        aCoder.encode(sorted, forKey: sortedKey)
        aCoder.encode(record, forKey: recordKey)
        aCoder.encode(dateCreated, forKey: dateCreatedKey)
        aCoder.encode(image, forKey: imageKey)
        aCoder.encode(collectionReference, forKey: collectionReferenceKey)
    }
}
