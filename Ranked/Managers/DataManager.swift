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
    func deleteLocalCollection(_ collection: CollectionModel)
    func updateLocalCollection(_ collection: CollectionModel)
    
    func newItem(_ reference: String)
    func deleteLocalItemFromCollection(_ collection: CollectionModel)
    func updateLocalItemInCollection(_ item: ItemModel, collection: CollectionModel)
}

class DataManager {
    
    weak var delegate: DataManagerDelegate?
    
    let cloudKitManager: CloudKitManager
    var collections: [CollectionModel]
    var lostItems: [(ItemModel)]

    var firstLaunch = true
    
    required init() {
        
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        let path = paths[0] + "/ProjectOrder.plist"
        
        if FileManager.default().fileExists(atPath: path) {
            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
                
                if let decodedCollections = unarchiver.decodeObject(forKey: "Collections") as? [CollectionModel] {
                    
                    collections = decodedCollections
                    
                } else {
                    
                    print("Didn't find Collections")
                    collections = [CollectionModel]()
                }
                
                if let decodedLostItems = unarchiver.decodeObject(forKey: "LostItems") as? [ItemModel] {
                    
                    lostItems = decodedLostItems
                    
                } else {
                    
                    lostItems = [ItemModel]()
                }

                if let decodedCloudKitManager = unarchiver.decodeObject(forKey: "CloudKitManager") as? CloudKitManager {
                    
                    cloudKitManager = decodedCloudKitManager
                    
                } else {
                    
                    cloudKitManager = CloudKitManager()
                }
                
                unarchiver.finishDecoding()
        
            } else {
                
                // I don't know how i'd end up here, so should figure that out
                collections = [CollectionModel]()
                lostItems = [ItemModel]()
                cloudKitManager = CloudKitManager()
            }
            
            firstLaunch = false
            
        } else {
            
            // Probably a first launch
            collections = [CollectionModel]()
            lostItems = [ItemModel]()
            cloudKitManager = CloudKitManager()
        }
        
        // Need to hook up the delegate every time        
        cloudKitManager.delegate = self

    }
    
    // MARK: - Save & Load
    
    func saveData() {
        
        print("Saving Data")
        
        let data = NSMutableData()
        let archiver = NSKeyedArchiver(forWritingWith: data)
        archiver.encode(collections, forKey: "Collections")
        archiver.encode(lostItems, forKey: "LostItems")
        archiver.encode(cloudKitManager, forKey: "CloudKitManager")
        
        
        archiver.finishEncoding()
        data.write(toFile: dataFilePath(), atomically: true)
    }
    
//    func loadData() {
//        let path = dataFilePath()
//        if FileManager.default().fileExists(atPath: path) {
//            if let data = try? Data(contentsOf: URL(fileURLWithPath: path)) {
//                let unarchiver = NSKeyedUnarchiver(forReadingWith: data)
//                if let unarchivedCollections = unarchiver.decodeObject(forKey: "Collections") as? [CollectionModel] {
//                    
//                    //print("Found Collections")
//                    collections = unarchivedCollections
//                    
//                } else {
//                    
//                    print("Didn't find Collections")
//                    collections = [CollectionModel]()
//                }
//                
//                if let decodedCloudKitManager = unarchiver.decodeObject(forKey: "CloudKitManager") as? CloudKitManager {
//                    
//                    cloudKitManager = decodedCloudKitManager
//                    
//                } else {
//                    
//                    cloudKitManager = CloudKitManager()
//                }
//                
//                unarchiver.finishDecoding()
//            }
//        } else {
//            
//            print("No file path")
//            collections = [CollectionModel]()
//            cloudKitManager = CloudKitManager()
//            cloudKitManager.fetchAllFromDatabase(false)
//            
////            var temp = preMadeCollectionsArray
////            
////            while collections.count < preMadeCollectionsArray.count {
////                
////                let random = Int(arc4random_uniform(UInt32(temp.count - 1)))
////                
////                collections.append(temp[random])
////                temp.removeAtIndex(random)
////                
////                
////            }
//        }
//    }
    
    func dataFilePath() -> String {
        return documentsDirectory() + "/ProjectOrder.plist"
    }
    
    func documentsDirectory() -> String {
        let paths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true) as [String]
        return paths[0]
    }
    
    func deleteCollectionFromCloudKit(recordID: CKRecordID) {
        print("Here 1")
        cloudKitManager.deleteFromCloudKit(recordID)
    }
    
    func deleteItemFromCloudKit(recordID: CKRecordID) {
        print("Here 2")
        cloudKitManager.deleteFromCloudKit(recordID)
    }
    
    func saveCollectionToCloudKit(collection: CollectionModel) {
        print("Here 3")
        cloudKitManager.saveCollectionToCloudKit(collection)
    }
    
    func editCollectionToCloudKit(collection: CollectionModel) {
        print("Here 4")
        cloudKitManager.editCollectionInCloudKit(collection)
    }
}

