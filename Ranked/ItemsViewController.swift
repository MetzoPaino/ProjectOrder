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
    
//    weak var delegate: CollectionTitleCellDelegate?
    
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

protocol ItemsViewControllerDelegate: class {
    func sortingFinished()
}


class ItemsViewController: UIViewController {

    @IBOutlet weak var sortBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: ItemsViewControllerDelegate?

    var collection = CollectionModel(name: "", description: "", category: .none, dateCreated: NSDate(), color: .redColor())
    
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
            
            let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editButtonPressed:")
            navigationController?.navigationItem.rightBarButtonItems = [sortBarButton, editButton]

        } else {
            let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneButtonPressed:")
            navigationController?.navigationItem.rightBarButtonItems = [sortBarButton, doneButton]
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
        
    }
    
    func styleGradient() {
        
        let color1 = UIColor.whiteColor().CGColor as CGColorRef
        let color2 = collection.color.CGColor as CGColorRef
        gradientLayer.colors = [color1, color2]
        gradientLayer.locations = [0.25, 1.0]
    }
    
    // MARK: - IBActions

    @IBAction func editButtonPressed(sender: UIBarButtonItem) {
        
        if let inEditingMode = inEditingMode {
            self.inEditingMode = !inEditingMode
        }
        
        let doneButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Done, target: self, action: "doneButtonPressed:")
        navigationController?.navigationItem.rightBarButtonItems = [sortBarButton, doneButton]
        
        tableView.reloadData()
    }
    
    @IBAction func doneButtonPressed(sender: UIBarButtonItem) {
        
        self.inEditingMode = false
        
        let editButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Edit, target: self, action: "editButtonPressed:")
        navigationController?.navigationItem.rightBarButtonItems = [sortBarButton, editButton]
        
        tableView.reloadData()
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if let controller = segue.destinationViewController as? DescriptionViewController {
            
            controller.delegate = self
            controller.providedDescription = collection.descriptionString
        } else if let navigationController = segue.destinationViewController as? UINavigationController, controller = navigationController.topViewController as? SortingViewController {
        
            controller.itemArray = collection.items
            controller.delegate = self
        }
    }
}

extension ItemsViewController: DescriptionViewControllerDelegate {
    
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
        
        switch index {
            
        case 0:
            collection.color = .orangeColor()
            break
        case 1:
            collection.color = .redColor()
            break
        case 2:
            collection.color = .magentaColor()
            break
        case 3:
            collection.color = .blueColor()
            break
        case 4:
            collection.color = .yellowColor()
            break
        case 5:
            collection.color = .purpleColor()
            break
        case 6:
            collection.color = .cyanColor()
            break
        case 7:
            collection.color = .greenColor()
            break
        default:
            break
        }
        styleGradient()
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
                
                if inEditingMode == nil {
                    cell.textView.becomeFirstResponder()
                    cell.configureCell(nil, enableEditing: inEditingMode)
                    
                } else {
                    cell.configureCell(collection.name, enableEditing: inEditingMode)
                }
                
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
            cell.layoutMargins = UIEdgeInsetsZero;
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
