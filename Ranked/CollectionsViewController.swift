//
//  CollectionsTableViewController.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class CollectionsViewController: UIViewController, Injectable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addButtonHeightConstraint: NSLayoutConstraint!

    var shadowImage: UIImage!
    var backgroundImage: UIImage!
    
    var hasCollections = true
    
    typealias AssociatedObject = DataManager
    private var dataManager: DataManager!
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()
        styleTableView()
        styleView()
    }
    
    override func viewWillDisappear(animated: Bool)  {
        super.viewWillDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
        
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.translucent = true
        self.navigationController?.view.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewDidDisappear(animated: Bool) {
        super.viewDidDisappear(animated)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.translucent = false
        navigationController?.view.backgroundColor = UIColor.whiteColor()
        navigationController?.navigationBar.tintColor = .primaryColor()
    }
    
    func inject(dataManager: AssociatedObject) {
        self.dataManager = dataManager
    }
    
    func assertDependencies() {
        assert(dataManager != nil)
    }

    func styleView() {
        
        addButton.backgroundColor = .primaryColor()
        addButton.layer.cornerRadius = self.addButtonHeightConstraint.constant / 2
        addButton.layer.masksToBounds = true
        addButton.setImage(UIImage(named: "PlusButton"), forState: .Normal)
    }
    
    func styleTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = .backgroundColor()
        tableView.backgroundColor = .backgroundColor()
    }
}

// MARK: - Navigation
private typealias Navigation = CollectionsViewController
extension Navigation {
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let controller = segue.destinationViewController as? ItemsViewController {
            
            if segue.identifier == "CreateCollection" {
                
                controller.inject(CollectionModel(name: "", description: "", dateCreated: NSDate()))
                controller.delegate = self
                controller.newCollection = true
                
                
            } else if segue.identifier == "ShowCollection" {
                
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    
                    controller.inject(dataManager.collections[selectedIndexPath.row])
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
                controller.delegate = self
                self.navigationController?.navigationBar.tintColor = .primaryColor()
            }
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
        }
    }
}

// MARK: - TableView Protocols
private typealias TableViewDelegate = CollectionsViewController
extension TableViewDelegate: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //        performSegueWithIdentifier("ShowCollection", sender: collectionsArray[indexPath.row])
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        let editAction = UITableViewRowAction(style: .Normal, title: "Edit") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            
            self.performSegueWithIdentifier("ShowEditCollection", sender: indexPath.row)
            
        }
        editAction.backgroundColor = UIColor.secondaryColor()
        
        
        let deleteAction = UITableViewRowAction(style: .Destructive, title: "Delete") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
            
            self.dataManager.collections.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        deleteAction.backgroundColor = UIColor.warningColor()
        
        return [deleteAction, editAction]
    }
}

private typealias TableViewDataSource = CollectionsViewController
extension TableViewDataSource: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return dataManager.collections.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CollectionTableViewCell
        
        let collection = dataManager.collections[indexPath.row];
        
        cell.titleLabel.text = collection.name
        cell.titleLabel.textColor = UIColor.headingColor()
        cell.descriptionLabel.textColor = UIColor.subHeadingColor()
        cell.layoutMargins = UIEdgeInsetsZero;

        if collection.sorted {
            
            collection.items = collection.items.sort({ $0.points > $1.points })
            cell.descriptionLabel.text = collection.items.first!.text
            cell.sortedImageView.tintColor = .primaryColor()
            cell.sortedImageView.image = UIImage(named: "HeartSorted")?.imageWithRenderingMode(.AlwaysTemplate)
        } else {
            cell.descriptionLabel.text = ""
            cell.sortedImageView.tintColor = .subHeadingColor()
            cell.sortedImageView.image = UIImage(named: "HeartUnsorted")?.imageWithRenderingMode(.AlwaysTemplate)

        }
        return cell
    }
}

// MARK: - ItemsViewController Protocols
private typealias ItemsDelegate = CollectionsViewController
extension ItemsDelegate: ItemsViewControllerDelegate {
    
    func sortingFinished() {
        
        tableView.reloadData()
    }
    
    func collectionUpdated(collection: CollectionModel, new: Bool) {
        
        // How does this work when not new?
        if new {
            dataManager.collections.insert(collection, atIndex: 0)
        }
        
        tableView.reloadData()
    }
}