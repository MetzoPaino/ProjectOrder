//
//  AppDelegate.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let dataManager = DataManager()

    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        let splitViewController =  window!.rootViewController as! UISplitViewController
        
        if splitViewController.isKindOfClass(UISplitViewController) {
            
            splitViewController.delegate = self
            let navigationController = splitViewController.viewControllers[0] as! UINavigationController
            let masterController = navigationController.topViewController as! CollectionsTableViewController
            masterController.dataManager = dataManager
            
            if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
                splitViewController.preferredDisplayMode = .AllVisible
                
                if splitViewController.viewControllers.count > 1 && dataManager.collections.count > 0 {
                    
                    let detailNavigationController = splitViewController.viewControllers[1] as! UINavigationController
                    let detailController = detailNavigationController.topViewController as! CollectionTableViewController
                    detailController.collection = dataManager.collections[0]
                }
            }
        }
        
//
//
//        

        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        saveData()
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        saveData()
    }

    func saveData() {
        dataManager.saveData()
    }
}

extension AppDelegate: UISplitViewControllerDelegate {
    func splitViewController(splitViewController: UISplitViewController, collapseSecondaryViewController secondaryViewController:UIViewController, ontoPrimaryViewController primaryViewController:UIViewController) -> Bool {
        
        print("collapseSecondaryViewController")

        if window!.rootViewController!.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.Compact {
            
            return true
        }
        
        
        if let secondaryNavController = secondaryViewController as? UINavigationController, detailController = secondaryNavController.topViewController as? CollectionTableViewController {
            
            detailController.collection = dataManager.collections[0]
        }
        
//        if let secondaryAsNavController = secondaryViewController as? UINavigationController, topAsDetailController = secondaryAsNavController.topViewController as? SessionViewController where topAsDetailController.session == nil {
//            return true
//        }
        return false
    }
    
    func splitViewController(splitViewController: UISplitViewController, showDetailViewController vc: UIViewController, sender: AnyObject?) -> Bool {
        print("showDetailViewController")
        return false
    }
    
    func splitViewController(splitViewController: UISplitViewController, showViewController vc: UIViewController, sender: AnyObject?) -> Bool {
        print("showMasterViewController")
        return true
    }
    
//    func splitViewController(svc: UISplitViewController, willShowViewController aViewController: UIViewController, invalidatingBarButtonItem barButtonItem: UIBarButtonItem) {
//        print("willShowViewController invalidatingBarButtonItem")
//
//    }
//    
//    func splitViewController(splitViewController: UISplitViewController, separateSecondaryViewControllerFromPrimaryViewController primaryViewController: UIViewController) -> UIViewController? {
//        print("separateSecondaryViewControllerFromPrimaryViewController")
//return primaryViewController
//    }
}
