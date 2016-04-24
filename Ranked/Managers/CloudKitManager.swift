//
//  CloudKitManager.swift
//  Project Order
//
//  Created by William Robinson on 23/04/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation
import CloudKit

protocol CloudKitManagerDelegate: class {
    func newCloudCollection(collection:CollectionModel)
    func deleteCollectionWithReference(reference:String)
    func updateCollectionWithReference(updatedCollection: CollectionModel, reference:String)
    
    func newCloudItemFromCollectionReference(item:ItemModel, reference: String)
    func deleteItemWithReference(reference:String)
    func updateItemWithReference(updatedItem: ItemModel, reference:String)
}

class CloudKitManager {
    
    weak var delegate: CloudKitManagerDelegate?

    let database = CKContainer.defaultContainer().privateCloudDatabase
    
    var subscribedToCollections = false
    var subscribedToItems = false

    enum recordType {
        case collections
        case items
    }
    
    //MARK: - To Cloud
    
    //MARK: Collections
    
    func saveCollectionToCloudKit(collection: CollectionModel) {
        
        let record = CKRecord(recordType: "Collection", recordID: collection.record.recordID)
        record.setObject(collection.name, forKey: "Name")
        record.setObject(collection.descriptionString, forKey: "Description")
        record.setObject(collection.dateCreated, forKey: "DateCreated")
        
        print("Record ID = \(collection.record.recordID)")
        
        database.saveRecord(record) { savedRecord, error in
            print(error)
            
            if error == nil {
                
                self.saveItemsToCloudKit(collection)
            }
        }
    }
    
    func editCollectionInCloudKit(collection: CollectionModel) {
        
        print("Record ID = \(collection.record.recordID)")
        
        database.fetchRecordWithID(collection.record.recordID) { fetchedCollection, error in
            
            guard let fetchedCollection = fetchedCollection else {
                // handle errors here
                return
            }
            
            fetchedCollection["Name"] = collection.name
            fetchedCollection["Description"] = collection.descriptionString
            fetchedCollection["DateCreated"] = collection.dateCreated
            
            self.database.saveRecord(fetchedCollection) { savedRecord, savedError in
                print(error)
                
                if error == nil {
                    
                    self.saveItemsToCloudKit(collection)
                }
            }
        }
    }
    
    //MARK: Items
    
    private func saveItemsToCloudKit(collection: CollectionModel) {
        
        var recordsArray = [CKRecord]()
        
        for item in collection.items {
            
            let record = CKRecord(recordType: "Item", recordID: item.record.recordID)
            record.setObject(item.text, forKey: "Name")
            record.setObject(item.sorted, forKey: "Sorted")
            
            let reference = CKReference(record: collection.record, action: .DeleteSelf)
            record.setObject(reference, forKey: "Collection")
            recordsArray.append(record)
        }
        
        let saveRecordsOperation = CKModifyRecordsOperation()
        saveRecordsOperation.recordsToSave = recordsArray
        saveRecordsOperation.savePolicy = .IfServerRecordUnchanged
        saveRecordsOperation.perRecordCompletionBlock = {
            record, error in
            if (error != nil) {
                print("Failed to save \(record!.recordType): \(error!.localizedDescription)")
                
            } else {
                print("Saved \(record!.recordType)")
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
        self.database.addOperation(saveRecordsOperation)
    }
    
    //MARK: Generic
    
    func deleteFromCloudKit(recordID: CKRecordID) {
        
        database.deleteRecordWithID(recordID) {
            (record, error) in
            
            print(error)
        }
    }
    
    //MARK: - From Cloud
    
    //MARK: Collections
    
    func addCollectionFromCloudKit(recordID: CKRecordID) {
        
        database.fetchRecordWithID(recordID) { fetchedCollection, error in
            
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
                
                let dateCreated = fetchedCollection["DateCreated"] as! NSDate
                
                let collection = CollectionModel (name: name, description: description, dateCreated: dateCreated)
                self.delegate?.newCloudCollection(collection)
            }
        }
    }
    
    func deleteLocalCollection(recordID: CKRecordID) {
        self.delegate?.deleteCollectionWithReference(recordID.recordName)
    }
    
    func updateLocalCollection(recordID:CKRecordID) {
        
        database.fetchRecordWithID(recordID) { fetchedCollection, error in
            
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
                
                let dateCreated = fetchedCollection["DateCreated"] as! NSDate
                
                let collection = CollectionModel (name: name, description: description, dateCreated: dateCreated)
                self.delegate?.updateCollectionWithReference(collection, reference: recordID.recordName)
            }
        }
    }
    
    //MARK: Items
    
    func addItemFromCloudKit(recordID: CKRecordID) {
        
        database.fetchRecordWithID(recordID) { fetchedItem, error in
            
            guard let fetchedItem = fetchedItem else {
                // handle errors here
                
                print(error)
                return
            }
            
            let name = fetchedItem["Name"] as! String
            let collection = fetchedItem["Collection"] as! CKReference
            let sorted = fetchedItem["Sorted"] as! Bool
            
            let item = ItemModel(string: name)
            item.record = CKRecord(recordType: "Item", recordID: recordID)
            item.sorted = sorted
            self.delegate?.newCloudItemFromCollectionReference(item, reference: collection.recordID.recordName)
        }
    }
    
    func deleteLocalItem(recordID: CKRecordID) {
        self.delegate?.deleteItemWithReference(recordID.recordName)
    }
    
    func updateLocalItem(recordID: CKRecordID) {
        
        database.fetchRecordWithID(recordID) { fetchedItem, error in
            
            guard let fetchedItem = fetchedItem else {
                return
            }
            
            if ((fetchedItem["Name"] as? String) != nil) {
                
                let name = fetchedItem["Name"] as! String
                let sorted = fetchedItem["Sorted"] as! Bool
                
                let item = ItemModel(string: name)
                item.sorted = sorted
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
        
        let predicate = NSPredicate(value: true)
            
        let options: CKSubscriptionOptions = [.FiresOnRecordDeletion, .FiresOnRecordUpdate, .FiresOnRecordCreation]

        let subscription = CKSubscription(recordType: "Collection", predicate: predicate, options: options)
        
        
        let notification = CKNotificationInfo()
        notification.alertBody = "Collection"
        subscription.notificationInfo = notification
        
        database.saveSubscription(subscription) { (subscription, error) in
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
                
                self.database.saveSubscription(itemSubscription) { (itemSubscription, error) in
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
    
    func handleNotification(note: CKQueryNotification) {
        let recordID = note.recordID
        
        if note.alertBody == "Collection" {
            
            switch note.queryNotificationReason {
            case .RecordDeleted:
                print("Collection Deleted")
                deleteLocalCollection(recordID!)
                
            case .RecordCreated:
                print("Collection Created")
                addCollectionFromCloudKit(recordID!)
                
            case .RecordUpdated:
                print("Collection Updated")
                updateLocalCollection(recordID!)
            }
            
        } else if note.alertBody == "Item" {
            
            switch note.queryNotificationReason {
            case .RecordDeleted:
                print("Item Deleted")
                deleteLocalItem(recordID!)
                
            case .RecordCreated:
                print("Item Created")
                addItemFromCloudKit(recordID!)
                
            case .RecordUpdated:
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
        
        CKContainer.defaultContainer().addOperation(op) }
    
    func markNotificationAsRead(notes:[CKNotificationID]) {
        let markOp = CKMarkNotificationsReadOperation(notificationIDsToMarkRead: notes)
        CKContainer.defaultContainer().addOperation(markOp)
    }
}