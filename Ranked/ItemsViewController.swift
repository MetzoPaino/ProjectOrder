//
//  ItemsViewController.swift
//  Ranked
//
//  Created by William Robinson on 06/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit
import MessageUI
import CloudKit

protocol ItemsViewControllerDelegate: class {
    func sortingFinished(collection: CollectionModel)
    func collectionUpdated(_ collection:CollectionModel, new: Bool)
    func deleteItemFromCloudKit(recordID: CKRecordID)
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
    case padding
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
    
    var indexPathToEdit: IndexPath?
    
    let tapGesture = UITapGestureRecognizer()
    
    let editingCellOrder = [CellType.title, CellType.description, CellType.addItem]
    //let editingCellOrder = [CellType.title, CellType.description, CellType.addItem]

    var displayCellOrder = [CellType]()

    typealias AssociatedObject = CollectionModel
    var collection: CollectionModel!
    
    let imagePicker = UIImagePickerController()
    
    var itemImage: UIImage?
    
    // MARK: - Load View
    
    func newItem() {
        self.tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assertDependencies()

        if collection.sorted == true {
            collection.sortCollection(sortType: .score)
        } else {
            collection.sortCollection(sortType: .date)
        }
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .photoLibrary
        imagePicker.navigationBar.tintColor = .primaryColor()
        
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(ItemsViewController.receivedKeyboardNotification(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)

        tapGesture.addTarget(self, action: #selector(ItemsViewController.receivedGestureNotification(_:)))
        styleView()
        styleTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func inject(_ collection: AssociatedObject) {
        self.collection = collection
    }
    
    func assertDependencies() {
        assert(collection != nil)
    }

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
        
        sortButton.tintColor = .white()
        sortButton.layer.cornerRadius = self.sortButtonHeightConstraint.constant / 2
        sortButton.setImage(UIImage(named: "GreaterThan")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
//        sortButton.imageEdgeInsets = UIEdgeInsetsMake(0, 4, 0, 0)
        sortButton.backgroundColor = .primaryColor()
        
        sortButton.layer.shadowColor = UIColor.black().cgColor;
        sortButton.layer.shadowOpacity = 0.25
        sortButton.layer.shadowRadius = 2
        sortButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
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
        tableView.backgroundColor = .white()
        tableView.separatorColor = .backgroundColor()
        
    }
    
    // MARK: - IBActions
    
    @IBAction func addImageButtonPressed(_ sender: UIButton) {
        imagePicker.view.tag = 1
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addItemImageButtonPressed(_ sender: UIButton) {
        imagePicker.view.tag = 2
        present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func addImageForItemButtonPressed(_ sender: UIButton) {
        
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let photoAction = UIAlertAction(title: "Choose Photo", style: .default, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.imagePicker.view.tag = sender.tag + 10
            self.present(self.imagePicker, animated: true, completion: nil)

        })
        
        let deleteAction = UIAlertAction(title: "Remove Photo", style: .destructive, handler: {
            (alert: UIAlertAction!) -> Void in
            
            self.collection.items[sender.tag].image = nil
            self.tableView.beginUpdates()
            
            let indexPath = IndexPath(item: sender.tag, section: 1)
            
            self.tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
            self.tableView.endUpdates()
        })
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (alert: UIAlertAction!) -> Void in
            
        })
        
        actionSheet.addAction(photoAction)
        actionSheet.addAction(deleteAction)
        actionSheet.addAction(cancelAction)

        present(actionSheet, animated: true, completion: nil)
        
       // parent!.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func shareButtonPressed(_ sender: UIBarButtonItem) {
        
        tableView.backgroundColor = UIColor.white()
        
        let fullFrame = CGRect(x: tableView.frame.origin.x, y: tableView.frame.origin.y, width: tableView.frame.size.width, height: tableView.contentSize.height)
        tableView.frame = fullFrame
        tableView.scrollToRow(at: IndexPath(row: 0, section: 0), at: UITableViewScrollPosition.top, animated: false)
        
        //        UIGraphicsBeginImageContext(tableView.contentSize);
        UIGraphicsBeginImageContextWithOptions(tableView.contentSize, false, 0.0)
        
        tableView.layer.render(in: UIGraphicsGetCurrentContext()!)
        
        //        tableView.drawViewHierarchyInRect(tableView.frame, afterScreenUpdates: false)
        
        let image:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext();
        
        tableView.backgroundColor = .clear()
        
        let activityViewController = UIActivityViewController(activityItems: [image], applicationActivities: nil)
        navigationController?.present(activityViewController, animated: true) {
            // ...
        }
        tableView.layoutIfNeeded()
    }
    
    @IBAction func editButtonPressed(_ sender: UIBarButtonItem) {
        
        if let inEditingMode = inEditingMode {
            self.inEditingMode = !inEditingMode
        }
        
        doneBarButton = createBarButton(.done)
        navigationItem.rightBarButtonItems = [doneBarButton]
        
        let addItemIndex = IndexPath(row: 2, section: 0)
        
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        tableView.insertRows(at: [addItemIndex], with: .fade)
        tableView.endUpdates()
        tableView.reloadData()
        animateSortButton(false)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIBarButtonItem) {
        
        inEditingMode = false
        
        editBarButton = createBarButton(.edit)
        shareBarButton = createBarButton(.share)
        navigationItem.rightBarButtonItems = [shareBarButton, editBarButton]
        
        let addItemIndex = IndexPath(row: 2, section: 0)
        
        if let addItemCell = tableView.cellForRow(at: addItemIndex) as? AddItemTableViewCell {
            
            _ = addItemCell.textFieldShouldReturn(addItemCell.textField)
        }
        
        tableView.beginUpdates()
        tableView.reloadSections(IndexSet(integer: 0), with: .fade)
        tableView.deleteRows(at: [addItemIndex], with: .fade)
        tableView.endUpdates()
        tableView.reloadData()
        
        animateSortButton(true)
        
        if newCollection == true {
            self.delegate?.collectionUpdated(collection, new: true)
            newCollection = false
        } else {
            self.delegate?.collectionUpdated(collection, new: false)
        }
    }
    
    // MARK: - Navigation
    
    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
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
            
        } else if let navigationController = segue.destinationViewController as? UINavigationController, let controller = navigationController.topViewController as? SortingViewController {
            
            navigationController.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
            navigationController.navigationBar.shadowImage = nil
            navigationController.navigationBar.isTranslucent = false
            navigationController.view.backgroundColor = UIColor.white()
            navigationController.navigationBar.tintColor = .black()
        
            if let image = collection.image {
                controller.image = image
            }
            
            controller.originallySorted = collection.sorted
            controller.itemArray = collection.items
            controller.delegate = self
        }
    }
    
