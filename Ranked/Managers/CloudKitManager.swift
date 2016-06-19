//
//  CloudKitManager.swift
//  Project Order
//
//  Created by William Robinson on 23/04/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation
import CloudKit
import UIKit

protocol CloudKitManagerDelegate: class {
    func newCloudCollection(_ collection:CollectionModel)
    func deleteCollectionWithReference(_ reference:String)
    func updateCollectionWithReference(_ updatedCollection: CollectionModel, reference:String)
    
    func newCloudItemFromCollectionReference(_ item:ItemModel, reference: String)
    func deleteItemWithReference(_ reference:String)
    func updateItemWithReference(_ updatedItem: ItemModel, reference:String)
    
    func cloudCollections(_ cloudCollections: [CollectionModel])
    func cloudItemsWithCollectionRecordNames(_ itemsWithCollectionRecordNames: [(ItemModel, String)])
}

class CloudKitManager: NSObject, NSCoding {
    
    weak var delegate: CloudKitManagerDelegate?

    private let publicDatabase = CKContainer.default().publicCloudDatabase
    private let privateDatabase = CKContainer.default().privateCloudDatabase

    var subscribedToCollections = false
    var subscribedToItems = false
    
    var saveCollectionToCloudKitCounter = 0
    var editCollectionInCloudKitCounter = 0
    var saveItemsToCloudKitCounter = 0
    var deleteFromCloudKitCounter = 0
    
    let retryLimit = 10

    enum recordType {
        case collections
        case items
    }
    
    override init() {
        
        super.init()
        // Init CloudKitManager
       // subscribeToCollectionUpdates()
    }
    
    required init?(coder aDecoder: NSCoder) {

        super.init()

        if let decodedSubscription = aDecoder.decodeObject(forKey: "SubscribedToCollections") as? Bool {
            
            subscribedToCollections = decodedSubscription
            
        }
        
        
        subscribeToCollectionUpdates()
    }
    
    func encode(with aCoder: NSCoder) {
        
        print(subscribedToCollections)
        aCoder.encode(true, forKey: "SubscribedToCollections")
    }
    
    //MARK: - To Cloud
    
    //MARK: Collections
    
    func saveCollectionToCloudKit(_ collection: CollectionModel) {
        
        let record = CKRecord(recordType: "Collection", recordID: collection.record.recordID)
        record.setObject(collection.name, forKey: "Name")
        record.setObject(collection.descriptionString, forKey: "Description")
        record.setObject(collection.dateCreated, forKey: "DateCreated")
        
        if let image = collection.image {
            
            do {
                
                let url = try! URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(collection.name.trim())
                let data = UIImagePNGRepresentation(image)!
                
                try data.write(to: url, options: NSData.WritingOptions.atomicWrite)
                let asset = CKAsset(fileURL: url)
                record.setObject(asset, forKey: "Image")
            }
            catch {
                print("Error writing data", error)
            }
        }
    
        privateDatabase.save(record) { savedRecord, error in
            print(error)
            
            if error == nil {
                
                self.saveCollectionToCloudKitCounter = 0
                self.saveItemsToCloudKit(collection)
                
            } else {
                
                self.saveCollectionToCloudKitCounter = self.saveCollectionToCloudKitCounter + 1
                
                if self.saveCollectionToCloudKitCounter >= self.retryLimit {
                    return
                }
                
                if self.isRetryableCKError(error) {
                    let userInfo : NSDictionary = error!.userInfo
                    
                    if let retryAfter = userInfo[CKErrorRetryAfterKey] as? NSNumber {
                        
                        let delay = retryAfter.doubleValue * Double(NSEC_PER_SEC)
                        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                        
                        DispatchQueue.main.after(when: time) {
                            
                            self.saveCollectionToCloudKit(collection)
                        }
                        return
                    }
                }
            }
        }
    }
    
