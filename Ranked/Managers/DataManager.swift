//
//  DataManager.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation
import CloudKit

protocol DataManagerDelegate: class {
    func newCollection()
    func deleteLocalCollection(collection: CollectionModel)
    func updateLocalCollection(collection: CollectionModel)
    
    func newItem(reference: String)
    func deleteLocalItemFromCollection(collection: CollectionModel)
    func updateLocalItemInCollection(item: ItemModel, collection: CollectionModel)
}

class DataManager {
    
    var collections = [CollectionModel]()
    var cloudKitManager = CloudKitManager()
    weak var delegate: DataManagerDelegate?
    
    let preMadeCollectionsArray = [createDavidBowieCollection(), createStarWarsCollection(), createHarryPotterCollection(), createFinalFantasyCollection(), createInternetBrowserCollection(), createDesktopOSCollection(), createMobileOSCollection(), createDoctorWhoCollection(), createMarioCharactersCollection(), createHottestHobbitsCollection()]
    
    init() {
        
        cloudKitManager.subscribeToCollectionUpdates()

        cloudKitManager.delegate = self
        loadData()
        cloudKitManager.getOutstandingNotifications()
    }
    
    // MARK: - Save & Load
    
    func saveData() {
        
        print("Saving Data")
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWithMutableData: data)
        archiver.encodeObject(collections, forKey: "Collections")
        
        
        archiver.finishEncoding()
        data.writeToFile(dataFilePath(), atomically: true)
    }
    
    func loadData() {
        let path = dataFilePath()
        if NSFileManager.defaultManager().fileExistsAtPath(path) {
            if let data = NSData(contentsOfFile: path) {
                let unarchiver = NSKeyedUnarchiver(forReadingWithData: data)
                if let unarchivedCollections = unarchiver.decodeObjectForKey("Collections") as? [CollectionModel] {
                    
                    print("Found Collections")
                    collections = unarchivedCollections
                    
                } else {
                    
                    print("Didn't find Collections")
                    collections = [CollectionModel]()
                }
                
                unarchiver.finishDecoding()
            }
        } else {
            
            print("No file path")
            collections = [CollectionModel]()
//            var temp = preMadeCollectionsArray
//            
//            while collections.count < preMadeCollectionsArray.count {
//                
//                let random = Int(arc4random_uniform(UInt32(temp.count - 1)))
//                
//                collections.append(temp[random])
//                temp.removeAtIndex(random)
//                
//                
//            }
        }
    }
    
    func dataFilePath() -> String {
        return documentsDirectory().stringByAppendingString("/Ranked.plist")
    }
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true) as [String]
        return paths[0]
    }
}

extension DataManager: CloudKitManagerDelegate {
    
    // MARK: Collections
    
    func newCloudCollection(collection: CollectionModel) {
        
        collections.append(collection)
        self.delegate?.newCollection()
    }
    
    func deleteCollectionWithReference(reference: String) {
        
        for (index, collection) in collections.enumerate() {
            
            if collection.record.recordID.recordName == reference {
                
                print(collection.record.recordID.recordName)

                collections.removeAtIndex(index)
                self.delegate?.deleteLocalCollection(collection)
            }
        }
    }
    
    func updateCollectionWithReference(updatedCollection: CollectionModel, reference: String) {
        
        for (index, collection) in collections.enumerate() {
            
            if collection.record.recordID.recordName == reference {
                
                print(collection.record.recordID.recordName)

                collections[index].name = updatedCollection.name
                collections[index].descriptionString = updatedCollection.descriptionString

                self.delegate?.updateLocalCollection(collections[index])
            }
        }
    }
    
    //MARK: Items
    
    func newCloudItemFromCollectionReference(item: ItemModel, reference: String) {
        
        for collection in collections {
            
            if collection.record.recordID.recordName == reference {
                
                print(collection.record.recordID.recordName)

                collection.items.insert(item, atIndex: 0)
                self.delegate?.newItem(reference)
            }
        }
    }
    
    func deleteItemWithReference(reference: String) {
        
        for collection in collections {
            
            for (index, item) in collection.items.enumerate() {
                
                if item.record.recordID.recordName == reference {
                    
                    print(item.record.recordID.recordName)
                    collection.items.removeAtIndex(index)
                    self.delegate?.deleteLocalItemFromCollection(collection)
                }
            }
        }
    }
    
    func updateItemWithReference(updatedItem: ItemModel, reference: String) {
        
        for collection in collections {
            
            for (index, item) in collection.items.enumerate() {
                
                if item.record.recordID.recordName == reference {
                    
                    print(item.record.recordID.recordName)
                    collection.items[index].text = updatedItem.text
                    collection.items[index].sorted = updatedItem.sorted
                    self.delegate?.updateLocalItemInCollection(collection.items[index], collection: collection)
                }
            }
        }
    }
}