//
//  AddCollectionViewController.swift
//  Ranked
//
//  Created by William Robinson on 17/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol CollectionTitleCellDelegate: class {
    func toggleSaveButtonOn(turnOnSaveButton: Bool)
}

class CollectionTitleCell: UITableViewCell {
    
    @IBOutlet weak var textView: UITextView!
    
    weak var delegate: CollectionTitleCellDelegate?
    
    let titlePlaceholderValues = (text: "Title", color: UIColor.lightGrayColor())
    
    func configureCell() {
        
        textView.delegate = self
        
        textView.text = titlePlaceholderValues.text
        textView.textColor = titlePlaceholderValues.color
        textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
    }
}

extension CollectionTitleCell: UITextViewDelegate {

    
    func textView(textView: UITextView, shouldChangeTextInRange range: NSRange, replacementText text: String) -> Bool {
        
        let oldText = textView.text
        let newText: NSString = (oldText as NSString).stringByReplacingCharactersInRange(range, withString: text)
        
        self.delegate?.toggleSaveButtonOn(newText.length > 0)
        
        // Combine the textView text and the replacement text to
        // create the updated text string
        let currentText:NSString = textView.text
        let updatedText = currentText.stringByReplacingCharactersInRange(range, withString:text)
        
        // If updated text view will be empty, add the placeholder
        // and set the cursor to the beginning of the text view
        if updatedText.isEmpty {
            
            textView.text = titlePlaceholderValues.text
            textView.textColor = titlePlaceholderValues.color
            
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
            
            return false
        }
            
            // Else if the text view's placeholder is showing and the
            // length of the replacement string is greater than 0, clear
            // the text view and set its color to black to prepare for
            // the user's entry
        else if textView.textColor == UIColor.lightGrayColor() && !text.isEmpty {
            textView.text = nil
            textView.textColor = UIColor.blackColor()
        }
        
        return true
    }
    
    func textViewDidChangeSelection(textView: UITextView) {
        
        if textView.textColor == UIColor.lightGrayColor() {
            textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
        }
        
//        if self.view.window != nil {
//            if textView.textColor == UIColor.lightGrayColor() {
//                textView.selectedTextRange = textView.textRangeFromPosition(textView.beginningOfDocument, toPosition: textView.beginningOfDocument)
//            }
//        }
    }
}

protocol AddCollectionViewControllerDelegate: class {
    func addCollectionViewControllerCreatedNewCollectionWithName(name: String, description: String, category: CollectionType)
}

class AddCollectionViewController: UIViewController {

    @IBOutlet weak var cancelButton: UIBarButtonItem!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var addImageButton: UIButton!
    @IBOutlet weak var titleTextView: UITextView!
    @IBOutlet weak var descriptionTextView: UITextView!
    @IBOutlet var textViewCollection: [UITextView]!
    
    weak var delegate: AddCollectionViewControllerDelegate?
    
    let placeholderValues = (text: "Placeholder", color: UIColor.lightGrayColor())
    let titlePlaceholderValues = (text: "Title", color: UIColor.lightGrayColor())
    let descriptionPlaceholderValues = (text: "Description", color: UIColor.lightGrayColor())
    
    let categories = CategoriesManager().categories
    var selectedCategory: CollectionType?
    
    let cellArray = ["TitleCell", "CategoryCell"]
    
    var initialLoad = true

    override func viewDidLoad() {
        super.viewDidLoad()
        styleView()
    }
    
    // MARK: - Style View
    
    func styleView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
    }
    
    // MARK: - IBActions

    @IBAction func cancelButtonPressed(sender: UIBarButtonItem) {
        resignFirstResponder()
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func saveButtonPressed(sender: AnyObject) {
        resignFirstResponder()
        dismissViewControllerAnimated(true) { () -> Void in
            
            let cell = self.tableView.cellForRowAtIndexPath(NSIndexPath(forRow: 0, inSection: 0)) as! CollectionTitleCell
            let text = cell.textView.text
            
            if self.selectedCategory == nil {
                
                self.selectedCategory = .none
            }
            
            self.delegate?.addCollectionViewControllerCreatedNewCollectionWithName(text, description: "", category: self.selectedCategory!)
        }
    }
    
    // MARK: - Navigation
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        
        if segue.destinationViewController.isKindOfClass(CategoriesViewController) {
            
            let controller = segue.destinationViewController as! CategoriesViewController
            controller.delegate = self
        }
    
    }
    
    
}

extension AddCollectionViewController: UITableViewDelegate {
    

}

extension AddCollectionViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return cellArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellType = cellArray[indexPath.row]
        
        if cellType == "CategoryCell" {
            
            let cell = tableView.dequeueReusableCellWithIdentifier(cellType, forIndexPath: indexPath) as! CategoryCell
            
            if selectedCategory != nil {
                
                for category in categories {
                    
                    if category.type == selectedCategory {
                        
                        cell.label.text = "Category: " + category.title
                    }
                }
                
            } else {
                
                cell.label.text = "Pick Category"
            }
            return cell


        } else if cellType == "TitleCell" {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellType, forIndexPath: indexPath) as! CollectionTitleCell
            
            if initialLoad {
                cell.delegate = self
                cell.configureCell()
                cell.textView.becomeFirstResponder()
                initialLoad = false
            }
            return cell

        } else {
            let cell = tableView.dequeueReusableCellWithIdentifier(cellType, forIndexPath: indexPath)
            return cell

        }
    }
}

extension AddCollectionViewController: CollectionTitleCellDelegate {
    
    func toggleSaveButtonOn(turnOnSaveButton: Bool) {
        
        saveButton.enabled = turnOnSaveButton
    }
}

extension AddCollectionViewController: CategoriesViewControllerDelegate {
    
    func selectedCategory(category: CollectionType) {
        selectedCategory = category
        tableView.reloadData()
    }
}