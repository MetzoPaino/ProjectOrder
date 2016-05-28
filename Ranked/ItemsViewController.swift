//
//  ItemsViewController.swift
//  Ranked
//
//  Created by William Robinson on 06/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import MessageUI

protocol ItemsViewControllerDelegate: class {
    func sortingFinished()
    func collectionUpdated(collection:CollectionModel, new: Bool)
}

enum BarButtonType {
    
    case done
    case edit
    case share
}

enum CellType {
    
    case image
    case title
    case description
    case addItem
}

class ItemsViewController: UIViewController, Injectable {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortButton: UIButton!
    @IBOutlet weak var sortButtonHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var sortButtonBottomConstraint: NSLayoutConstraint!

    var doneBarButton: UIBarButtonItem!
    var editBarButton: UIBarButtonItem!
    var shareBarButton: UIBarButtonItem!
    
    weak var delegate: ItemsViewControllerDelegate?

    
    var inEditingMode: Bool?
    var newCollection: Bool!
    
    var indexPathToEdit: NSIndexPath?
    
    let tapGesture = UITapGestureRecognizer()
    
    let editingCellOrder = [CellType.title, CellType.description, CellType.addItem]
    var displayCellOrder = [CellType]()

    typealias AssociatedObject = CollectionModel
    var collection: CollectionModel!
    
    // MARK: - Load View
    
    func newItem() {
        self.tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(ItemsViewController.receivedKeyboardNotification(_:)), name: UIKeyboardDidShowNotification, object: nil)

        tapGesture.addTarget(self, action: #selector(ItemsViewController.receivedGestureNotification(_:)))
        styleView()
        styleTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func inject(collection: AssociatedObject) {
        self.collection = collection
    }
    
    func assertDependencies() {
        assert(collection != nil)
    }
    
//    func newCollection() {
//        
//        dispatch_async(dispatch_get_main_queue(), {
//            self.tableView.reloadData()
//        })
//        
//    }
//    
//    func newItem() {
//        
//        dispatch_async(dispatch_get_main_queue(), {
//            self.tableView.reloadData()
//
//        })
//        
//    }

    // MARK: - Style View
    
    func styleView() {
        
        if inEditingMode == nil || inEditingMode == true {
            
            doneBarButton = createBarButton(.done)
            
            navigationItem.rightBarButtonItems = [doneBarButton]
            
        } else {
            
            if collection.premade {
                
                shareBarButton = createBarButton(.share)
                navigationItem.rightBarButtonItems = [shareBarButton]
                
            } else {
                
                editBarButton = createBarButton(.edit)
                shareBarButton = createBarButton(.share)
                navigationItem.rightBarButtonItems = [shareBarButton, editBarButton]
            }
        }
        
        navigationItem.backBarButtonItem?.tintColor = .primaryColor()
        
        sortButton.tintColor = .whiteColor()
        sortButton.layer.cornerRadius = self.sortButtonHeightConstraint.constant / 2
        sortButton.setImage(UIImage(named: "GreaterThan")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
//        sortButton.imageEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0)
        sortButton.backgroundColor = .primaryColor()
        
        sortButton.layer.shadowColor = UIColor.blackColor().CGColor;
        sortButton.layer.shadowOpacity = 0.25
        sortButton.layer.shadowRadius = 2
        sortButton.layer.shadowOffset = CGSizeMake(0.0, 2.0)
        sortButton.layer.masksToBounds = false
        
        if collection.items.count < 2 || inEditingMode == nil || inEditingMode == true {
            
            sortButtonBottomConstraint.constant = 0 - 16 - sortButtonHeightConstraint.constant
            
        }
        
        view.layoutIfNeeded()

    }
    
    func styleTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 112
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.backgroundColor = .whiteColor()
        tableView.separatorColor = .backgroundColor()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        view.endEditing(true)
        
        if let controller = segue.destinationViewController as? DescriptionViewController {
            
            controller.delegate = self

            if let _ = sender as? TitleCell {
                controller.context = .title
                controller.providedDescription = collection.name

            } else if let cell = sender as? SortedItemTableViewCell {
                
                controller.context = .item
                
                tableView.reloadData()
                    
                if let text = cell.titleLabel.text {
                       
                    controller.providedDescription = text
                }
                
            } else if let cell = sender as? UnsortedItemTableViewCell {
                
                controller.context = .item
                
                tableView.reloadData()
                
                if let text = cell.titleLabel.text {
                    
                    controller.providedDescription = text
                }
                
            } else {
                
                controller.context = .description
                controller.providedDescription = collection.descriptionString
            }
            
            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
        } else if let navigationController = segue.destinationViewController as? UINavigationController, controller = navigationController.topViewController as? SortingViewController {
            
            navigationController.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
            navigationController.navigationBar.shadowImage = nil
            navigationController.navigationBar.translucent = false
            navigationController.view.backgroundColor = UIColor.whiteColor()
            navigationController.navigationBar.tintColor = .blackColor()
        
            if let image = collection.image {
                controller.image = image
            }
            controller.itemArray = collection.items
            controller.delegate = self
        }
    }
    
    // MARK: - Internal
    
    func createBarButton(barButtonType: BarButtonType) -> UIBarButtonItem {
        
        var action = Selector()
        var title: String
        
        switch barButtonType {
            
            case .done:
                action =  #selector(ItemsViewController.doneButtonPressed(_:))
                title = "Done"
                break
            case .edit:
                action = #selector(ItemsViewController.editButtonPressed(_:))
                title = "Edit"
                break
            case .share:
                action = #selector(ItemsViewController.shareButtonPressed(_:))
                title = ""
                break
        }
        
        if barButtonType == .share {
            
            let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Action, target: self, action: action)
            barButton.tintColor = .primaryColor()
            return barButton
            
        } else {
            
            let barButton = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: action)
            barButton.tintColor = .primaryColor()

            if barButtonType == .done {
                
                if collection.name != "" {
                    barButton.enabled = true
                } else {
                    barButton.enabled = false
                }
            }
            
            return barButton
        }
    }
    
    @IBAction func sortBarButtonPressed(sender: UIButton) {
        
        performSegueWithIdentifier("PresentSort", sender: self)
    }
}

