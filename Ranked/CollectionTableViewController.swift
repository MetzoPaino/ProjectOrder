//
//  CollectionTableViewController.swift
//  Ranked
//
//  Created by William Robinson on 16/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class ItemTableViewCell: UITableViewCell {

    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var numberLabelWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var numberLabelTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var titleLabelLeadingConstraint: NSLayoutConstraint!
}
//
//protocol AddItemTableViewCellDelegate: class {
//    func createdNewItemWithText(text: String)
//}
//
//
//class AddItemTableViewCell: UITableViewCell {
//    
//    @IBOutlet weak var textField: UITextField!
//    
//    weak var delegate: AddItemTableViewCellDelegate?
//
//    func configureCell() {
//        
//        textField.delegate = self
//    }
//
//}

//extension AddItemTableViewCell: UITextFieldDelegate {
//    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        
//        textField.resignFirstResponder()
//        
//        let string = textField.text! as NSString
//        
//        if string.length > 0 {
//            self.delegate?.createdNewItemWithText(textField.text!)
//            textField.text = ""
//        }
//        return true
//    }
//}

class CollectionTableViewController: UITableViewController {

    var collection = CollectionModel(name: "", description: "", category: .none, dateCreated: NSDate(), color: ColorTheme(titleColor: .whiteColor(), subtitleColor: .whiteColor(), backgroundColors: [.whiteColor()]))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.leftBarButtonItem = splitViewController?.displayModeButtonItem()
        navigationItem.leftItemsSupplementBackButton = true
        title = collection.name
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()

    }

    // MARK: - IBActions

    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        tableView.setEditing(!tableView.editing, animated: true)
    }

    // MARK: - Table view data source

//    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 0
//    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return collection.items.count
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.row < collection.items.count {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! ItemTableViewCell
            
            let item = collection.items[indexPath.row]
            
            cell.numberLabel.text = "\(indexPath.row + 1)"
            cell.titleLabel.text = item.text
            
            if collection.sorted {
                
                cell.numberLabelWidthConstraint.constant = 40
                cell.numberLabel.hidden = false
                
            } else {
                cell.numberLabelWidthConstraint.constant = 0
                cell.numberLabel.hidden = true
            }
            return cell
        } else {
            
            let cell = tableView.dequeueReusableCellWithIdentifier("Add Cell", forIndexPath: indexPath) as! AddItemTableViewCell
            cell.delegate = self
            cell.configureCell()
            return cell
        }
        

    }
    
    override func tableView(tableView: UITableView, canMoveRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    
    override func tableView(tableView: UITableView, moveRowAtIndexPath sourceIndexPath: NSIndexPath, toIndexPath destinationIndexPath: NSIndexPath) {
        
        if destinationIndexPath.row != sourceIndexPath.row {
            
            let temp = collection.items.removeAtIndex(sourceIndexPath.item)
            collection.items.insert(temp, atIndex: destinationIndexPath.item)

            // Ray Wenderlich example, but doesn't work
//            swap(&collection.items[destinationIndexPath.row], &collection.items[sourceIndexPath.row])
        }
        
        tableView.reloadData()

    }
    
//    override func tableView(tableView: UITableView, didEndEditingRowAtIndexPath indexPath: NSIndexPath) {
//        tableView.reloadData()
//        print("End")
//    }
    
    override func tableView(tableView: UITableView, targetIndexPathForMoveFromRowAtIndexPath sourceIndexPath: NSIndexPath, toProposedIndexPath proposedDestinationIndexPath: NSIndexPath) -> NSIndexPath {
        
        let sourceCell = tableView.cellForRowAtIndexPath(sourceIndexPath) as! ItemTableViewCell
        sourceCell.numberLabel.text = "\(proposedDestinationIndexPath.row)"        
        return proposedDestinationIndexPath;

    }
    
    override func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Add Cell") as! AddItemTableViewCell
        cell.delegate = self
        cell.configureCell()
        return cell
    }

    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 48 + 32
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
        
        let navController = segue.destinationViewController as! UINavigationController
        let controller = navController.topViewController as! SortingViewController
        controller.itemArray = collection.items
        controller.delegate = self
    }

}

extension CollectionTableViewController: SortingViewControllerDelegate {
    
    func sortingFinished(items: [ItemModel]) {
        
        collection.sorted = true
        collection.items = items.sort({ $0.points > $1.points })
        tableView.reloadData()
    }
}

extension CollectionTableViewController: AddItemTableViewCellDelegate {
    
    func createdNewItemWithText(text: String) {
        let item = ItemModel(string: text)
        collection.items.append(item)
//        tableView.beginUpdates()
//        tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: collection.items.count, inSection: 0)], withRowAnimation: UITableViewRowAnimation.Bottom)
//        tableView.endUpdates()
        
//        [tableView beginUpdates];
//        [tableView insertRowsAtIndexPaths:(NSArray *)indexPaths withRowAnimation:(UITableViewRowAnimation)animation];
//        [tableView endUpdates];
        
        tableView.reloadData()
    }
}
