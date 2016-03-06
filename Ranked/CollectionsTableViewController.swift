//
//  CollectionsTableViewController.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class CollectionTableViewCell: UITableViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
}

class CollectionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!

    var dataManager: DataManager!
    var collectionsArray = [CollectionModel]()
    
    var shadowImage: UIImage!
    var backgroundImage: UIImage!

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionsArray = dataManager.collections
        styleTableView()
    
        navigationController?.navigationItem.backBarButtonItem?.title = ""
    }
    
    override func viewDidDisappear(animated: Bool)  {
        super.viewDidDisappear(animated)
        
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        tableView.reloadData()
        
        if collectionsArray.count > 0 && view.traitCollection.horizontalSizeClass != UIUserInterfaceSizeClass.Compact {
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
        }
        
        navigationController?.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.translucent = false
        navigationController?.view.backgroundColor = UIColor.whiteColor()
        navigationController?.navigationBar.tintColor = .blackColor()

    }
//
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(animated)
//        if collectionsArray.count > 0 && view.traitCollection.horizontalSizeClass != UIUserInterfaceSizeClass.Compact {
//            tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
//        }
//    }

    func styleTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsZero
    }

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let navigationController = segue.destinationViewController as? UINavigationController, controller = navigationController.topViewController as? ItemsViewController {
            
            if segue.identifier == "CreateCollection" {
                
            } else if segue.identifier == "ShowCollection" {
                
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    
                    controller.collection = collectionsArray[selectedIndexPath.row]
                    controller.inEditingMode = false
                    controller.delegate = self
                    self.navigationController?.navigationBar.tintColor = controller.collection.color.subtitleColor

                }
            }
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), forBarMetrics: UIBarMetrics.Default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.translucent = true
            self.navigationController?.view.backgroundColor = UIColor.clearColor()
        }
    }
}

private typealias TableViewDelegate = CollectionsViewController
extension TableViewDelegate: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        //        performSegueWithIdentifier("ShowCollection", sender: collectionsArray[indexPath.row])
    }
}

private typealias TableViewDataSource = CollectionsViewController
extension TableViewDataSource: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return collectionsArray.count
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CollectionTableViewCell
        
        let collection = collectionsArray[indexPath.row];
        
        cell.titleLabel.text = collection.name
        cell.titleLabel.textColor = collection.color.titleColor
        cell.descriptionLabel.textColor = collection.color.subtitleColor
        cell.layoutMargins = UIEdgeInsetsZero;
        
        cell.descriptionLabel.text! = "⭐️"
        
        if collection.sorted {
            
            collection.items = collection.items.sort({ $0.points > $1.points })
            cell.descriptionLabel.text! += " \(collection.items.first!.text)"
            cell.descriptionLabel.alpha = 1.0
        } else {
            cell.descriptionLabel.alpha = 0.25
        }
        return cell
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            collectionsArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }

}

private typealias ItemsDelegate = CollectionsViewController
extension ItemsDelegate: ItemsViewControllerDelegate {
    
    func sortingFinished() {
        
        tableView.reloadData()
    }
}

//extension CollectionsTableViewController: AddCollectionViewControllerDelegate {
//    
//    func addCollectionViewControllerCreatedNewCollectionWithName(name: String, description: String, category: CollectionType) {
//        
//        let collection = CollectionModel(name: name, description: description, category: category, dateCreated: NSDate())
//        collectionsArray.append(collection)
//        
//        collectionsArray = collectionsArray.sort({ $0.dateCreated.compare($1.dateCreated) == NSComparisonResult.OrderedDescending})
//        tableView.reloadData()
//    }
//}