// MARK: - Notifications
private typealias Notifications = ItemsViewController
extension Notifications {
    
    func receivedKeyboardNotification(notification: NSNotification) {
        
        if notification.name == UIKeyboardDidShowNotification {
            
            view.addGestureRecognizer(tapGesture)
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 2, inSection: 0), atScrollPosition: .Middle, animated: true)

        }
    }
    
    func receivedGestureNotification(gesture: UITapGestureRecognizer) {
        
        view.removeGestureRecognizer(tapGesture)
        view.endEditing(true)
    }
}

// MARK: - IBActions

private typealias IBActions = ItemsViewController
extension IBActions {
    
    @IBAction func shareButtonPressed(sender: UIBarButtonItem) {
        
        tableView.backgroundColor = UIColor.whiteColor()
        
        let fullFrame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, tableView.contentSize.height)
        tableView.frame = fullFrame
        tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0), atScrollPosition: UITableViewScrollPosition.Top, animated: false)

//        UIGraphicsBeginImageContext(tableView.contentSize);
        UIGraphicsBeginImageContextWithOptions(tableView.contentSize, false, 0.0)

        tableView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
//        tableView.drawViewHierarchyInRect(tableView.frame, afterScreenUpdates: false)
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext();
        
        tableView.backgroundColor = .clearColor()
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        navigationController?.presentViewController(activityViewController, animated: true) {
            // ...
        }
        tableView.layoutIfNeeded()
    }
    
    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        
        if let inEditingMode = inEditingMode {
            self.inEditingMode = !inEditingMode
        }
        
        doneBarButton = createBarButton(.done)
        navigationItem.rightBarButtonItems = [doneBarButton]
        
//        let colorPickerIndex = NSIndexPath(forRow: 2, inSection: 0)
        let addItemIndex = NSIndexPath(forRow: 2, inSection: 0)
        
        tableView.beginUpdates()
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
        tableView.insertRowsAtIndexPaths([addItemIndex], withRowAnimation: .Fade)
        tableView.endUpdates()
        
        animateSortButton(false)
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        inEditingMode = false
        
        editBarButton = createBarButton(.edit)
        shareBarButton = createBarButton(.share)
        navigationItem.rightBarButtonItems = [shareBarButton, editBarButton]
        
        let addItemIndex = NSIndexPath(forRow: 2, inSection: 0)

        if let addItemCell = tableView.cellForRowAtIndexPath(addItemIndex) as? AddItemTableViewCell {
            
            addItemCell.textFieldShouldReturn(addItemCell.textField)
        }
        
        tableView.beginUpdates()
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
        tableView.deleteRowsAtIndexPaths([addItemIndex], withRowAnimation: .Fade)
        tableView.endUpdates()
        
        animateSortButton(true)
        
        if newCollection == true {
            self.delegate?.collectionUpdated(collection, new: true)
            newCollection = false
        } else {
            self.delegate?.collectionUpdated(collection, new: false)
        }
    }
}

// MARK: - Animations

extension ItemsViewController {
    
