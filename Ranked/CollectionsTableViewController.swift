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
    @IBOutlet weak var sortedImageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
}

class CollectionsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var tutorialView: UIView!
    @IBOutlet weak var autoCreateOption1Button: UIButton!
    @IBOutlet weak var option1XAlignmentConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var autoCreateOption2Button: UIButton!
    @IBOutlet weak var option2XAlignmentConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var autoCreateOption3Button: UIButton!
    @IBOutlet weak var option3XAlignmentConstraint: NSLayoutConstraint!
    
    @IBOutlet var autoCreateOptionButtonsCollection: [UIButton]!

    @IBOutlet weak var refreshAutoCreateOptionsButton: UIButton!

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var addButtonHeightConstraint: NSLayoutConstraint!



    
    var dataManager: DataManager!
    var collectionsArray = [CollectionModel]()
    
    var shadowImage: UIImage!
    var backgroundImage: UIImage!
    
    var hasCollections = true

    
    
    // MARK: - Setup
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionsArray = dataManager.collections
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
    
    override func viewDidAppear(animated: Bool) {
        
        animateAutoCreateButtons(true)
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
    
    func styleTutorialView() {
        
        if dataManager.collections.count == 0 {
            
            tutorialView.hidden = false
            
            var randomIntArray = [Int]()
            
            repeat {
                
                let index = Int(arc4random_uniform(UInt32(preMadeCollectionsArray.count)))
                
                if !randomIntArray.contains(index) {
                    
                    randomIntArray.append(index)
                }
                
            } while (randomIntArray.count < 3);
            
            for (index, integer) in randomIntArray.enumerate() {
                
                let button = autoCreateOptionButtonsCollection[index]
                button.setTitle(preMadeCollectionsArray[integer].name, forState: .Normal)
                button.tag = integer
            }
            
        } else {
            tutorialView.hidden = true
        }
    }
    
    func moveAutoCreateButtonsOffScreen() {
        
        option1XAlignmentConstraint.constant = 0 - view.bounds.width
        option2XAlignmentConstraint.constant = 0 + view.bounds.width
        option3XAlignmentConstraint.constant = 0 - view.bounds.width
    }
    
    func animateAutoCreateButtons(onScreen: Bool) {
        
        var stageLeft: CGFloat = 0
        var stageRight: CGFloat = 0
        
        if !onScreen {
            
            stageLeft = view.bounds.width
            stageRight = view.bounds.width
        }
        
        UIView.animateWithDuration(0.5, delay: 0.0, usingSpringWithDamping: 0.75, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.option1XAlignmentConstraint.constant = 0 - stageLeft
            self.option2XAlignmentConstraint.constant = 0 + stageRight
            self.option3XAlignmentConstraint.constant = 0 - stageLeft
            
            self.view.layoutIfNeeded()
            
            }) { (completion) -> Void in
                
                if !onScreen {
                    
                    self.styleTutorialView()
                    self.animateAutoCreateButtons(true)
                }
            }
    }
    
    // MARK: - IBActions

    @IBAction func optionButtonPressed(sender: UIButton) {
        
        let collection = preMadeCollectionsArray[sender.tag]
        dataManager.collections.insert(collection, atIndex: 0)
        tableView.reloadData()
        tableView.selectRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), animated: true, scrollPosition: UITableViewScrollPosition.None)
        tutorialView.hidden = true
        performSegueWithIdentifier("ShowCollection", sender: nil)
        
    }
    
    @IBAction func refreshAutoCreateOptionsButtonPressed(sender: UIButton) {
        animateAutoCreateButtons(false)
    }
    
    // MARK: - Navigation

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
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        if editingStyle == .Delete {
//            collectionsArray.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//        }
//    }

}

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
