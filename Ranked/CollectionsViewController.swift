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
    var showingGetStartedView = false
    
    typealias AssociatedObject = DataManager
    var dataManager: DataManager!
    
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
        
        NotificationCenter.default.removeObserver(self)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.view.backgroundColor = UIColor.white
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor.white

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

        let imageView = UIImageView(image: UIImage(named: "PlusButton" )?.withRenderingMode(.alwaysTemplate))
        imageView.tintColor = .blue
        
        addButton.setImage(imageView.image, for: .highlighted)

        addButton.tintColor = .white
        
        let highlightedImage = UIImage(named: "PlusButton" )?.withRenderingMode(.alwaysTemplate).imageWithColor(color: .primaryColor())
        addButton.setImage(highlightedImage!, for: UIControlState.highlighted)

        addButton.layer.shadowColor = UIColor.black.cgColor
        addButton.layer.shadowOpacity = 0.25
        addButton.layer.shadowRadius = 2
        addButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        addButton.layer.masksToBounds = false
    }
    
    func styleTableView() {
        
        tableView.delegate = self
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        //tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = .backgroundColor()
        tableView.backgroundColor = .backgroundColor()
        tableView.backgroundColor = .white
    }
    
    func toggleGetStarted() {
        
        if showGetStartedView {
            
            if showingGetStartedView == false {
                showingGetStartedView = true
                getStartedViewController.reset()
            }
            
            view.insertSubview(getStartedContainerView, belowSubview: addButton)
            
        } else {
            view.sendSubview(toBack: getStartedContainerView)
        }
    }
}

// MARK: - Navigation

private typealias Navigation = CollectionsViewController
extension Navigation {
    
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let controller = segue.destination as? ItemsViewController {
            
            if segue.identifier == "CreateCollection" {
                
                controller.inject(CollectionModel(name: "", description: "", dateCreated: Date()))
                controller.delegate = self
                controller.newCollection = true
                controller.inEditingMode = true

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
            
            getStartedViewController = segue.destination as! GetStartedViewController
            getStartedViewController.delegate = self
        }
        
        if segue.identifier == "PresentSettings" {
            
            let navCon = segue.destination as! UINavigationController
            let controller = navCon.viewControllers[0] as! SettingsViewController
            controller.delegate = self
            controller.collections = dataManager.collections
            controller.showCloudKit = dataManager.useCloudKit
        }
    }
}

// MARK: - TableView Protocols
private typealias TableViewDelegate = CollectionsViewController
extension TableViewDelegate: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CollectionTableViewCell
        cell.titleLabel.textColor = .white
        
        if cell.descriptionLabel != nil {
            cell.descriptionLabel.textColor = .white
        }

    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! CollectionTableViewCell
        cell.titleLabel.textColor = .headingColor()
        
        if cell.descriptionLabel != nil {
            cell.descriptionLabel.textColor = .subHeadingColor()
        }
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
                cell.titleLabel.textColor = .white
                //cell.layoutMargins = UIEdgeInsetsZero;
                
                if collection.items.count > 0 && (collection.items.first!.score != nil) {
                    
                    //collection.items = collection.items.sorted(by: { $0.score! > $1.score! })
                    cell.descriptionLabel.text = "1. " + collection.items.first!.text
                    cell.descriptionLabel.textColor = UIColor.subHeadingColor()
                    
                } else {
                    
                    // This is incase we've not downloaded every item inside yet, but we need a better solution
                    cell.descriptionLabel.textColor = .clear
                    cell.descriptionLabel.text = "Syncing"
                }
               
                if cell.isHighlighted {
                    cell.titleLabel.textColor = .white
                    cell.descriptionLabel.textColor = .white

                } else {
                    cell.titleLabel.textColor = .headingColor()
                    cell.descriptionLabel.textColor = .subHeadingColor()
                    cell.descriptionLabel.textColor = .primaryColor()
                }
                
                if let image = collection.image {
                    cell.summaryImageViewWidthConstraint.constant = 48
                    cell.summaryImageView.image = image
                    cell.summaryImageViewLeadingConstraint.constant = 16
                    cell.configureCell(withImage: true)
                    cell.layoutMargins = UIEdgeInsetsMake(0, 64, 0, 0);

                } else {
                    cell.summaryImageViewWidthConstraint.constant = 0
                    cell.summaryImageViewLeadingConstraint.constant = 8
                    cell.configureCell(withImage: false)
                    cell.layoutMargins = UIEdgeInsets()
                }
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCell(withIdentifier: "UnsortedCell", for: indexPath) as! CollectionTableViewCell
                cell.titleLabel.text = collection.name
                //cell.layoutMargins = UIEdgeInsetsZero
                //cell.layoutMargins = UIEdgeInsetsMake(0, 64, 0, 0);
                
                if cell.isHighlighted {
                    cell.titleLabel.textColor = .white

                } else {
                    cell.titleLabel.textColor = .headingColor()
                }
                
                if let image = collection.image {
                    cell.summaryImageViewWidthConstraint.constant = 48
                    cell.summaryImageViewLeadingConstraint.constant = 16

                    cell.summaryImageView.image = image
                    cell.configureCell(withImage: true)
                    cell.layoutMargins = UIEdgeInsetsMake(0, 64, 0, 0);
                } else {
                    cell.summaryImageViewWidthConstraint.constant = 0
                    cell.summaryImageViewLeadingConstraint.constant = 8
                    cell.configureCell(withImage: false)
                    cell.layoutMargins = UIEdgeInsets()

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
            self.dataManager.saveData()
        })
    }
    
    func deleteLocalCollection(_ collection: CollectionModel) {
        
        DispatchQueue.main.async(execute: {
            
            if self.presentedViewController is CustomNavigationController {
                
                self.navigationController?.dismiss(animated: true, completion: {
                    _ = self.navigationController?.popToRootViewController(animated: true)
                    self.tableView.reloadData()
                })
            } else {
                _ = self.navigationController?.popToRootViewController(animated: true)
                self.tableView.reloadData()
            }
            self.dataManager.saveData()
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
                
                _ = self.navigationController?.popToRootViewController(animated: true)
                self.tableView.reloadData()
            }
            
            if self.presentedViewController is CustomNavigationController {
                
                self.navigationController?.dismiss(animated: true, completion: {
                })
            }
            self.dataManager.saveData()
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
            self.dataManager.saveData()
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
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
            
            if self.presentedViewController is CustomNavigationController {
                
                self.navigationController?.dismiss(animated: true, completion: {
                })
            }
            
            self.tableView.reloadData()
            self.dataManager.saveData()
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
                _ = self.navigationController?.popToRootViewController(animated: true)
            }
            
            if self.presentedViewController is CustomNavigationController {
                
                self.navigationController?.dismiss(animated: true, completion: {
                })
            }
            
            for (index, oldItem) in collection.items.enumerated() {
                
                if oldItem.record.recordID.recordName == item.record.recordID.recordName {
                    
                    collection.items[index] = item
                }
            }
            
            if collection.items.count > 1 && collection.sorted == true {
                collection.sortCollection()
            }
            self.tableView.reloadData()
            self.dataManager.saveData()
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
        
        showGetStartedView = false
        showingGetStartedView = false
        toggleGetStarted()
        
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
        //dataManager.cloudKitManager.fetchAllFromDatabase()
        dataManager.cloudKitManager.performCloudSync(collections: dataManager.collections)
    }
}
