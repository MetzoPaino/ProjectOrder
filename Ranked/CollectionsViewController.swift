//
//  CollectionsTableViewController.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import CloudKit

class CollectionsViewController: UIViewController, Injectable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addButtonHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var getStartedContainerView: UIView!
    var getStartedViewController: GetStartedViewController!
    
    var shadowImage: UIImage!
    var backgroundImage: UIImage!
    
    var showGetStartedView = false
    
    
    typealias AssociatedObject = DataManager
    private var dataManager: DataManager!
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()
        
        styleTableView()
        styleView()
                
        let logo = UIImage(named: "SortingAnimation_100")
        let imageView = UIImageView(image:logo)
        imageView.bounds = CGRect(x: 0, y: 0, width: 32, height: 32)
        imageView.contentMode = .scaleAspectFit
        self.navigationItem.titleView = imageView
    }
    
    override func viewWillDisappear(_ animated: Bool)  {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default().removeObserver(self)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.white()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor.white()
        navigationController?.navigationBar.tintColor = .primaryColor()
    }
    
    func inject(_ dataManager: AssociatedObject) {
        self.dataManager = dataManager
        self.dataManager.delegate = self
    }
    
    func assertDependencies() {
        assert(dataManager != nil)
    }

    func styleView() {
        
        addButton.backgroundColor = .primaryColor()
        addButton.layer.cornerRadius = self.addButtonHeightConstraint.constant / 2
        addButton.setImage(UIImage(named: "PlusButton" )?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        addButton.tintColor = .white()
        
        addButton.layer.shadowColor = UIColor.black().cgColor;
        addButton.layer.shadowOpacity = 0.25
        addButton.layer.shadowRadius = 2
        addButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        addButton.layer.masksToBounds = false
    }
    
    func styleTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = .backgroundColor()
        tableView.backgroundColor = .backgroundColor()
    }
    
    func toggleGetStarted() {
        
        if showGetStartedView {
            
            getStartedViewController.reset()
            view.insertSubview(getStartedContainerView, belowSubview: addButton)
            
        } else {
            view.sendSubview(toBack: getStartedContainerView)
        }
    }
}

// MARK: - Navigation
private typealias Navigation = CollectionsViewController
extension Navigation {
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let controller = segue.destinationViewController as? ItemsViewController {
            
            if segue.identifier == "CreateCollection" {
                
                controller.inject(CollectionModel(name: "", description: "", dateCreated: Date()))
                controller.delegate = self
                controller.newCollection = true
                
            } else if segue.identifier == "ShowCollection" {
                
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    
                    controller.inject(dataManager.collections[(selectedIndexPath as NSIndexPath).row])
                    controller.inEditingMode = false
                    controller.newCollection = false
                    controller.delegate = self
                    self.navigationController?.navigationBar.tintColor = .primaryColor()
                    
                }
            } else if segue.identifier == "ShowEditCollection" {
                
                if let row = sender as? Int {
                    
                    controller.inject(dataManager.collections[row])
                }
                controller.inEditingMode = true
                controller.newCollection = false
                controller.delegate = self
                self.navigationController?.navigationBar.tintColor = .primaryColor()
            }
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
        }
        
        if segue.identifier == "EmbedGetStarted" {
            
            getStartedViewController = segue.destinationViewController as! GetStartedViewController
            getStartedViewController.delegate = self
        }
        
        if segue.identifier == "PresentSettings" {
            
            let navCon = segue.destinationViewController as! UINavigationController
            let controller = navCon.viewControllers[0] as! SettingsViewController
            controller.delegate = self
            controller.collections = dataManager.collections
        }
    }
}