    func animateSortButton(onScreen: Bool) {
        
        // Animate on or off screen. If there is nothing to sort, never go on screen
        
        var constant = 0 - 16 - sortButtonHeightConstraint.constant
        var time = 1.0
        
        if onScreen && collection.items.count > 1 {
            
            constant = 16
            time = 0.5
        }
        
        UIView.animateWithDuration(time, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
            
            self.sortButtonBottomConstraint.constant = constant
            self.view.layoutIfNeeded()
            
            }, completion: { (complete: Bool) -> Void in
        })
    }
}

// MARK: - Description Delegate
private typealias DescriptionDelegate = ItemsViewController
extension DescriptionDelegate: DescriptionViewControllerDelegate {
    
    func newTitle(text: String) {
        collection.name = text
        tableView.reloadData()
        
        if text != "" {
            doneBarButton.enabled = true
        } else {
            doneBarButton.enabled = false
        }
    }
    
    func newItem(text: String) {
        
        if let indexPath = indexPathToEdit {
            
            tableView.beginUpdates()
            collection.items[indexPath.row].text = text
            tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
            tableView.endUpdates()

            indexPathToEdit = nil
        }
    }
    
    func newDescription(text: String) {
        collection.descriptionString = text
        tableView.reloadData()
    }
}

extension ItemsViewController: SortingViewControllerDelegate {
    
    func sortingFinished(items: [ItemModel]) {
        
        collection.sorted = true
        
        for item in collection.items {
            
            item.sorted = true
        }
        collection.items = items.sort({ $0.points > $1.points })
        tableView.reloadData()
        self.delegate?.sortingFinished()
    }
}

// MARK: - AddItemTableViewCell Delegate
private typealias AddItemDelegate = ItemsViewController
extension AddItemDelegate: AddItemTableViewCellDelegate {
    
    func createdNewItemWithText(text: String) {
        
        // Inserting causes a crash, but would look nicer
        let item = ItemModel(string: text, dateCreated: NSDate())
        collection.items.insert(item, atIndex: 0)
        tableView.reloadData()
        
        let addItemIndex = NSIndexPath(forRow: 2, inSection: 0)
        if let cell = tableView.cellForRowAtIndexPath(addItemIndex) as? AddItemTableViewCell {
            cell.textField.becomeFirstResponder()
        }
    }
}

// MARK: - TableViewDelegate
private typealias TableViewDelegate = ItemsViewController
extension TableViewDelegate: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if let cell = tableView.cellForRowAtIndexPath(indexPath) as? AddItemTableViewCell {
            
            cell.textField.becomeFirstResponder()
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if indexPath.section == 0 {
            return false
        } else {
            
            if !collection.premade {
                return true
            } else {
                return false
            }
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        if indexPath.section == 0 {
            return nil
        } else {
            
            var actionArray = [UITableViewRowAction]()
            
            if !collection.premade {
            
                let editAction = UITableViewRowAction(style: .Normal, title: "Edit") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                
                    self.indexPathToEdit = indexPath
                    self.performSegueWithIdentifier("ShowItem", sender: tableView.cellForRowAtIndexPath(indexPath))
                
                }
                editAction.backgroundColor = UIColor.secondaryColor()
                actionArray.append(editAction)
            
            
                let deleteAction = UITableViewRowAction(style: .Destructive, title: "Delete") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                    
                    CloudKitManager().deleteFromCloudKit(self.collection.items[indexPath.row].record.recordID)
                    self.collection.items.removeAtIndex(indexPath.row)
                    tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                    tableView.reloadData()
                }
                deleteAction.backgroundColor = UIColor.warningColor()
                actionArray.insert(deleteAction, atIndex: 0)

                return actionArray
            } else {
                return nil
            }
        }
    }
}

