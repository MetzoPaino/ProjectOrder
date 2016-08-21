//
//  AppDelegate.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import CloudKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let dataManager = DataManager()

    //let cloudKitManager = CloudKitManager()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        UserDefaults.standard.setValue(true, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
        
        if let controller = window!.rootViewController as? LaunchViewController {
            
            controller.inject(dataManager)
        }
        application.registerForRemoteNotifications()
        return true

        
    }
    
//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
//        
//        UserDefaults.standard.setValue(true, forKey: "_UIConstraintBasedLayoutLogUnsatisfiable")
//
//        if let controller = window!.rootViewController as? LaunchViewController {
//        
//            controller.inject(dataManager)
//        }
//        application.registerForRemoteNotifications()        
//        
////        if let navigationController = window!.rootViewController as? UINavigationController {
////            
////            let controller = navigationController.topViewController as! CollectionsViewController
////            controller.inject(dataManager)
////        }
//        
//        return true
//    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        saveData()
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        saveData()
    }
    
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        //print("Registered for Push notifications with token: \(deviceToken)")
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: NSError) {
        //print("Push subscription failed: \(error)")
    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [NSObject : AnyObject]) {
        //print("Got notification \(userInfo)")
        
//        if let pushInfo = userInfo as? [String: NSObject] {
//            let notification = CKQueryNotification(fromRemoteNotificationDictionary: pushInfo)
//            dataManager.cloudKitManager.handleNotification(notification)
//        }
    }

    func saveData() {
        dataManager.saveData()
    }
}