    // MARK: - Internal
    
    func createBarButton(_ barButtonType: BarButtonType) -> UIBarButtonItem {
        
        var action: Selector
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
            
            let barButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.action, target: self, action: action)
            barButton.tintColor = .primaryColor()
            return barButton
            
        } else {
            
            let barButton = UIBarButtonItem(title: title, style: UIBarButtonItemStyle.plain, target: self, action: action)
            barButton.tintColor = .primaryColor()

            if barButtonType == .done {
                
                if collection.name != "" {
                    barButton.isEnabled = true
                } else {
                    barButton.isEnabled = false
                }
            }
            
            return barButton
        }
    }
    
    @IBAction func sortBarButtonPressed(_ sender: UIButton) {
        
        performSegue(withIdentifier: "PresentSort", sender: self)
    }
}

// MARK: - Notifications
private typealias Notifications = ItemsViewController
extension Notifications {
    
    func receivedKeyboardNotification(_ notification: Notification) {
        
        if notification.name == NSNotification.Name.UIKeyboardDidShow {
            
            view.addGestureRecognizer(tapGesture)
            tableView.scrollToRow(at: IndexPath(row: 2, section: 0), at: .middle, animated: true)

        }
    }
    
    func receivedGestureNotification(_ gesture: UITapGestureRecognizer) {
        
        view.removeGestureRecognizer(tapGesture)
        view.endEditing(true)
    }
}

