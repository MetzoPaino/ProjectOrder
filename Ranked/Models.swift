//
//  Models.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import CloudKit

enum sortBy {
    case date
    case score
}

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
        
        if let decodedSorted = aDecoder.decodeObject(forKey: sortedKey) as? NSNumber {
            
            sorted = decodedSorted.boolValue
        }
        
        if let decodedRecord = aDecoder.decodeObject(forKey: recordKey) as? CKRecord {
            
            record = decodedRecord
        }
        
        if let decodedPremade = aDecoder.decodeObject(forKey: premadeKey) as? NSNumber {
            
            premade = decodedPremade.boolValue
        }
        
        if let decodedImage = aDecoder.decodeObject(forKey: imageKey) as? UIImage {
            
            image = decodedImage
        }
        
        super.init()
    }
    
    func encode(with aCoder: NSCoder) {
        
        let sortedNumber = NSNumber(booleanLiteral: sorted)
        let premadeNumber = NSNumber(booleanLiteral: premade)
        
        aCoder.encode(name, forKey: nameKey)
        aCoder.encode(descriptionString, forKey: descriptionKey)
        aCoder.encode(items, forKey: itemsKey)
        aCoder.encode(dateCreated, forKey: dateCreatedKey)
        aCoder.encode(record, forKey: recordKey)
        aCoder.encode(image, forKey: imageKey)
        aCoder.encode(premadeNumber, forKey: premadeKey)
        aCoder.encode(sortedNumber, forKey: sortedKey)
    }
    
    func returnArrayOfItems(sorted: Bool) -> [ItemModel] {
        
        var requestedItems = [ItemModel]()
        
        for item in self.items {
            
            if sorted == true {
                
                if let _ = item.score {
                    
                    requestedItems.append(item)
                }
                
            } else {
                
                if item.score == nil {
                    requestedItems.append(item)
                }
            }
        }
        
        return requestedItems
    }
    
    func sortCollection(sortType: sortBy) {
        
        switch sortType {
        case .date:
            self.items = self.items.sorted(by: { $0.dateCreated < $1.dateCreated })
            break
        case .score:
            sortCollection()
            break
        }
    }
    
    func sortCollection() {
        
        if sorted {
                        
            self.items = self.items.sorted(by: {
                
                if $0.score != nil && $1.score != nil {
                    
                    return $0.score! > $1.score!
                } else {
                    
                    return $0.dateCreated < $1.dateCreated
                }
            })
                //$0.score! > $1.score! })
        } else {
            self.items = self.items.sorted(by: { $0.dateCreated < $1.dateCreated })
        }
    }
}

class ItemModel: NSObject, NSCoding {
    
    private let textKey = "text"
    private let scoreKey = "score"
    private var recordKey = "record"
    private let dateCreatedKey = "dateCreated"
    private var imageKey = "image"
    private var collectionReferenceKey = "collectionReference"

    var text: String
    var tag = Int()
    var score: Int?
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
        aCoder.encode(record, forKey: recordKey)
        aCoder.encode(dateCreated, forKey: dateCreatedKey)
        aCoder.encode(image, forKey: imageKey)
        aCoder.encode(collectionReference, forKey: collectionReferenceKey)
    }
}
