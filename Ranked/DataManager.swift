//
//  DataManager.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import Foundation

class DataManager {
    
    var collections = [CollectionModel]()
    
    init() {
        
        loadData()
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
            
            collections.append(createDavidBowieCollection())
            collections.append(createStarWarsCollection())
            collections.append(createHarryPotterCollection())
            collections.append(createFinalFantasyCollection())
            collections.append(createInternetBrowserCollection())
            collections.append(createDesktopOSCollection())
            collections.append(createMobileOSCollection())
            collections.append(createDoctorWhoCollection())
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