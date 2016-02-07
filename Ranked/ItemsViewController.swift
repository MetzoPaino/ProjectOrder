//
//  ItemsViewController.swift
//  Ranked
//
//  Created by William Robinson on 06/02/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class TitleCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: CollectionTitleCellDelegate?
    
    let textViewValues = (color: UIColor.blackColor(), placeholderColor: UIColor.lightGrayColor(), placeholderText: "Title")

    func configureCell(title: String?, enableEditing: Bool?) {
        
        if let enableEditing = enableEditing {
            
            textView.userInteractionEnabled = enableEditing
            
        } else {
            
            textView.userInteractionEnabled = true
        }
        
        if title != nil {
            textView.text = title
            textView.textColor = textViewValues.color

        } else {
            textView.text = textViewValues.placeholderText
            textView.textColor = textViewValues.placeholderColor
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
        }
    }
}

class DescriptionCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
    
    func configureCell() {
    }
}

protocol AddItemTableViewCellDelegate: class {
    func createdNewItemWithText(text: String)
}


class AddItemTableViewCell: UITableViewCell {
    
    @IBOutlet weak var textField: UITextField!
    
    weak var delegate: AddItemTableViewCellDelegate?
    
    func configureCell() {
        
        textField.delegate = self
    }
    
}

class ItemsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var collection = CollectionModel(name: "", description: "", category: .none, dateCreated: NSDate())
    
    var inEditingMode: Bool?

    // MARK: - Load View

    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
        styleTableView()
    }

    // MARK: - Style View
    
    func styleView() {
        
        if inEditingMode != nil {
            
            let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editButtonPressed:")
            navigationController?.navigationItem.rightBarButtonItem = editButton

        } else {
            let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneButtonPressed:")
            navigationController?.navigationItem.rightBarButtonItem = doneButton
        }
    }
    
    func styleTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - IBActions

    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        
        if let inEditingMode = inEditingMode {
            self.inEditingMode = !inEditingMode
        }
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneButtonPressed:")
        navigationController?.navigationItem.rightBarButtonItem = doneButton
        
        tableView.reloadData()
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        self.inEditingMode = false
        
        let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editButtonPressed:")
        navigationController?.navigationItem.rightBarButtonItem = editButton
        
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let controller = segue.destinationViewController as? DescriptionViewController {
            
            controller.delegate = self
            controller.providedDescription = collection.descriptionString
        }
    }
}

extension ItemsViewController: DescriptionViewControllerDelegate {
    
    func newDescription(text: String) {
        collection.descriptionString = text
        tableView.reloadData()
    }
}

extension AddItemTableViewCell: UITextFieldDelegate {
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        
        textField.resignFirstResponder()
        
        let string = textField.text! as NSString
        
        if string.length > 0 {
            self.delegate?.createdNewItemWithText(textField.text!)
            textField.text = ""
        }
        return true
    }
}

extension ItemsViewController: UITableViewDelegate {
}

extension ItemsViewController: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if section == 0 {
            return 2

        } else {
            return collection.items.count
        }
        
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if indexPath.section == 0 {
            
            if indexPath.row == 0 {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("TitleCell", forIndexPath: indexPath) as! TitleCell
                
                
                if inEditingMode == nil {
                    cell.textView.becomeFirstResponder()
                    cell.configureCell(nil, enableEditing: inEditingMode)
                    
                } else {
                    cell.configureCell(collection.name, enableEditing: inEditingMode)
                }
                
                return cell
                
            } else {
                
                let cell = tableView.dequeueReusableCellWithIdentifier("DescriptionCell", forIndexPath: indexPath) as! DescriptionCell
                
                if inEditingMode == nil || inEditingMode == true {
                    
                    cell.userInteractionEnabled = true
                    cell.accessoryType = .DisclosureIndicator
                    cell.label.text = "Description"
                    
                } else {
                    cell.userInteractionEnabled = false
                    cell.accessoryType = .None
                    cell.label.textColor = .blackColor()
                }
                
                if collection.descriptionString != "" {
                    
                    cell.label.text = collection.descriptionString
                    cell.label.textColor = .blackColor()

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
            
            if collection.sorted {
                
                cell.numberLabelWidthConstraint.constant = 40
                cell.numberLabel.hidden = false
                
            } else {
                cell.numberLabelWidthConstraint.constant = 0
                cell.numberLabel.hidden = true
            }
            return cell
        }
    }
    
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        
        if section == 0 {
            return nil
        }
        if inEditingMode == nil || inEditingMode == true {
            let cell = tableView.dequeueReusableCellWithIdentifier("AddItemCell") as! AddItemTableViewCell
//            cell.delegate = self
            cell.configureCell()
            return cell
        } else {
            return nil
        }

    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        
        if section == 0 {
            return 0
        }
        if inEditingMode == nil || inEditingMode == true {
            return 48 + 32
        } else {
           return 0
        }
    }
}