// MARK: - TableView Protocols
private typealias TableViewDelegate = CollectionsViewController
extension TableViewDelegate: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        //        performSegueWithIdentifier("ShowCollection", sender: collectionsArray[indexPath.row])
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if dataManager.collections[(indexPath as NSIndexPath).row].premade {
            
            let deleteAction = UITableViewRowAction(style: .default, title: "Delete") {
                (rowAction:UITableViewRowAction, indexPath:IndexPath) -> Void in
                
                // Delete, we shouldn't be initialising CloudKitManager every time
                //CloudKitManager().deleteFromCloudKit(self.dataManager.collections[(indexPath as NSIndexPath).row].record.recordID)
                
                self.dataManager.deleteCollectionFromCloudKit(recordID: self.dataManager.collections[(indexPath as NSIndexPath).row].record.recordID)
                
                self.dataManager.collections.remove(at: (indexPath as NSIndexPath).row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                
            }
            deleteAction.backgroundColor = UIColor.warningColor()
            
            return [deleteAction]
            
        } else {
          
            let editAction = UITableViewRowAction(style: .normal, title: "Edit") {
                (rowAction:UITableViewRowAction, indexPath:IndexPath) -> Void in
                
                self.performSegue(withIdentifier: "ShowEditCollection", sender: (indexPath as NSIndexPath).row)
                
            }
            editAction.backgroundColor = UIColor.secondaryColor()
            
            
            let deleteAction = UITableViewRowAction(style: .default, title: "Delete") {
                (rowAction:UITableViewRowAction, indexPath:IndexPath) -> Void in
                
                // Delete, we shouldn't be initialising CloudKitManager every time
                //CloudKitManager().deleteFromCloudKit(self.dataManager.collections[(indexPath as NSIndexPath).row].record.recordID)
                
                self.dataManager.deleteCollectionFromCloudKit(recordID: self.dataManager.collections[(indexPath as NSIndexPath).row].record.recordID)
                
                self.dataManager.collections.remove(at: (indexPath as NSIndexPath).row)
                tableView.beginUpdates()
                tableView.deleteRows(at: [indexPath], with: .automatic)
                tableView.endUpdates()
                
            }
            deleteAction.backgroundColor = UIColor.warningColor()
            
            return [deleteAction, editAction]
        }
    }
}

private typealias TableViewDataSource = CollectionsViewController
extension TableViewDataSource: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if dataManager.collections.count == 0 {
            
            showGetStartedView = true
            toggleGetStarted()
            
        } else {
            
            showGetStartedView = false
            toggleGetStarted()
        }
        return dataManager.collections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if dataManager.collections.count > 0 {
            
            let collection = dataManager.collections[(indexPath as NSIndexPath).row];
            
            if collection.sorted {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! CollectionTableViewCell
                cell.titleLabel.text = collection.name
                cell.titleLabel.textColor = UIColor.headingColor()
                cell.descriptionLabel.textColor = UIColor.subHeadingColor()
                cell.layoutMargins = UIEdgeInsetsZero;
                collection.items = collection.items.sorted(isOrderedBefore: { $0.score > $1.score })
                cell.descriptionLabel.text = "1. " + collection.items.first!.text
                
                if let image = collection.image {
                    cell.summaryImageViewWidthConstraint.constant = 48
                    cell.summaryImageView.image = image
                    cell.summaryImageViewLeadingConstraint.constant = 16
                    cell.configureCell()
                } else {
                    cell.summaryImageViewWidthConstraint.constant = 0
                    cell.summaryImageViewLeadingConstraint.constant = 8
                }
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "UnsortedCell", for: indexPath) as! CollectionTableViewCell
                cell.titleLabel.text = collection.name
                cell.titleLabel.textColor = UIColor.headingColor()
                cell.layoutMargins = UIEdgeInsetsZero
                
                if let image = collection.image {
                    cell.summaryImageViewWidthConstraint.constant = 48
                    cell.summaryImageViewLeadingConstraint.constant = 16

                    cell.summaryImageView.image = image
                    cell.configureCell()
                } else {
                    cell.summaryImageViewWidthConstraint.constant = 0
                    cell.summaryImageViewLeadingConstraint.constant = 8
                }
                
                return cell
            }

            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "NoContentCell", for: indexPath)
            return cell
        }        
    }
}

// MARK: - ItemsViewController Protocols
private typealias ItemsDelegate = CollectionsViewController
extension ItemsDelegate: ItemsViewControllerDelegate {
    
    func sortingFinished(collection: CollectionModel) {
        
        dataManager.editCollectionToCloudKit(collection: collection)
        tableView.reloadData()
    }
    
    func collectionUpdated(_ collection: CollectionModel, new: Bool) {
        
        // How does this work when not new?
        if new {
            dataManager.collections.insert(collection, at: 0)
            //CloudKitManager().saveCollectionToCloudKit(collection)
            dataManager.saveCollectionToCloudKit(collection: collection)
        } else {
            
            //CloudKitManager().editCollectionInCloudKit(collection)
            dataManager.editCollectionToCloudKit(collection: collection)
        }
        
        tableView.reloadData()
    }
    
    func deleteItemFromCloudKit(recordID: CKRecordID) {
        dataManager.deleteItemFromCloudKit(recordID: recordID)
    }
}

// MARK: - DataManager Delegates
extension CollectionsViewController: DataManagerDelegate {

