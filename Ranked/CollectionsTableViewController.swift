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
}

class CollectionsTableViewController: UITableViewController {
    
    var dataManager: DataManager!
    var collectionsArray = [CollectionModel]()

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionsArray = dataManager.collections
        styleTableView()
        navigationController?.navigationBar.barTintColor = .whiteColor()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
//        if collectionsArray.count > 0 && view.traitCollection.horizontalSizeClass != UIUserInterfaceSizeClass.Compact {
//            tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
//        }
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if collectionsArray.count > 0 && view.traitCollection.horizontalSizeClass != UIUserInterfaceSizeClass.Compact {
            tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: false, scrollPosition: UITableViewScrollPosition.None)
        }
    }
    
    func styleTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsZero
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return collectionsArray.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CollectionTableViewCell
        
        let collection = collectionsArray[indexPath.row];
        
        cell.titleLabel.text = collection.name
        cell.titleLabel.textColor = collection.color
        cell.layoutMargins = UIEdgeInsetsZero;
//        switch collection.category {
//            
//        case .music:
//            cell.descriptionLabel.text = "🎵 "
//            
//        case .films:
//            cell.descriptionLabel.text = "📽 "
//            
//        case .books:
//            cell.descriptionLabel.text = "📚 "
//        case .games:
//            cell.descriptionLabel.text = "🎮 "
//        case .computers:
//            cell.descriptionLabel.text = "🖥 "
//        case .none:
//            cell.descriptionLabel.text = ""
//            break
//        }
        
        cell.descriptionLabel.text! = "⭐️"
        
        if collection.sorted {
            
            collection.items = collection.items.sort({ $0.points > $1.points })
            cell.descriptionLabel.text! += " \(collection.items.first!.text)"
            cell.descriptionLabel.alpha = 1.0
        } else {
            cell.descriptionLabel.alpha = 0.25
        }
        
//        var visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .Light))
//        
//        visualEffectView.frame = cell.backgroundImageView.bounds
//        
//        cell.backgroundImageView.addSubview(visualEffectView)
//visualEffectView.center = cell.backgroundImageView.center
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        performSegueWithIdentifier("ShowCollection", sender: collectionsArray[indexPath.row])
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            // Delete the row from the data source
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        } else if editingStyle == .Insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(tableView: UITableView, moveRowAtIndexPath fromIndexPath: NSIndexPath, toIndexPath: NSIndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    // MARK: - Navigation

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let navigationController = segue.destinationViewController as? UINavigationController, controller = navigationController.topViewController as? ItemsViewController {
            
            if segue.identifier == "CreateCollection" {
                
            } else if segue.identifier == "ShowCollection" {
                
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    
                    controller.collection = collectionsArray[selectedIndexPath.row]
                    controller.inEditingMode = false
                    controller.delegate = self
                }
            }
        }
    }
}

extension CollectionsTableViewController: ItemsViewControllerDelegate {
    
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