private typealias TableViewDataSource = ItemsViewController
extension TableViewDataSource: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 3
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            displayCellOrder = [CellType]()
            
            var cellCounter = 0
            
            if let _ = collection.image {

                cellCounter = cellCounter + 1
                displayCellOrder.append(CellType.image)
            }
            
            cellCounter = cellCounter + 1 // Title cell
            displayCellOrder.append(CellType.title)

            if inEditingMode == nil || inEditingMode == true {
                displayCellOrder = editingCellOrder
                return 3
            } else {
                if collection.descriptionString != "" {
                    cellCounter = cellCounter + 1
                    displayCellOrder.append(CellType.description)
                }
            }
            
            return cellCounter
            
        } else if section == 1 {
            
            return collection.returnArrayOfItems(true).count
            
        } else {
            
            return collection.returnArrayOfItems(false).count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            var editing = false
            
            if inEditingMode == nil || inEditingMode == true {
                editing = true
            }
            
            if displayCellOrder[indexPath.row] == CellType.image {
                return createImageCell(collection.image, indexPath: indexPath, inEditingMode: editing)
            } else if displayCellOrder[indexPath.row] == CellType.title {
                return createTitleCell(collection.name, indexPath: indexPath, inEditingMode: editing)
            } else if displayCellOrder[indexPath.row] == CellType.addItem {
                return createAddItemCell(indexPath)
            } else {
                return createDescriptionCell(collection.descriptionString, indexPath: indexPath, inEditingMode: editing)
            }
            
        } else if indexPath.section == 1 {
            
            let item = collection.returnArrayOfItems(true)[indexPath.row]
            
            let cell = tableView.dequeueReusableCellWithIdentifier("UnsortedCell", forIndexPath: indexPath) as! UnsortedItemTableViewCell
            
            cell.numberLabel.text = "\(indexPath.row + 1)"
            cell.titleLabel.text = item.text

            cell.circleImageViewWidthConstraint.constant = 48

            cell.configureCell(true)

            if let image = item.image {
                cell.circleImageView.image = image
                cell.tintView.alpha = 0.5

            } else {
                cell.circleImageView.image = UIImage()
                cell.tintView.alpha = 1
            }

            
            switch indexPath.row {
            case 0:
                cell.tintView.backgroundColor = .primaryColor()
            case 1:
                cell.tintView.backgroundColor = .secondaryColor()
            case 2:
                cell.tintView.backgroundColor = .secondColor()
            case 3:
                cell.tintView.backgroundColor = .thirdColor()
            default:
                cell.tintView.backgroundColor = .loserColor()
            }

            return cell
            
        } else {
            
            let item = collection.returnArrayOfItems(false)[indexPath.row]
            
            let cell = tableView.dequeueReusableCellWithIdentifier("UnsortedCell", forIndexPath: indexPath) as! UnsortedItemTableViewCell
            
            cell.titleLabel.text = item.text

            if let image = item.image {
                cell.circleImageViewWidthConstraint.constant = 48
                cell.circleImageView.image = image
                
            } else {
                cell.circleImageViewWidthConstraint.constant = 0
            }
            cell.configureCell(false)
            
            // This is messy, fix it properly
            if let _ = item.image {
                
                cell.circleImageView.layer.cornerRadius = cell.circleImageViewWidthConstraint.constant / 2
                cell.circleImageView.layer.masksToBounds = true
                cell.titleLabelLeadingConstraint.constant = 8
                
            } else {
                
                cell.titleLabelLeadingConstraint.constant = 0

            }

            
            cell.tintView.alpha = 0
            
            return cell
        }
    }
}

extension ItemsViewController {
    
    func createImageCell(image:UIImage?, indexPath:NSIndexPath, inEditingMode: Bool) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ImageCell", forIndexPath: indexPath) as! TitleCell
        cell.separatorInset = UIEdgeInsetsMake(0, Helper.largestDeviceSide(), 0, 0);
        
        if let image = image {
            cell.summaryImageView.image = image
        }
        cell.configureCell()
        return cell
    }
    
    func createTitleCell(text: String, indexPath:NSIndexPath, inEditingMode: Bool) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
        cell.separatorInset = UIEdgeInsetsMake(0, Helper.largestDeviceSide(), 0, 0);
        
        if inEditingMode == true {
            
            cell.userInteractionEnabled = true
            cell.accessoryType = .DisclosureIndicator
            cell.label.text = "Title"
            cell.label.textColor = .backgroundColor()
            
        } else {
            cell.userInteractionEnabled = false
            cell.accessoryType = .None
            cell.label.textColor = .headingColor()
        }
        
        if text != "" {
            
            cell.label.text = text
            cell.label.textColor = .headingColor()
            
        } else {
            cell.label.text = "Title"
            cell.label.textColor = .backgroundColor()
            
        }
        return cell
    }
    
    func createDescriptionCell(text: String, indexPath:NSIndexPath, inEditingMode: Bool) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("DescriptionCell", forIndexPath: indexPath) as! DescriptionCell
        cell.separatorInset = UIEdgeInsetsMake(0, Helper.largestDeviceSide(), 0, 0);
        
        if inEditingMode == true {
            
            cell.userInteractionEnabled = true
            cell.accessoryType = .DisclosureIndicator
            cell.label.text = "Description"
            cell.label.textColor = .backgroundColor()
            
        } else {
            cell.userInteractionEnabled = false
            cell.accessoryType = .None
            cell.label.textColor = .subHeadingColor()
        }
        
        if text != "" {
            
            cell.label.text = text
            cell.label.textColor = .subHeadingColor()
            
        } else {
            cell.label.text = "Description"
            cell.label.textColor = .backgroundColor()
            
        }
        return cell
    }
    
    func createAddItemCell(indexPath:NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AddItemCell", forIndexPath: indexPath) as! AddItemTableViewCell
        cell.delegate = self
        cell.configureCell()
        cell.selectionStyle = .None
        cell.layoutMargins = UIEdgeInsetsZero;
        
        return cell
    }
}