    func editCollectionInCloudKit(_ collection: CollectionModel) {
        
        privateDatabase.fetch(withRecordID: collection.record.recordID) { fetchedCollection, error in
            
            guard let fetchedCollection = fetchedCollection else {
                // handle errors here
                return
            }
            
            fetchedCollection["Name"] = collection.name
            fetchedCollection["Description"] = collection.descriptionString
            fetchedCollection["DateCreated"] = collection.dateCreated
            
            if let image = collection.image {
                
                do {
                    
                    let url = NSURL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(collection.name.trim())
                    let data = UIImagePNGRepresentation(image)!
                    
                    try data.write(to: url!, options: NSData.WritingOptions.atomicWrite)
                    let asset = CKAsset(fileURL: url!)
                    fetchedCollection.setObject(asset, forKey: "Image")
                }
                catch {
                    print("Error writing data", error)
                }
            }

            self.privateDatabase.save(fetchedCollection) { savedRecord, savedError in
                print(error)
                
                if error == nil {
                    
                    self.saveItemsToCloudKit(collection)
                    
                } else {
                    
                    self.editCollectionInCloudKitCounter = self.editCollectionInCloudKitCounter + 1
                    
                    if self.editCollectionInCloudKitCounter >= self.retryLimit {
                        return
                    }
                    
                    if self.isRetryableCKError(error) {
                        let userInfo : NSDictionary = error!.userInfo
                        
                        if let retryAfter = userInfo[CKErrorRetryAfterKey] as? NSNumber {
                            
                            let delay = retryAfter.doubleValue * Double(NSEC_PER_SEC)
                            
                            DispatchQueue.main.after(when: .now() + delay, execute: {
                                
                                self.editCollectionInCloudKit(collection)
                            })
                            return
                        }
                    }
                }
            }
        }
    }
    
    //MARK: Items
    
    private func saveItemsToCloudKit(_ collection: CollectionModel) {
        
        var recordsArray = [CKRecord]()
        
        for item in collection.items {
            
            let record = CKRecord(recordType: "Item", recordID: item.record.recordID)
            record.setObject(item.text, forKey: "Name")
            record.setObject(item.sorted, forKey: "Sorted")
            record.setObject(item.dateCreated, forKey: "DateCreated")
            
            if let image = item.image {
                
                do {
                    
                    let url = try! URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(collection.name.trim() + item.text.trim())
                    let data = UIImagePNGRepresentation(image)!
                    
                    try data.write(to: url, options: NSData.WritingOptions.atomicWrite)
                    let asset = CKAsset(fileURL: url)
                    record.setObject(asset, forKey: "Image")
                }
                catch {
                    print("Error writing data", error)
                }
            }
            
            let reference = CKReference(record: collection.record, action: .deleteSelf)
            record.setObject(reference, forKey: "Collection")
            recordsArray.append(record)
        }
        
        let saveRecordsOperation = CKModifyRecordsOperation()
        saveRecordsOperation.recordsToSave = recordsArray
        saveRecordsOperation.savePolicy = .ifServerRecordUnchanged
        saveRecordsOperation.perRecordCompletionBlock = {
            record, error in
            
            if (error != nil) {

                self.saveItemsToCloudKitCounter = self.saveItemsToCloudKitCounter + 1
                
                if self.saveItemsToCloudKitCounter >= self.retryLimit {
                    return
                }
                
                if self.isRetryableCKError(error) {
                    let userInfo : NSDictionary = error!.userInfo
                    
                    if let retryAfter = userInfo[CKErrorRetryAfterKey] as? NSNumber {
                        
                        let delay = retryAfter.doubleValue * Double(NSEC_PER_SEC)
                        let time = DispatchTime.now() + Double(Int64(delay)) / Double(NSEC_PER_SEC)
                        
                        DispatchQueue.main.after(when: time) {
                            
                            self.saveItemsToCloudKit(collection)
                        }
                        return
                    }
                }
            }
        }
        
        saveRecordsOperation.modifyRecordsCompletionBlock = {
            
            savedRecord, deletedRecordIds, error in
            if (error != nil) {
                print("Failed to save Themes & Motifs: \(error!.localizedDescription)")
            } else {
                print("Saved Themes & Motifs")
            }
        }
        self.privateDatabase.add(saveRecordsOperation)
    }
    
    //MARK: Generic
    
    func deleteFromCloudKit(_ recordID: CKRecordID) {
        
        privateDatabase.delete(withRecordID: recordID) {
            (record, error) in
            
            if error != nil {
                
                self.deleteFromCloudKitCounter = self.deleteFromCloudKitCounter + 1
                
                if self.deleteFromCloudKitCounter >= self.retryLimit {
                    return
                }
                
                if self.isRetryableCKError(error) {
                    let userInfo : NSDictionary = error!.userInfo
                    
                    if let retryAfter = userInfo[CKErrorRetryAfterKey] as? NSNumber {
                        
                        let delay = retryAfter.doubleValue * Double(NSEC_PER_SEC)
                        
                        DispatchQueue.main.after(when: .now() + delay, execute: {
                            
                            self.deleteFromCloudKit(recordID)
                        })
                        
                        return
                    }
                }
            }
        }
    }
    
    //MARK: - From Cloud
    
