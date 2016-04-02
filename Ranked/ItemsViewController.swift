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
}

enum BarButtonType {
    
    case done
    case edit
    case share
}

class ItemsViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var sortBarButton: UIBarButtonItem!

    var doneBarButton: UIBarButtonItem!
    var editBarButton: UIBarButtonItem!
    var shareBarButton: UIBarButtonItem!
    
    weak var delegate: ItemsViewControllerDelegate?

    var collection = CollectionModel(name: "", description: "", category: .none, dateCreated: NSDate(), color: ColorTheme())
    
    var inEditingMode: Bool?
    
    var indexPathToEdit: NSIndexPath?
    
    let tapGesture = UITapGestureRecognizer()

    // MARK: - Load View

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let notificationCenter = NSNotificationCenter.defaultCenter()
        notificationCenter.addObserver(self, selector: #selector(ItemsViewController.receivedKeyboardNotification(_:)), name: UIKeyboardDidShowNotification, object: nil)
        
        tapGesture.addTarget(self, action: #selector(ItemsViewController.receivedGestureNotification(_:)))
        styleView()
        styleTableView()
    }
    
    override func viewWillAppear(animated: Bool) {
        
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }

    // MARK: - Style View
    
    func styleView() {
        
        if inEditingMode == nil || inEditingMode == true {
            
            doneBarButton = createBarButton(.done)
            navigationController?.navigationItem.rightBarButtonItems = [doneBarButton]
            navigationController?.setToolbarHidden(true, animated: false)
            
        } else {
            
            editBarButton = createBarButton(.edit)
            shareBarButton = createBarButton(.share)
            navigationController?.navigationItem.rightBarButtonItems = [shareBarButton, editBarButton]
            navigationController?.setToolbarHidden(false, animated: true)
        }
        
        navigationController?.navigationItem.backBarButtonItem?.tintColor = .primaryColor()
        
        sortBarButton.tintColor = .primaryColor()
    }
    
    func styleTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = collection.color.subtitleColor
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        view.endEditing(true)
        
        if let controller = segue.destinationViewController as? DescriptionViewController {
            
            controller.delegate = self

            if let _ = sender as? TitleCell {
                controller.context = .title
                controller.providedDescription = collection.name

            } else if let _ = sender as? ItemTableViewCell {
                
                controller.context = .item
                if let cell = sender as? ItemTableViewCell {
                    
                    tableView.reloadData()
                    
                    if let text = cell.titleLabel.text {
                       
                        controller.providedDescription = text

                    }
                }
                
            } else {
                controller.context = .description
                controller.providedDescription = collection.descriptionString
            }
            
        } else if let navigationController = segue.destinationViewController as? UINavigationController, controller = navigationController.topViewController as? SortingViewController {
            
            navigationController.navigationBar.setBackgroundImage(nil, forBarMetrics: UIBarMetrics.Default)
            navigationController.navigationBar.shadowImage = nil
            navigationController.navigationBar.translucent = false
            navigationController.view.backgroundColor = UIColor.whiteColor()
            navigationController.navigationBar.tintColor = .blackColor()
        
            controller.itemArray = collection.items
            controller.delegate = self
            controller.colorTheme = collection.color
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
}

// MARK: - Notifications
private typealias Notifications = ItemsViewController
extension Notifications {
    
    func receivedKeyboardNotification(notification: NSNotification) {
        
        if notification.name == UIKeyboardDidShowNotification {
            
            view.addGestureRecognizer(tapGesture)
            tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: 3, inSection: 0), atScrollPosition: .Middle, animated: true)

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
    

    
    @IBAction func shareButtonPressed(sender: AnyObject) {
        
//        let fullFrame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, tableView.contentSize.height)
//        tableView.frame = fullFrame
//        tableView.backgroundColor = collection.color.backgroundColors.first
//        
//        UIGraphicsBeginImageContextWithOptions(tableView.contentSize, false, 0.0)
//        tableView.drawViewHierarchyInRect(tableView.frame, afterScreenUpdates: false)
//        
//        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext();
//        
//        let image = UIImageView(image: screenshot)
//        
//        tableView.backgroundColor = .clearColor()
        
        tableView.backgroundColor = collection.color.backgroundColors.first
        
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
    }
    
    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        
        if let inEditingMode = inEditingMode {
            self.inEditingMode = !inEditingMode
        }
        
        doneBarButton = createBarButton(.done)
        navigationController?.navigationItem.rightBarButtonItems = [doneBarButton]
        
        let colorPickerIndex = NSIndexPath(forRow: 2, inSection: 0)
        let addItemIndex = NSIndexPath(forRow: 3, inSection: 0)
        
        tableView.beginUpdates()
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
        tableView.insertRowsAtIndexPaths([colorPickerIndex, addItemIndex], withRowAnimation: .Fade)
        tableView.endUpdates()
        
        navigationController?.setToolbarHidden(true, animated: true)

    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        self.inEditingMode = false
        
        editBarButton = createBarButton(.edit)
        shareBarButton = createBarButton(.share)
        navigationController?.navigationItem.rightBarButtonItems = [shareBarButton, editBarButton]
        
        let colorPickerIndex = NSIndexPath(forRow: 2, inSection: 0)
        let addItemIndex = NSIndexPath(forRow: 3, inSection: 0)
        
        tableView.beginUpdates()
        tableView.reloadSections(NSIndexSet(index: 0), withRowAnimation: .Fade)
        tableView.deleteRowsAtIndexPaths([colorPickerIndex, addItemIndex], withRowAnimation: .Fade)
        tableView.endUpdates()
        
        navigationController?.setToolbarHidden(false, animated: true)
    }
    
    @IBAction func sortBarButtonPressed(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("PresentSort", sender: self)
    }
}

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
        collection.items = items.sort({ $0.points > $1.points })
        tableView.reloadData()
        self.delegate?.sortingFinished()
    }
}