// MARK: - Animations

extension ItemsViewController {
    
    func animateSortButton(_ onScreen: Bool) {
        
        // Animate on or off screen. If there is nothing to sort, never go on screen
        
        var constant = 0 - 16 - sortButtonHeightConstraint.constant
        var time = 1.0
        
        if onScreen && collection.items.count > 1 {
            
            constant = 16
            time = 0.5
        }
        
        UIView.animate(withDuration: time, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1.0, options: UIViewAnimationOptions(), animations: { () -> Void in
            
            self.sortButtonBottomConstraint.constant = constant
            self.view.layoutIfNeeded()
            
            }, completion: { (complete: Bool) -> Void in
        })
    }
}

// MARK: - Description Delegate
private typealias DescriptionDelegate = ItemsViewController
extension DescriptionDelegate: DescriptionViewControllerDelegate {
    
    func newTitle(_ text: String) {
        collection.name = text
        tableView.reloadData()
        
        if text != "" {
            doneBarButton.isEnabled = true
        } else {
            doneBarButton.isEnabled = false
        }
    }
    
    func newItem(_ text: String) {
        
        if let indexPath = indexPathToEdit {
            
            tableView.beginUpdates()
            collection.items[(indexPath as NSIndexPath).row].text = text
            tableView.reloadRows(at: [indexPath], with: .fade)
            tableView.endUpdates()

            indexPathToEdit = nil
        }
    }
    
    func newDescription(_ text: String) {
        collection.descriptionString = text
        tableView.reloadData()
    }
}

extension ItemsViewController: SortingViewControllerDelegate {
    
    func sortingFinished(_ items: [ItemModel]) {
        
        collection.sorted = true
        
//        for item in collection.items {
//            
//            item.sorted = true
//        }
        collection.items = items.sorted(isOrderedBefore: { $0.score > $1.score })
        
        tableView.reloadData()
        self.delegate?.sortingFinished(collection: collection)
    }
    
    func sortingCancelled() {
        
        //collection.sorted = false
    }
}

// MARK: - AddItemTableViewCell Delegate
private typealias AddItemDelegate = ItemsViewController
extension AddItemDelegate: AddItemTableViewCellDelegate {
    
    func createdNewItemWithText(_ text: String) {
        
        // Inserting causes a crash, but would look nicer
        let item = ItemModel(string: text, dateCreated: Date())
        
        if let image = itemImage {
            item.image = image
            itemImage = nil
        }
        collection.items.insert(item, at: 0)
        tableView.reloadData()
        
        let addItemIndex = IndexPath(row: 3, section: 0)
        if let cell = tableView.cellForRow(at: addItemIndex) as? AddItemTableViewCell {
            cell.textField.becomeFirstResponder()
        }
    }
}

// MARK: - TableViewDelegate
private typealias TableViewDelegate = ItemsViewController
extension TableViewDelegate: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? AddItemTableViewCell {
            