    func fetchAllFromDatabase(_ usePublicDatabase: Bool) {
        
        let predicate = Predicate(value: true)
        let query = CKQuery(recordType: "Collection", predicate: predicate)
        
        var database: CKDatabase
        
        if usePublicDatabase {
            
            database = publicDatabase
        } else {
            database = privateDatabase
        }
        
        database.perform(query, inZoneWith: nil) { (records, error) in
            
            if let records = records {
                
                var cloudCollections = [CollectionModel]()
                
                for record in records {
                    
                    if ((record["Name"] as? String) != nil) {
                        
                        let name = record["Name"] as! String
                        
                        var dateCreated = Date()
                        
                        if let date = record["DateCreated"] as? Date {
                            dateCreated = date
                        }
                        
                        var description = ""
                        if ((record["Description"] as? String) != nil) {
                            
                            description = record["Description"] as! String
                        }
                        
                        let collection = CollectionModel (name: name, description: description, dateCreated: dateCreated)
                        
                        if let asset = record["Image"] as? CKAsset,
                            data = try? Data(contentsOf: asset.fileURL),
                            image = UIImage(data: data) {
                            collection.image = image
                        }
                        
                        collection.record = record
                        
                        cloudCollections.append(collection)
                    }
                }
                
                if cloudCollections.count > 0 {
                    
                    self.delegate?.cloudCollections(cloudCollections)
                }
                
                let itemQuery = CKQuery(recordType: "Item", predicate: predicate)
                
                var cloudItemsWithCollectionRecordNames = [(ItemModel, String)]()
                
                database.perform(itemQuery, inZoneWith: nil) { (records, error) in
                    
                    if let records = records {
                        
                        for record in records {
                            
                            cloudItemsWithCollectionRecordNames.append(self.createItemFromRecordWithCollectionRecordName(record: record))
                        }
                        
                        if cloudItemsWithCollectionRecordNames.count > 0 {
                            
                           self.delegate?.cloudItemsWithCollectionRecordNames(cloudItemsWithCollectionRecordNames)
                        }
                    }
                }
                
                // Then need to get all items, dump the dupes
            }
        }
    }
    
    //MARK: Collections
    
    func addCollectionFromCloudKit(_ recordID: CKRecordID) {
        
        privateDatabase.fetch(withRecordID: recordID) { fetchedCollection, error in
            
            guard let fetchedCollection = fetchedCollection else {
                // handle errors here
                
                print(error)
                return
            }
            
            if ((fetchedCollection["Name"] as? String) != nil) {
                
                let name = fetchedCollection["Name"] as! String
                var description = ""
                
                if ((fetchedCollection["Description"] as? String) != nil) {
                    
                    description = fetchedCollection["Description"] as! String
                }
                
                let dateCreated = fetchedCollection["DateCreated"] as! Date
                
                let collection = CollectionModel (name: name, description: description, dateCreated: dateCreated)
                
                if let asset = fetchedCollection["Image"] as? CKAsset,
                    data = NSData.init(contentsOf: asset.fileURL),
                    image = UIImage(data: data as Data) {
                    collection.image = image
                }
                
                collection.record = fetchedCollection
                
                self.delegate?.newCloudCollection(collection)
            }
        }
    }
    
    func deleteLocalCollection(_ recordID: CKRecordID) {
        self.delegate?.deleteCollectionWithReference(recordID.recordName)
    }
    
    func updateLocalCollection(_ recordID:CKRecordID) {
        
        privateDatabase.fetch(withRecordID: recordID) { fetchedCollection, error in
            
            guard let fetchedCollection = fetchedCollection else {
                // handle errors here
                return
            }
            
            if ((fetchedCollection["Name"] as? String) != nil) {
                
                let name = fetchedCollection["Name"] as! String
                var description = ""
                
                if ((fetchedCollection["Description"] as? String) != nil) {
                    
                    description = fetchedCollection["Description"] as! String
                }
                
                let dateCreated = fetchedCollection["DateCreated"] as! Date
                
                let collection = CollectionModel (name: name, description: description, dateCreated: dateCreated)
                
                if let asset = fetchedCollection["Image"] as? CKAsset,
                    data = NSData.init(contentsOf: asset.fileURL),
                    image = UIImage(data: data as Data) {
                    collection.image = image
                }
                
                collection.record = fetchedCollection
                
                self.delegate?.updateCollectionWithReference(collection, reference: recordID.recordName)
            }
        }
    }
    
    //MARK: Items
    
    func addItemFromCloudKit(_ recordID: CKRecordID) {
        
        privateDatabase.fetch(withRecordID: recordID) { fetchedItem, error in
            
            guard let fetchedItem = fetchedItem else {
                // handle errors here
                
                print(error)
                return
            }
            
            let itemAndRecord = self.createItemFromRecordWithCollectionRecordName(record: fetchedItem)
            
            let item = itemAndRecord.item

            self.delegate?.newCloudItemFromCollectionReference(item, reference: itemAndRecord.collectionRecordName)
        }
    }
    