    // MARK: Collections
    
    func newCollection() {
        
        DispatchQueue.main.async(execute: {
            self.tableView.reloadData()
        })
    }
    
    func deleteLocalCollection(_ collection: CollectionModel) {
        
        DispatchQueue.main.async(execute: {
            
            if self.presentedViewController is CustomNavigationController {
                
                self.navigationController?.dismiss(animated: true, completion: {
                    self.navigationController?.popToRootViewController(animated: true)
                    self.tableView.reloadData()
                })
            } else {
                self.navigationController?.popToRootViewController(animated: true)
                self.tableView.reloadData()
            }
        })
    }
    
    func updateLocalCollection(_ collection: CollectionModel) {
        
        DispatchQueue.main.async(execute: {
            
            if self.navigationController?.topViewController is ItemsViewController {
                
                let itemsViewController = self.navigationController?.topViewController as! ItemsViewController
                if itemsViewController.collection.record.recordID.recordName == collection.record.recordID.recordName {
                    
                    itemsViewController.collection = collection
                    itemsViewController.tableView.reloadData()
                }
            } else {
                
                self.navigationController?.popToRootViewController(animated: true)
                self.tableView.reloadData()
            }
            
            if self.presentedViewController is CustomNavigationController {
                
                self.navigationController?.dismiss(animated: true, completion: {
                })
            }
        })
    }
    
    // MARK: Items
    
    func newItem(_ reference: String) {
        
        DispatchQueue.main.async(execute: {
            
            if self.navigationController?.topViewController is ItemsViewController {
                
                let itemsViewController = self.navigationController?.topViewController as! ItemsViewController
                if itemsViewController.collection.record.recordID.recordName == reference {
                    
                    itemsViewController.tableView.reloadData()
                }
            }
        })
    }
    
    func deleteLocalItemFromCollection(_ collection: CollectionModel) {
        
        DispatchQueue.main.async(execute: {
            
            if self.navigationController?.topViewController is ItemsViewController {
                
                let itemsViewController = self.navigationController?.topViewController as! ItemsViewController
                if itemsViewController.collection.record.recordID.recordName == collection.record.recordID.recordName {
                    
                    itemsViewController.tableView.reloadData()
                }
            } else if self.navigationController?.topViewController is DescriptionViewController {
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            if self.presentedViewController is CustomNavigationController {
                
                self.navigationController?.dismiss(animated: true, completion: {
                })
            }
        })
    }
    
    func updateLocalItemInCollection(_ item: ItemModel, collection: CollectionModel) {
        
        DispatchQueue.main.async(execute: {
            
            if self.navigationController?.topViewController is ItemsViewController {
                
                let itemsViewController = self.navigationController?.topViewController as! ItemsViewController
                if itemsViewController.collection.record.recordID.recordName == collection.record.recordID.recordName {
                    
                    itemsViewController.tableView.reloadData()
                }
            } else if self.navigationController?.topViewController is DescriptionViewController {
                self.navigationController?.popToRootViewController(animated: true)
            }
            
            if self.presentedViewController is CustomNavigationController {
                
                self.navigationController?.dismiss(animated: true, completion: {
                })
            }
        })
    }
}

extension CollectionsViewController: GetStartedViewControllerDelegate {
    
    func finishedPickingCollections(_ collections: [CollectionModel]) {
        
        dataManager.collections.append(contentsOf: collections)

        for collection in collections {
            //CloudKitManager().saveCollectionToCloudKit(collection)
            dataManager.saveCollectionToCloudKit(collection: collection)

        }
        
        let lastRow = tableView.numberOfRows(inSection: 0)

        var indexPaths = [IndexPath]()
        
        for (index, _) in collections.enumerated() {
            
            let indexPath = IndexPath(row: lastRow + index, section: 0)
            indexPaths.append(indexPath)
        }
        tableView.insertRows(at: indexPaths, with: .top)
    }
}

//MARK: SettingsViewControllerDelegate

extension CollectionsViewController: SettingsViewControllerDelegate {
    
    func appendPreMadeCollections(_ collections: [CollectionModel]) {
        
        dataManager.collections.append(contentsOf: collections)
        
        for collection in collections {
            //CloudKitManager().saveCollectionToCloudKit(collection)
            dataManager.saveCollectionToCloudKit(collection: collection)
        }
    }
    
    func performFulliCloudSync() {
        dataManager.cloudKitManager.fetchAllFromDatabase(true)
    }
}