            cell.textField.becomeFirstResponder()
        }
        
        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? TitleCell {
            
            cell.label.textColor = .white()
            
        } else if let cell = tableView.cellForRow(at: indexPath) as? DescriptionCell {
            
            cell.label.textColor = .white()
        }
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? TitleCell {
            
            cell.label.textColor = .backgroundColor()
            
        } else if let cell = tableView.cellForRow(at: indexPath) as? DescriptionCell {
            
            cell.label.textColor = .backgroundColor()
        }
    }
    
    @objc(tableView:canEditRowAtIndexPath:) func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        
        if (indexPath as NSIndexPath).section == 0 {
            return false
        } else {
            
            if !collection.premade {
                return true
            } else {
                return false
            }
        }
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        
        if (indexPath as NSIndexPath).section == 0 {
            return nil
        } else {
            
            var actionArray = [UITableViewRowAction]()
            
            if !collection.premade {
            
                let editAction = UITableViewRowAction(style: .normal, title: "Edit") { (rowAction:UITableViewRowAction, indexPath:IndexPath) -> Void in
                
                    self.indexPathToEdit = indexPath
                    self.performSegue(withIdentifier: "ShowItem", sender: tableView.cellForRow(at: indexPath))
                
                }
                editAction.backgroundColor = UIColor.secondaryColor()
                actionArray.append(editAction)
            
            
                let deleteAction = UITableViewRowAction(style: .default, title: "Delete") { (rowAction:UITableViewRowAction, indexPath:IndexPath) -> Void in
                    
                    // Delete, we shouldn't be initialising CloudKitManager every time
                    //CloudKitManager().deleteFromCloudKit(self.collection.items[(indexPath as NSIndexPath).row].record.recordID)
                    
                    self.delegate?.deleteItemFromCloudKit(recordID: self.collection.items[(indexPath as NSIndexPath).row].record.recordID)
                    self.collection.items.remove(at: (indexPath as NSIndexPath).row)
                    tableView.deleteRows(at: [indexPath], with: .automatic)
                    tableView.reloadData()
                }
                deleteAction.backgroundColor = UIColor.warningColor()
                actionArray.insert(deleteAction, at: 0)

                return actionArray
            } else {
                return nil
            }
        }
    }
}

private typealias TableViewDataSource = ItemsViewController
extension TableViewDataSource: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        
        return 3
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            
            displayCellOrder = [CellType]()
            
            var cellCounter = 0
            
            if collection.image != nil {

                cellCounter = cellCounter + 1
                displayCellOrder.append(CellType.image)
            }
            
            cellCounter = cellCounter + 1 // Title cell
            displayCellOrder.append(CellType.title)

            if inEditingMode == nil || inEditingMode == true {
                displayCellOrder = editingCellOrder
                return editingCellOrder.count
            } else {
                if collection.descriptionString != "" {
                    cellCounter = cellCounter + 1
                    displayCellOrder.append(CellType.description)
                }
//                cellCounter = cellCounter + 1
//                displayCellOrder.append(CellType.padding)
            }
            
            return cellCounter
            
        } else if section == 1 {
            
            return collection.returnArrayOfItems(sorted: true).count
            
        } else {
            
            return collection.returnArrayOfItems(sorted: false).count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).section == 0 {
            
            var editing = false
            
            if inEditingMode == nil || inEditingMode == true {
                editing = true
            }
            
            if displayCellOrder[(indexPath as NSIndexPath).row] == CellType.image {
                return createImageCell(collection.image, indexPath: indexPath, inEditingMode: editing)
            } else if displayCellOrder[(indexPath as NSIndexPath).row] == CellType.title {
                return createTitleCell(collection.name, indexPath: indexPath, inEditingMode: editing)
            } else if displayCellOrder[(indexPath as NSIndexPath).row] == CellType.addItem {
                return createAddItemCell(indexPath)
            } else if displayCellOrder[(indexPath as NSIndexPath).row] == CellType.description {
                return createDescriptionCell(collection.descriptionString, indexPath: indexPath, inEditingMode: editing)
            } else {
                return createPaddingCell(indexPath: indexPath)
            }
            
        } else if (indexPath as NSIndexPath).section == 1 {
            
            // Sorted cells
            
            let item = collection.returnArrayOfItems(sorted: true)[(indexPath as NSIndexPath).row]
            
            if inEditingMode == true {
                
                return self.createUnsortedEditingCell(indexPath: indexPath, item: item)
            } else {
                return self.createSortedCell(indexPath: indexPath, item: item)
            }
            
//            let cell = tableView.dequeueReusableCell(withIdentifier: "UnsortedCell", for: indexPath) as! UnsortedItemTableViewCell
//            
//            cell.numberLabel.text = "\((indexPath as NSIndexPath).row + 1)"
//            cell.titleLabel.text = item.text
//            cell.layoutMargins = UIEdgeInsetsMake(0, 64, 0, 0);
//            
//            cell.circleImageViewWidthConstraint.constant = 48
//
//            cell.configureCell(true)
//            
//            if inEditingMode == true {
//                
//                if let image = item.image {
//                    cell.circleImageView.image = image
//                    
//                } else {
//                    cell.circleImageView.image = UIImage()
//                }
//                
//                cell.circleImageViewWidthConstraint.constant = 48
//                cell.circleImageViewLeadingConstraint.constant = 28
//                cell.circleImageView.backgroundColor = .disabledColor()
//
//                cell.addButton.isHidden = false
//                cell.addButton.imageView!.image = UIImage(named: "PlusButton" )!.withRenderingMode(.alwaysTemplate)
//                cell.addButton.imageView!.tintColor = .white()
//                cell.addButton.tag = indexPath.row
//                
//                cell.numberLabel.text = ""
//                
//                cell.titleLabelLeadingConstraint.constant = 8
//                cell.circleImageViewLeadingConstraint.constant = 16
//                
//            } else {
//                
//                cell.addButton.isHidden = true
//
//                if let image = item.image {
//                    cell.circleImageViewWidthConstraint.constant = 48
//                    cell.circleImageViewLeadingConstraint.constant = 28
//                    cell.circleImageView.image = image
//                    
//                } else {
//                    cell.circleImageViewWidthConstraint.constant = 0
//                    cell.circleImageViewLeadingConstraint.constant = 28
//                    cell.circleImageView.image = UIImage()
//                }
//                
//                switch (indexPath as NSIndexPath).row {
//                case 0:
//                    cell.numberLabel.textColor = .primaryColor()
//                case 1:
//                    cell.numberLabel.textColor = .secondaryColor()
//                case 2:
//                    cell.numberLabel.textColor = .secondColor()
//                case 3:
//                    cell.numberLabel.textColor = .thirdColor()
//                default:
//                    cell.numberLabel.textColor = .loserColor()
//                }
//            }
//            
//            
//            return cell
            
        } else {
            
            let item = collection.returnArrayOfItems(sorted: false)[(indexPath as NSIndexPath).row]
                        
            if inEditingMode == true {
                
                return self.createUnsortedEditingCell(indexPath: indexPath, item: item)
            } else {
                return self.createUnsortedCell(indexPath: indexPath, item: item)

            }
        }
    }
    
    func createSortedCell(indexPath: IndexPath, item: ItemModel) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UnsortedCell", for: indexPath) as! UnsortedItemTableViewCell
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsetsMake(0, 64, 0, 0);
        
        cell.titleLabel.textColor = .titleColor()
        cell.titleLabel.text = item.text

        cell.numberLabel.text = "\((indexPath as NSIndexPath).row + 1)"
        cell.numberLabel.isHidden = false
        cell.numberLabel.textColor = .white()
        
        // Circle image
        
