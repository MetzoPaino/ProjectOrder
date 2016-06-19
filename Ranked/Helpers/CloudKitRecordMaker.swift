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
        let sorted = record["Sorted"] as! Bool
        let dateCreated = record["DateCreated"] as! Date
        
        let item = ItemModel(string: name, dateCreated: dateCreated)
        item.record = record
        
        if let score = record["Score"] as? Int {
            
            item.score = score
        }
        
        if let asset = record["Image"] as? CKAsset,
            data = try? Data(contentsOf: asset.fileURL),
            image = UIImage(data: data) {
            item.image = image
        }
        
        item.sorted = sorted
        
        return (item, collection.recordID.recordName)
    }
}