    func deleteLocalItem(_ recordID: CKRecordID) {
        self.delegate?.deleteItemWithReference(recordID.recordName)
    }
    
    func updateLocalItem(_ recordID: CKRecordID) {
        
        privateDatabase.fetch(withRecordID: recordID) { fetchedItem, error in
            
            guard let fetchedItem = fetchedItem else {
                return
            }
            
            
            
            if ((fetchedItem["Name"] as? String) != nil) {
                
                let name = fetchedItem["Name"] as! String
                let sorted = fetchedItem["Sorted"] as! Bool
                let dateCreated = fetchedItem["DateCreated"] as! Date
                
                let item = ItemModel(string: name, dateCreated: dateCreated)
                
                if let asset = fetchedItem["Image"] as? CKAsset,
                    data = NSData.init(contentsOf: asset.fileURL),
                    image = UIImage(data: data as Data) {
                    item.image = image
                }
                
                item.sorted = sorted
                item.record = fetchedItem
                
                self.delegate?.updateItemWithReference(item, reference: recordID.recordName)
            }
        }
    }
    
    //MARK: - Subscribe
    
    func subscribeToCollectionUpdates() {
        
        if subscribedToCollections {
            print("Already subscribed to collections")
            return
        }
        
        let predicate = Predicate(value: true)
            
        let options: CKSubscriptionOptions = [.firesOnRecordDeletion, .firesOnRecordUpdate, .firesOnRecordCreation]

        let subscription = CKSubscription(recordType: "Collection", predicate: predicate, options: options)
        
        
        let notification = CKNotificationInfo()
        notification.alertBody = "Collection"
        subscription.notificationInfo = notification
        
        privateDatabase.save(subscription) { (subscription, error) in
            if error != nil {
                print(error!.localizedDescription)
                
                // Error code 15 means already subscribed
                
                if error?.code == 15 {
                    
                    self.subscribedToCollections = true
                }
            } else {
                
                self.subscribedToCollections = true

                let itemSubscription = CKSubscription(recordType: "Item", predicate: predicate, options: options)
                
                let itemNotification = CKNotificationInfo()
                itemNotification.alertBody = "Item"
                itemSubscription.notificationInfo = itemNotification
                
                self.privateDatabase.save(itemSubscription) { (itemSubscription, error) in
                    if error != nil {
                        print(error!.localizedDescription)
                        
                        // Error code 15 means already subscribed
                        
                        if error?.code == 15 {
                            
                            self.subscribedToCollections = true
                        }
                    } else {
                        
                        self.subscribedToCollections = true
                    }
                }
            }
        }
    }
    
    //MARK: - Notifications
    
    func handleNotification(_ note: CKQueryNotification) {
        let recordID = note.recordID
        
        if note.alertBody == "Collection" {
            
            switch note.queryNotificationReason {
            case .recordDeleted:
                print("Collection Deleted")
                deleteLocalCollection(recordID!)
                
            case .recordCreated:
                print("Collection Created")
                addCollectionFromCloudKit(recordID!)
                
            case .recordUpdated:
                print("Collection Updated")
                updateLocalCollection(recordID!)
            }
            
        } else if note.alertBody == "Item" {
            
            switch note.queryNotificationReason {
            case .recordDeleted:
                print("Item Deleted")
                deleteLocalItem(recordID!)
                
            case .recordCreated:
                print("Item Created")
                addItemFromCloudKit(recordID!)
                
            case .recordUpdated:
                print("Item Updated")
                updateLocalItem(recordID!)
            }
        }
        markNotificationAsRead([note.notificationID!])
    }
    
    func getOutstandingNotifications() {
        let op = CKFetchNotificationChangesOperation( previousServerChangeToken: nil)
        
        op.notificationChangedBlock = { notification in
            if let ckNotification = notification as?
                CKQueryNotification {
                self.handleNotification(ckNotification)
            }
        }
        op.fetchNotificationChangesCompletionBlock = {
            serverChangeToken, error in
            if error != nil {
                print("error fetching notifications \(error)") }
        }
        
        CKContainer.default().add(op) }
    
    func markNotificationAsRead(_ notes:[CKNotificationID]) {
        let markOp = CKMarkNotificationsReadOperation(notificationIDsToMarkRead: notes)
        CKContainer.default().add(markOp)
    }
    
    func isRetryableCKError(_ error:NSError?) -> Bool {
        
        var isRetryable = false

        if let err = error {
            
            let errorCode: Int = err.code
            
            let isUnavailable = CKErrorCode.serviceUnavailable.rawValue
            let isRateLimited = CKErrorCode.requestRateLimited.rawValue
            
            if errorCode == isUnavailable || errorCode == isRateLimited {
                
                isRetryable = true
            }
        }
        return isRetryable
    }
    

}