extension ItemsViewController: ColorCellDelegate {
    
    func pickedNewColor(index: Int) {
        
        let colorManager = ColorManager()
        
        collection.color = colorManager.colorThemes[index]
        tableView.reloadData()
        tableView.separatorColor = collection.color.subtitleColor
    }
}

extension ItemsViewController: AddItemTableViewCellDelegate {
    
    func createdNewItemWithText(text: String) {
        
        view.removeGestureRecognizer(tapGesture)
        let item = ItemModel(string: text)
        collection.items.append(item)
        tableView.reloadData()
    }
}

// MARK: - TableViewDelegate
private typealias TableViewDelegate = ItemsViewController
extension TableViewDelegate: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if indexPath.section == 0 {
            return false
        } else {

            return true
        }
    }
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        
        if indexPath.section == 0 {
            return nil
        } else {
            
            let editAction = UITableViewRowAction(style: .Normal, title: "Edit") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                
                self.indexPathToEdit = indexPath
                self.performSegueWithIdentifier("ShowItem", sender: tableView.cellForRowAtIndexPath(indexPath))
                
            }
            editAction.backgroundColor = UIColor.blueColor()
            
            
            let deleteAction = UITableViewRowAction(style: .Destructive, title: "Delete") { (rowAction:UITableViewRowAction, indexPath:NSIndexPath) -> Void in
                
                self.collection.items.removeAtIndex(indexPath.row)
                tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
                tableView.reloadData()
            }
            deleteAction.backgroundColor = UIColor.redColor()
            
            return [deleteAction, editAction]
        }
    }
}

