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
    case sort
}

class ItemsViewController: UIViewController, MFMessageComposeViewControllerDelegate {


//    @IBOutlet weak var sortBarButton: UIBarButtonItem!

    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet var addItemsHeaderView: AddItemView!
    @IBOutlet weak var shareBarButton: UIBarButtonItem!

    var sortBarButton: UIBarButtonItem!
    var doneBarButton: UIBarButtonItem!
    var editBarButton: UIBarButtonItem!

    
    weak var delegate: ItemsViewControllerDelegate?

    var collection = CollectionModel(name: "", description: "", category: .none, dateCreated: NSDate(), color: ColorTheme())
    
    var inEditingMode: Bool?
    let gradientLayer = CAGradientLayer()

    // MARK: - Load View

    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
        styleTableView()
    }

    // MARK: - Style View
    
    func styleView() {
        
        if inEditingMode != nil {
            
            editBarButton = createBarButton(.edit)
            sortBarButton = createBarButton(.sort)
            navigationController?.navigationItem.rightBarButtonItems = [shareBarButton, sortBarButton, editBarButton]

        } else {
            doneBarButton = createBarButton(.done)
            navigationController?.navigationItem.rightBarButtonItems = [shareBarButton, doneBarButton]
        }
        
        gradientLayer.frame = self.view.bounds
        self.view.layer.insertSublayer(gradientLayer, below: tableView.layer)
        styleGradient()

    }
    
    func styleTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = collection.color.subtitleColor
    }
    
    func styleGradient() {
        
        var colorRefArray = [CGColorRef]()
        
        for color in collection.color.backgroundColors {
            
            colorRefArray.append(color.CGColor as CGColorRef)
        }
        
        if colorRefArray.count == 1 {
            colorRefArray.append(colorRefArray[0])

        }
        
        gradientLayer.colors = colorRefArray
        gradientLayer.locations = [0.25, 1.0]
    }
    
    // MARK: - IBActions

    @IBAction func shareButtonPressed(sender: AnyObject) {
        
        print("Test")
        
        let fullFrame = CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, tableView.contentSize.height)
        tableView.frame = fullFrame
        
        UIGraphicsBeginImageContext(tableView.bounds.size);

        tableView.layer.renderInContext(UIGraphicsGetCurrentContext()!)
        
        let screenshot = UIGraphicsGetImageFromCurrentImageContext()
        
        let data = UIImagePNGRepresentation(screenshot)
        
        UIGraphicsEndImageContext()
                
        let messageComposeVC = MFMessageComposeViewController()
        messageComposeVC.messageComposeDelegate = self
        
        messageComposeVC.addAttachmentData(data!, typeIdentifier: "image/png", filename: "My Image.png")
        presentViewController(messageComposeVC, animated: true, completion: nil)

        
        //messageComposeVC.body = image
        
        view.layoutIfNeeded()
        
//        CGRect frame = _tableView.frame;
//        frame.size.height = _tableView.contentSize.height;//the most important line
//        _tableView.frame = frame;
        
