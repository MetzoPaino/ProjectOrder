//
//  CloudKitRecordMaker.swift
//  Project Order
//
//  Created by William Robinson on 18/06/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

//import Foundation
import CloudKit
import UIKit

//MARK: - Create

extension CloudKitManager {
        
    func createItemFromRecordWithCollectionRecordName(record: CKRecord) -> (item: ItemModel, collectionRecordName: String) {
        
        let name = record["Name"] as! String
        let collection = record["Collection"] as! CKReference
        let dateCreated = record["DateCreated"] as! Date
        
        let item = ItemModel(string: name, dateCreated: dateCreated)
        item.record = record
        
        if let score = record["Score"] as? Int {
            
            item.score = score
        }
        
        if let asset = record["Image"] as? CKAsset,
            let data = try? Data(contentsOf: asset.fileURL),
            let image = UIImage(data: data) {
            item.image = image
        }
        
        return (item, collection.recordID.recordName)
    }
    
    func createRecordFromItemInCollection(item: ItemModel, collection: CollectionModel) -> (CKRecord) {
        
        let record = item.record
        record.setObject(item.text as CKRecordValue?, forKey: "Name")
        record.setObject(item.dateCreated as CKRecordValue?, forKey: "DateCreated")
        
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
        
        if let score = item.score {
            record.setObject(score as CKRecordValue?, forKey: "Score")
        }
        
        let reference = CKReference(record: collection.record, action: .deleteSelf)
        record.setObject(reference, forKey: "Collection")
        
        return record
    }
}


