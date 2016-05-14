//
//  AddListsViewController.swift
//  Project Order
//
//  Created by William Robinson on 14/05/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol AddListsViewControllerDelegate: class {
    func finishedPickingCollections(collections: [CollectionModel])
}

class AddListsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var doneButton: UIButton!

    var premadeCollections = createPreMadeCollectionsArray()
    var userCollections = [CollectionModel]()
    var usedRecordNames = [String]()
    var selectedArray = [Bool]()
    
    weak var delegate: AddListsViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        styleView()
        styleTableView()
        
        usedRecordNames = createArrayOfUsedPremadeCollectionRecordNames()
        
        premadeCollections.sortInPlace( { $0.name < $1.name })
        
        for _ in premadeCollections {
            selectedArray.append(false)
        }
    }
    
    func styleView() {
        
        doneButton.layer.cornerRadius = 48 / 2
        
        doneButton.layer.shadowColor = UIColor.blackColor().CGColor;
        doneButton.layer.shadowOpacity = 0.25
        doneButton.layer.shadowRadius = 2
        doneButton.layer.shadowOffset = CGSizeMake(0.0, 2.0)
        doneButton.layer.masksToBounds = false
        
        doneButton.backgroundColor = .disabledColor()
        doneButton.userInteractionEnabled = false
        doneButton.setImage(UIImage(named: "Tick")?.imageWithRenderingMode(.AlwaysTemplate), forState: .Normal)
        doneButton.tintColor = .backgroundColor()
    }

    func styleTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = .backgroundColor()
        tableView.backgroundColor = .backgroundColor()
    }
    
    func createArrayOfUsedPremadeCollectionRecordNames() -> [String] {
        
        var usedRecordNames = [String]()
        
        for collection in userCollections {
            
            usedRecordNames.append(collection.record.recordID.recordName)
        }
        
        return usedRecordNames
    }
    
    @IBAction func doneButtonPressed(sender: UIButton) {
        
        var pickedCollections = [CollectionModel]()
        
        for (index, bool) in selectedArray.enumerate() {
            
            if bool == true {
                pickedCollections.append(premadeCollections[index])
            }
        }
        
        self.delegate?.finishedPickingCollections(pickedCollections)
        self.navigationController?.popViewControllerAnimated(true)
    }
}

extension AddListsViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if selectedArray[indexPath.row] == true {
            selectedArray[indexPath.row] = false
        } else {
            selectedArray[indexPath.row] = true
        }
        tableView.reloadRowsAtIndexPaths([indexPath], withRowAnimation: .None)
        
        if selectedArray.contains(true) {
            
            UIView.animateWithDuration(0.25, animations: {
                
                self.doneButton.backgroundColor = .secondaryColor()
                self.doneButton.userInteractionEnabled = true
                self.doneButton.tintColor = .whiteColor()
            })
        } else {
            
            UIView.animateWithDuration(0.25, animations: {
                
                self.doneButton.backgroundColor = .disabledColor()
                self.doneButton.userInteractionEnabled = false
                self.doneButton.tintColor = .backgroundColor()
            })
        }
    }
}

extension AddListsViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return premadeCollections.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! LabelCell
        cell.label.text = premadeCollections[indexPath.row].name
        
        cell.selected = selectedArray[indexPath.row]

        if cell.selected {
            cell.backgroundColor = .secondaryColor()
        } else {
            cell.backgroundColor = .whiteColor()
        }
        
        cell.userInteractionEnabled = true;
        
        for string in usedRecordNames {
            
            if string.containsString(premadeCollections[indexPath.row].name.trim()) {
                cell.backgroundColor = .disabledColor()
                cell.userInteractionEnabled = false;
                break
            }
        }
        return cell
    }
}