//        UIGraphicsBeginImageContext(_tableView.bounds.size);
//        [_tableView.layer renderInContext:UIGraphicsGetCurrentContext()];
//        UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
//        UIGraphicsEndImageContext();
//        
//        NSData * data = UIImagePNGRepresentation(image);
    }
    
    func messageComposeViewController(controller: MFMessageComposeViewController!, didFinishWithResult result: MessageComposeResult) {
        controller.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        
        if let inEditingMode = inEditingMode {
            self.inEditingMode = !inEditingMode
        }
        
        doneBarButton = createBarButton(.done)
        navigationController?.navigationItem.rightBarButtonItems = [shareBarButton, doneBarButton]
        
        
        let cell = tableView.dequeueReusableCellWithIdentifier("AddItemCell") as! AddItemTableViewCell
        cell.delegate = self
        cell.configureCell()
        
        
        let colorPickerIndex = NSIndexPath(forRow: 2, inSection: 0)
        
        tableView.beginUpdates()
        tableView.insertRowsAtIndexPaths([colorPickerIndex], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        self.inEditingMode = false
        
        editBarButton = createBarButton(.edit)
        sortBarButton = createBarButton(.sort)
        navigationController?.navigationItem.rightBarButtonItems = [shareBarButton, sortBarButton, editBarButton]
        
        let colorPickerIndex = NSIndexPath(forRow: 2, inSection: 0)
        
        tableView.beginUpdates()
        tableView.deleteRowsAtIndexPaths([colorPickerIndex], withRowAnimation: .Automatic)
        tableView.endUpdates()
    }
    
    @IBAction func sortButtonPressed(sender: UIBarButtonItem) {
        
        performSegueWithIdentifier("PresentSort", sender: self)
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let controller = segue.destinationViewController as? DescriptionViewController {
            
            controller.delegate = self

            if let _ = sender as? TitleCell {
                controller.context = .title
                controller.providedDescription = collection.name

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
        
        var action = Selector("")
        var title: String
        
        switch barButtonType {
            
            case .done:
                action =  Selector("doneButtonPressed:")
                title = "Done"
                break
            case .edit:
                action = Selector("editButtonPressed:")
                title = "Edit"
                break
            case .sort:
                action = Selector("sortButtonPressed:")
                title = "Sort"
            break
        }
        
        let barButton = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.Plain, target: self, action: action)
        
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

extension ItemsViewController: DescriptionViewControllerDelegate {
    
    func newTitle(text: String) {
        collection.name = text
        tableView.reloadData()
        
        if text != "" {
            doneBarButton.enabled = true
        } else {
            doneBarButton.enabled = false
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
        styleGradient()
        tableView.separatorColor = collection.color.subtitleColor
    }
}

extension ItemsViewController: AddItemTableViewCellDelegate {
    
    func createdNewItemWithText(text: String) {
        
        let item = ItemModel(string: text)
        collection.items.append(item)
        tableView.reloadData()
    }
}

// MARK: - UITableViewDelegate

extension ItemsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if indexPath.section == 0 && indexPath.row == 2 {
            tableView.deselectRowAtIndexPath(indexPath, animated: false)

        } else {
            tableView.deselectRowAtIndexPath(indexPath, animated: true)
 
        }
    }
}

// MARK: - UITableViewDataSource

extension ItemsViewController: UITableViewDataSource {
    
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
                    cell.label.textColor = .lightGrayColor()
                    
                } else {
                    cell.userInteractionEnabled = false
                    cell.accessoryType = .None
                    cell.label.textColor = collection.color.titleColor

                }
                
                if collection.name != "" {
                    
                    cell.label.text = collection.name
                    cell.label.textColor = collection.color.titleColor
                    
                } else {
                    cell.label.text = "Title"
                    cell.label.textColor = .lightGrayColor()
                    
                }
//                if inEditingMode == nil {
//                    cell.textView.becomeFirstResponder()
//                    cell.configureCell(nil, enableEditing: inEditingMode)
//                    
//                } else {
//                    cell.configureCell(collection.name, enableEditing: inEditingMode)
//                }
                
                return cell
                
            } else if indexPath.row == 2 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("ColorCell", forIndexPath: indexPath) as! ColorCell
                cell.delegate = self
                cell.configureCell()
                cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("DescriptionCell", forIndexPath: indexPath) as! DescriptionCell
                cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
                
                if inEditingMode == nil || inEditingMode == true {
                    
                    cell.userInteractionEnabled = true
                    cell.accessoryType = .DisclosureIndicator
                    cell.label.text = "Description"
                    cell.label.textColor = .lightGrayColor()
                    
                } else {
                    cell.userInteractionEnabled = false
                    cell.accessoryType = .None
                    cell.label.textColor = collection.color.subtitleColor
                }
                
                if collection.descriptionString != "" {
                    
                    cell.label.text = collection.descriptionString
                    cell.label.textColor = collection.color.subtitleColor

                } else {
                    cell.label.text = "Description"
                    cell.label.textColor = .lightGrayColor()

                }

                
                return cell
            }
            
        } else {
            
            let item = collection.items[indexPath.row]
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ItemTableViewCell

            cell.numberLabel.text = "\(indexPath.row + 1)"
            cell.titleLabel.text = item.text
            cell.titleLabel.textColor = collection.color.titleColor
            
            cell.layoutMargins = UIEdgeInsetsZero;
            if collection.sorted {
                
                cell.numberLabelWidthConstraint.constant = 40
                cell.numberLabel.hidden = false
                cell.numberLabel.textColor = collection.color.backgroundColors.first
                
                cell.numberImageView.hidden = false
                cell.numberImageView.backgroundColor = collection.color.titleColor
                
            } else {
                cell.numberLabelWidthConstraint.constant = 0
                cell.numberLabel.hidden = true
                cell.numberImageView.hidden = true

            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        if section == 0 {
            return nil
        }
        
        
        
        return addItemsHeaderView
//        if inEditingMode == nil || inEditingMode == true {
//            let cell = tableView.dequeueReusableCellWithIdentifier("AddItemCell") as! AddItemTableViewCell
//            cell.delegate = self
//            cell.configureCell()
//            return cell
//        } else {
//            return nil
//        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == 0 {
            return 0
        }
        if inEditingMode == nil || inEditingMode == true {
            return 32
        } else {
            return 32
        }
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        if editingStyle == .Delete {
            collection.items.removeAtIndex(indexPath.row)
            tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
        }
    }
}