extension DataManager: CloudKitManagerDelegate {
    
    // MARK: Collections
    
    func newCloudCollection(_ collection: CollectionModel) {
        
        collections.append(collection)
        
        let lostItemsCopy = lostItems
        lostItems.removeAll()
        
        for item in lostItemsCopy {
            
            newCloudItemFromCollectionReference(item, reference: item.collectionReference)
        }
        
        self.delegate?.newCollection()
    }
    
    func deleteCollectionWithReference(_ reference: String) {
        
        for (index, collection) in collections.enumerated() {
            
            if collection.record.recordID.recordName == reference {
                
                print(collection.record.recordID.recordName)

                collections.remove(at: index)
                self.delegate?.deleteLocalCollection(collection)
            }
        }
    }
    
    func updateCollectionWithReference(_ updatedCollection: CollectionModel, reference: String) {
        
        for (index, collection) in collections.enumerated() {
            
            if collection.record.recordID.recordName == reference {
                
                print(collection.record.recordID.recordName)

                collections[index].name = updatedCollection.name
                collections[index].descriptionString = updatedCollection.descriptionString

                self.delegate?.updateLocalCollection(collections[index])
            }
        }
    }
    
    func cloudCollections(_ cloudCollections: [CollectionModel]) {
        
        for cloudCollection in cloudCollections {
            
            var alreadyExists = false
            
            for collection in collections {
                
                if cloudCollection.record.recordID.recordName == collection.record.recordID.recordName {
                    
                    alreadyExists = true
                }
            }
            
            if alreadyExists == false {
                
                collections.append(cloudCollection)
                self.delegate?.newCollection()
            }
        }
    }
    
    func cloudItemsWithCollectionRecordNames(_ itemsWithCollectionRecordNames: [(ItemModel, String)]) {
        
        for cloudItem in itemsWithCollectionRecordNames {
            
            for collection in collections {
                
                if collection.record.recordID.recordName == cloudItem.1 {
                    
                    print("We've matched the collection")
                    
                    var alreadyExists = false
                    
                    for item in collection.items {
                        
                        if cloudItem.0.record.recordID.recordName == item.record.recordID.recordName {
                            
                            print("We've matched the item")
                            alreadyExists = true
                        }
                    }
                    
                    if alreadyExists == false {
                        
                        newCloudItemFromCollectionReference(cloudItem.0, reference: cloudItem.1)
                    }
                }
            }
        }
    }
    
    //MARK: Items
    
    func newCloudItemFromCollectionReference(_ item: ItemModel, reference: String) {
        
        var collectionExists = false

        for collection in collections {
            
            if collection.record.recordID.recordName == reference {
                
                print(collection.record.recordID.recordName)
                
                collectionExists = true
                collection.items.insert(item, at: 0)
                self.delegate?.newItem(reference)
            }
        }
        
        if collectionExists == false {
            
            print("We never found it")
            item.collectionReference = reference
            lostItems.append(item)
        }
    }
    
    func deleteItemWithReference(_ reference: String) {
        
        for collection in collections {
            
            for (index, item) in collection.items.enumerated() {
                
                if item.record.recordID.recordName == reference {
                    
                    print(item.record.recordID.recordName)
                    collection.items.remove(at: index)
                    self.delegate?.deleteLocalItemFromCollection(collection)
                }
            }
        }
    }
    
    func updateItemWithReference(_ updatedItem: ItemModel, reference: String) {
        
        for collection in collections {
            
            for (index, item) in collection.items.enumerated() {
                
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