private typealias TableViewDataSource = ItemsViewController
extension TableViewDataSource: UITableViewDataSource {
    

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            if inEditingMode == nil || inEditingMode == true {
                return 3
            } else {
                if collection.descriptionString != "" {
                    return 2
                } else {
                    return 1
                }
            }
            
        } else {
            
            return collection.items.count
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
                cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);

                if inEditingMode == nil || inEditingMode == true {
                    
                    cell.userInteractionEnabled = true
                    cell.accessoryType = .DisclosureIndicator
                    cell.label.text = "Title"
                    cell.label.textColor = .backgroundColor()
                    
                } else {
                    cell.userInteractionEnabled = false
                    cell.accessoryType = .None
                    cell.label.textColor = .headingColor()

                }
                
                if collection.name != "" {
                    
                    cell.label.text = collection.name
                    cell.label.textColor = .headingColor()
                    
                } else {
                    cell.label.text = "Title"
                    cell.label.textColor = .backgroundColor()
                    
                }
//                if inEditingMode == nil {
//                    cell.textView.becomeFirstResponder()
//                    cell.configureCell(nil, enableEditing: inEditingMode)
//                    
//                } else {
//                    cell.configureCell(collection.name, enableEditing: inEditingMode)
//                }
                
                return cell
                
            }
            
//            else if indexPath.row == 2 {
//                
//                let cell = tableView.dequeueReusableCellWithIdentifier("ColorCell", forIndexPath: indexPath) as! ColorCell
//                cell.delegate = self
//                cell.configureCell()
//                cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
//                return cell
//                
//            }
            
            else if indexPath.row == 2 {
            
                let cell = tableView.dequeueReusableCellWithIdentifier("AddItemCell", forIndexPath: indexPath) as! AddItemTableViewCell
                cell.delegate = self
                cell.configureCell()
//                cell.layoutMargins = UIEdgeInsetsZero;
                cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);

                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("DescriptionCell", forIndexPath: indexPath) as! DescriptionCell
                cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
                
                if inEditingMode == nil || inEditingMode == true {
                    
                    cell.userInteractionEnabled = true
                    cell.accessoryType = .DisclosureIndicator
                    cell.label.text = "Description"
                    cell.label.textColor = .backgroundColor()
                    
                } else {
                    cell.userInteractionEnabled = false
                    cell.accessoryType = .None
                    cell.label.textColor = .subHeadingColor()
                }
                
                if collection.descriptionString != "" {
                    
                    cell.label.text = collection.descriptionString
                    cell.label.textColor = .subHeadingColor()

                } else {
                    cell.label.text = "Description"
                    cell.label.textColor = .backgroundColor()

                }

                
                return cell
            }
            
        } else {
            
            let item = collection.items[indexPath.row]
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ItemTableViewCell

            cell.numberLabel.text = "\(indexPath.row + 1)"
            cell.titleLabel.text = item.text
            cell.titleLabel.textColor = .titleColor()
            
            cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
            cell.selectionStyle = .None
            
            if collection.sorted {
                
                cell.numberLabelWidthConstraint.constant = 40
                cell.numberLabel.hidden = false
                cell.numberLabel.textColor = .whiteColor()
                
                cell.numberImageView.hidden = false
                
                switch indexPath.row {
                case 0:
                    cell.numberImageView.backgroundColor = .primaryColor()
                case 1:
                    cell.numberImageView.backgroundColor = .secondColor()
                case 2:
                    cell.numberImageView.backgroundColor = .thirdColor()
                default:
                    cell.numberImageView.backgroundColor = .secondaryColor()
                }
                
            } else {
                cell.numberLabelWidthConstraint.constant = 0
                cell.numberLabel.hidden = true
                cell.numberImageView.hidden = true

            }
            return cell
        }
    }
    
//    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
//        
//        if editingStyle == .Delete {
//            collection.items.removeAtIndex(indexPath.row)
//            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
//        }
//    }
    
//    func tableView(tableView: UITableView, editingStyleForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCellEditingStyle {
//        
//        if indexPath.section == 0 {
//            return UITableViewCellEditingStyle.None
//        } else {
//            return UITableViewCellEditingStyle.
//        }
//    }
}
