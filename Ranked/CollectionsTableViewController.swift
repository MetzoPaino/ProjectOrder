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

extension UIColor {
    
    public class func primaryColor() -> UIColor {
        
        return UIColor(red: 229/255, green: 39/255, blue: 113/255, alpha: 1.0)
    }
    
    public class func secondaryColor() -> UIColor {
        
        return UIColor(red: 142/255, green: 226/255, blue: 200/255, alpha: 1.0)
    }
    
    public class func warningColor() -> UIColor {
        
        return UIColor(red: 219/255, green: 33/255, blue: 66/255, alpha: 1.0)
    }
    
    public class func backgroundColor() -> UIColor {
        
        return UIColor(red: 218/255, green: 218/255, blue: 218/255, alpha: 1.0)
    }
    
    public class func headingColor() -> UIColor {
        
        return UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1.0)
    }
    
    public class func subHeadingColor() -> UIColor {
        
        return UIColor(red: 114/255, green: 113/255, blue: 110/255, alpha: 1.0)
    }
    
    public class func titleColor() -> UIColor {
        
        return UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1.0)
    }
    
    public class func secondColor() -> UIColor {
        
        return UIColor(red: 131/255, green: 47/255, blue: 85/255, alpha: 1.0)
    }
    
    public class func thirdColor() -> UIColor {
        
        return UIColor(red: 92/255, green: 54/255, blue: 71/255, alpha: 1.0)
    }
    
    public class func loserColor() -> UIColor {
        
        return UIColor(red: 59/255, green: 59/255, blue: 59/255, alpha: 1.0)
    }
    
    public class func blockColor() -> UIColor {
        
        return UIColor(red: 29/255, green: 29/255, blue: 29/255, alpha: 1.0)
    }
    
    public class func sortColor() -> UIColor {
        
        return UIColor(red: 31/255, green: 31/255, blue: 31/255, alpha: 1.0)
    }
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
        moveAutoCreateButtonsOffScreen()
        styleTutorialView()
        
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

    func styleTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = .backgroundColor()
        tableView.backgroundColor = .backgroundColor()
    }
    
    func styleTutorialView() {
        
        if collectionsArray.count == 0 {
            
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
        collectionsArray.insert(collection, atIndex: 0)
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
        
        if let navigationController = segue.destinationViewController as? UINavigationController, controller = navigationController.topViewController as? ItemsViewController {
            
            if segue.identifier == "CreateCollection" {
                
            } else if segue.identifier == "ShowCollection" {
                
                if let selectedIndexPath = tableView.indexPathForSelectedRow {
                    
                    controller.collection = collectionsArray[selectedIndexPath.row]
                    controller.inEditingMode = false
                    controller.delegate = self
                    self.navigationController?.navigationBar.tintColor = .primaryColor()

                }
            } else if segue.identifier == "ShowEditCollection" {
                
                if let row = sender as? Int {
                    
                    controller.collection = collectionsArray[row]
                    
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
            
            self.collectionsArray.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
        deleteAction.backgroundColor = UIColor.warningColor()
        
        return [deleteAction, editAction]
    }
}

private typealias TableViewDataSource = CollectionsViewController
extension TableViewDataSource: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return collectionsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CollectionTableViewCell
        
        let collection = collectionsArray[indexPath.row];
        
        cell.titleLabel.text = collection.name
        cell.titleLabel.textColor = UIColor.headingColor()
        cell.descriptionLabel.textColor = UIColor.subHeadingColor()
        cell.layoutMargins = UIEdgeInsetsZero;

        if collection.sorted {
            
            collection.items = collection.items.sort({ $0.points > $1.points })
            cell.descriptionLabel.text = collection.items.first!.text
            cell.sortedImageView.tintColor = .blueColor()
            cell.sortedImageView.image = UIImage(named: "HeartSorted")?.imageWithRenderingMode(.AlwaysTemplate)
        } else {
            cell.descriptionLabel.text = ""
            cell.sortedImageView.tintColor = .blueColor()
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