//        if let image = item.image {
//            
//            cell.circleImageView.isHidden = false
//            cell.circleImageViewWidthConstraint.constant = 48
//            cell.circleImageViewLeadingConstraint.constant = 28
//            cell.circleImageView.backgroundColor = .disabledColor()
//            cell.circleImageView.layer.cornerRadius = cell.circleImageViewWidthConstraint.constant / 2
//            cell.circleImageView.clipsToBounds = true
//            cell.circleImageView.image = image
//            
//            cell.titleLabelLeadingConstraint.constant = 16
//            
//            cell.layoutMargins = UIEdgeInsetsMake(0, 64, 0, 0);
//            
//        } else {
//            
//            cell.circleImageView.isHidden = true
//            cell.circleImageViewWidthConstraint.constant = 0
//            cell.circleImageViewLeadingConstraint.constant = 0
//            
//            cell.titleLabelLeadingConstraint.constant = 28
//            
//            cell.layoutMargins = UIEdgeInsets()
//        }
        
        cell.circleImageView.isHidden = false
        cell.circleImageViewWidthConstraint.constant = 48
        cell.circleImageViewLeadingConstraint.constant = 16
        cell.circleImageView.layer.cornerRadius = cell.circleImageViewWidthConstraint.constant / 2
        cell.circleImageView.clipsToBounds = true

        switch (indexPath as NSIndexPath).row {
        case 0:
            cell.circleImageView.backgroundColor = .first()
        case 1:
            cell.circleImageView.backgroundColor = .second()
        case 2:
            cell.circleImageView.backgroundColor = .third()
        case 3:
            cell.circleImageView.backgroundColor = .fourth()
        case 4:
            cell.circleImageView.backgroundColor = .fifth()
        case 5:
            cell.circleImageView.backgroundColor = .sixth()
        case 6:
            cell.circleImageView.backgroundColor = .seventh()
        case 7:
            cell.circleImageView.backgroundColor = .eighth()
        case 8:
            cell.circleImageView.backgroundColor = .ninth()
        default:
            cell.circleImageView.backgroundColor = .tenth()
        }

        // Add button
        
        cell.addButton.isHidden = true
        return cell

    }
    
    func createUnsortedCell(indexPath: IndexPath, item: ItemModel) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UnsortedCell", for: indexPath) as! UnsortedItemTableViewCell
        cell.selectionStyle = .none

        cell.titleLabel.textColor = .titleColor()
        cell.titleLabel.text = item.text
        cell.titleLabelLeadingConstraint.constant = 16

        cell.numberLabel.text = ""
        cell.numberLabel.isHidden = true

        // Circle image
        
