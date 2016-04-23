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
}

class CloudKitManager {
    
    weak var delegate: CloudKitManagerDelegate?

    let database = CKContainer.defaultContainer().publicCloudDatabase
    
    var subscribed = false
    
    func saveCollectionToCloudKit(collection: CollectionModel) {
        
        let record = CKRecord(recordType: "Collection", recordID: collection.record.recordID)
        record.setObject(collection.name, forKey: "Name")
        record.setObject(collection.descriptionString, forKey: "Description")
        
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

            self.database.saveRecord(fetchedCollection) { savedRecord, savedError in
                print(error)
                
                if error == nil {
                    
                    self.saveItemsToCloudKit(collection)
                }
            }
        }
    }
    
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
                
                let collection = CollectionModel (name: name, description: description, dateCreated: NSDate())
                self.delegate?.newCloudCollection(collection)
            }
        }
    }
    
    func deleteLocalCollection(recordID: CKRecordID) {
        
    }
    
    func updateLocalCollection(recordID:CKRecordID) {
        
    }
    
    private func saveItemsToCloudKit(collection: CollectionModel) {
        
        var recordsArray = [CKRecord]()
        
        for item in collection.items {
            
            let record = CKRecord(recordType: "Item", recordID: item.record.recordID)
            record.setObject(item.text, forKey: "Name")
            record.setObject(item.sorted, forKey: "Sorted")
            
            let reference = CKReference(record: collection.record, action: .DeleteSelf)
            record.setObject(reference, forKey: "Reference")
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
    
    func deleteFromCloudKit(recordID: CKRecordID) {
        
        database.deleteRecordWithID(recordID) {
            (record, error) in
            
            print(error)
        }
    }
    
    func subscribe() {
        
        if subscribed {
            print("Already subscribed")
            return
        }
        
        let predicate = NSPredicate(value: true)
            
        let options: CKSubscriptionOptions = [.FiresOnRecordDeletion, .FiresOnRecordUpdate, .FiresOnRecordCreation]
        
        let subscription = CKSubscription(recordType: "Collection", predicate: predicate, options: options)
        
        let notification = CKNotificationInfo()
        notification.alertBody = "There's a new whistle in the genre."
        subscription.notificationInfo = notification
        
        database.saveSubscription(subscription) { (subscription, error) in
            if error != nil {
                print(error!.localizedDescription)
                
                // Error code 15 means already subscribed
                
                if error?.code == 15 {
                    self.subscribed = true
                }
                
            } else {
                
                print("Subscribed")
                self.subscribed = true
            }
        }
    }
    
    func handleNotification(note: CKQueryNotification) {
        let recordID = note.recordID
        switch note.queryNotificationReason {
        case .RecordDeleted:
            print("Deleted")

            
        case .RecordCreated:
            print("Created")
            addCollectionFromCloudKit(recordID!)
            
        case .RecordUpdated:
            print("Updated")

//            fetchAndUpdateOrAdd(note.recordID)
        }
        markNotificationAsRead([note.notificationID!])
    }
    
    func getOutstandingNotifications() {
        let op = CKFetchNotificationChangesOperation( previousServerChangeToken: nil)
        
        op.notificationChangedBlock = { notification in
            if let ckNotification = notification as?
                CKQueryNotification {
                self.handleNotification(ckNotification) }
        }
        op.fetchNotificationChangesCompletionBlock = {
            serverChangeToken, error in // 3
            if error != nil {
                print("error fetching notifications \(error)") }
        }
        
        CKContainer.defaultContainer().addOperation(op) }
    
    func markNotificationAsRead(notes:[CKNotificationID]) {
        let markOp = CKMarkNotificationsReadOperation(notificationIDsToMarkRead: notes)
        CKContainer.defaultContainer().addOperation(markOp)
    }
}