//        if let image = item.image {
//            
//            cell.circleImageView.isHidden = false
//            cell.circleImageViewWidthConstraint.constant = 48
//            cell.circleImageViewLeadingConstraint.constant = 28
//            cell.circleImageView.backgroundColor = .disabledColor()
//            cell.circleImageView.layer.cornerRadius = cell.circleImageViewWidthConstraint.constant / 2
//            cell.circleImageView.clipsToBounds = true
//            cell.circleImageView.image = image
//            
//            cell.layoutMargins = UIEdgeInsetsMake(0, 64, 0, 0);
//            
//        } else {
//            
//            cell.circleImageView.isHidden = true
//            cell.circleImageViewWidthConstraint.constant = 0
//            cell.circleImageViewLeadingConstraint.constant = 0
//            
//            cell.layoutMargins = UIEdgeInsets()
//        }
        
        cell.circleImageView.isHidden = true
        cell.circleImageViewWidthConstraint.constant = 0
        cell.circleImageViewLeadingConstraint.constant = 0
        
        cell.layoutMargins = UIEdgeInsets()
        
        // Add button
        
        cell.addButton.isHidden = true
        
        return cell
    }
    
    func createUnsortedEditingCell(indexPath: IndexPath, item: ItemModel) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "UnsortedCell", for: indexPath) as! UnsortedItemTableViewCell
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsetsMake(0, 64, 0, 0);

        cell.titleLabel.textColor = .titleColor()
        cell.titleLabel.text = item.text
        cell.titleLabelLeadingConstraint.constant = 16

        cell.numberLabel.text = ""
        cell.numberLabel.isHidden = true
        
        // Circle image
        
//        cell.circleImageView.isHidden = false
//        cell.circleImageViewWidthConstraint.constant = 48
//        cell.circleImageViewLeadingConstraint.constant = 16
//        cell.circleImageView.backgroundColor = .disabledColor()
//        cell.circleImageView.layer.cornerRadius = cell.circleImageViewWidthConstraint.constant / 2
//        cell.circleImageView.clipsToBounds = true
//        
//        if let image = item.image {
//            cell.circleImageView.image = image
//            
//        } else {
//            cell.circleImageView.image = UIImage()
//        }
        
        cell.circleImageView.isHidden = true
        cell.circleImageViewWidthConstraint.constant = 0
        cell.circleImageViewLeadingConstraint.constant = 0
        
        cell.layoutMargins = UIEdgeInsets()
        
        // Add button
        
        cell.addButton.isHidden = false
        cell.addButton.imageView!.image = UIImage(named: "PlusButton" )!.withRenderingMode(.alwaysTemplate)
        cell.addButton.imageView!.tintColor = .white()
        cell.addButton.tintColor = .white()
        cell.addButton.tag = indexPath.row
                
        return cell
    }
}

extension ItemsViewController {
    
    func createImageCell(_ image:UIImage?, indexPath:IndexPath, inEditingMode: Bool) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ImageCell", for: indexPath) as! ImageCell
        cell.separatorInset = UIEdgeInsetsMake(0, Helper.largestDeviceSide(), 0, 0);
        
        // Don't need an else, because cell isn't shown if no image
        if let image = image {
            cell.summaryImageView.image = image
        }
        
        if inEditingMode == true && collection.premade == false {
            
            cell.button.isHidden = false
            cell.button.imageView!.image = UIImage(named: "PlusButton" )?.withRenderingMode(.alwaysTemplate)
            cell.button.imageView!.tintColor = .white()
        } else {
            cell.button.isHidden = true
        }

        cell.configureCell()
        
        cell.selectionStyle = .none
        return cell
    }
    
    @objc(tableView:heightForRowAtIndexPath:) func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
//        if (indexPath as NSIndexPath).section == 0 && (indexPath as NSIndexPath).row == 0 {
//            
//            if collection.image != nil || inEditingMode == true || inEditingMode == nil {
//                return 96
//            }
//        }
        
        return UITableViewAutomaticDimension
    }
    
    func createTitleCell(_ text: String, indexPath:IndexPath, inEditingMode: Bool) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "TitleCell", for: indexPath) as! TitleCell
        cell.separatorInset = UIEdgeInsetsMake(0, Helper.largestDeviceSide(), 0, 0);
        
        if inEditingMode == true {
            
            cell.isUserInteractionEnabled = true
            cell.accessoryType = .disclosureIndicator
            cell.label.text = "Title"
            
            if cell.isHighlighted {
                cell.label.textColor = .white()
                
            } else {
                cell.label.textColor = .backgroundColor()
            }
                        
        } else {
            cell.isUserInteractionEnabled = false
            cell.accessoryType = .none
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
    
    func createDescriptionCell(_ text: String, indexPath:IndexPath, inEditingMode: Bool) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "DescriptionCell", for: indexPath) as! DescriptionCell
        cell.separatorInset = UIEdgeInsetsMake(0, Helper.largestDeviceSide(), 0, 0);
        
        if inEditingMode == true {
            
            cell.isUserInteractionEnabled = true
            cell.accessoryType = .disclosureIndicator
            cell.label.text = "Description"
            cell.label.textColor = .backgroundColor()
            
        } else {
            cell.isUserInteractionEnabled = false
            cell.accessoryType = .none
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
    
    func createAddItemCell(_ indexPath:IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddItemCell", for: indexPath) as! AddItemTableViewCell
        cell.delegate = self
        cell.button.imageView!.tintColor = .white()
        cell.button.isUserInteractionEnabled = false
        cell.configureCell()
        
        cell.addImageView.image = UIImage(named: "PlusButton")?.withRenderingMode(.alwaysTemplate)
        cell.addImageView.tintColor = .white()
        
        cell.selectionStyle = .none
        cell.layoutMargins = UIEdgeInsetsMake(0, 64, 0, 0);
        
        return cell
    }
    
    func createPaddingCell(indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "PaddingCell", for: indexPath)
        return cell

    }
}

extension ItemsViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        if let pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            if imagePicker.view.tag >= 10 {
                
                let row = imagePicker.view.tag - 10
                collection.items[row].image = pickedImage
                tableView.beginUpdates()
                
                let indexPath = IndexPath(item: row, section: 2)
                
                tableView.reloadRows(at: [indexPath], with: UITableViewRowAnimation.fade)
//                //tableView.reloadSections(IndexSet(integer: 1), with: .fade)
                tableView.endUpdates()
                
            } else {
                
                if imagePicker.view.tag == 2 {
                    
                    itemImage = pickedImage
                    
                } else {
                    collection.image = pickedImage
                }
            }
        }
        
        dismiss(animated: true) {
            self.imagePicker.view.tag = 0
            self.tableView.reloadData()
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        imagePicker.view.tag = 0
        dismiss(animated: true, completion: nil)
    }
}


