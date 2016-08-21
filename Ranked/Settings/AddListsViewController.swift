//
//  AddListsViewController.swift
//  Project Order
//
//  Created by William Robinson on 14/05/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol AddListsViewControllerDelegate: class {
    func finishedPickingCollections(_ collections: [CollectionModel])
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
        
        premadeCollections.sort( by: { $0.name < $1.name })
        
        for _ in premadeCollections {
            selectedArray.append(false)
        }
    }
    
    func styleView() {
        
        doneButton.layer.cornerRadius = 64 / 2
        
        doneButton.layer.shadowColor = UIColor.black.cgColor
        doneButton.layer.shadowOpacity = 0.25
        doneButton.layer.shadowRadius = 2
        doneButton.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        doneButton.layer.masksToBounds = false
        
        doneButton.backgroundColor = .disabledColor()
        doneButton.isUserInteractionEnabled = false
        doneButton.setImage(UIImage(named: "Tick")?.withRenderingMode(.alwaysTemplate), for: UIControlState())
        doneButton.tintColor = .backgroundColor()
    }

    func styleTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsets.zero
        tableView.separatorColor = .backgroundColor()
        tableView.backgroundColor = .white
    }
    
    func createArrayOfUsedPremadeCollectionRecordNames() -> [String] {
        
        var usedRecordNames = [String]()
        
        for collection in userCollections {
            
            usedRecordNames.append(collection.record.recordID.recordName)
        }
        
        return usedRecordNames
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        
        var pickedCollections = [CollectionModel]()
        
        for (index, bool) in selectedArray.enumerated() {
            
            if bool == true {
                pickedCollections.append(premadeCollections[index])
            }
        }
        
        self.delegate?.finishedPickingCollections(pickedCollections)
        _ = self.navigationController?.popViewController(animated: true)
    }
}

extension AddListsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if selectedArray[(indexPath as NSIndexPath).row] == true {
            selectedArray[(indexPath as NSIndexPath).row] = false
        } else {
            selectedArray[(indexPath as NSIndexPath).row] = true
        }
        tableView.reloadRows(at: [indexPath], with: .none)
        
        if selectedArray.contains(true) {
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.doneButton.backgroundColor = .primaryColor()
                self.doneButton.isUserInteractionEnabled = true
                self.doneButton.tintColor = .white
            })
        } else {
            
            UIView.animate(withDuration: 0.25, animations: {
                
                self.doneButton.backgroundColor = .disabledColor()
                self.doneButton.isUserInteractionEnabled = false
                self.doneButton.tintColor = .backgroundColor()
            })
        }
    }
}

extension AddListsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return premadeCollections.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! LabelCell
        cell.titleLabel.text = premadeCollections[(indexPath as NSIndexPath).row].name
        
        if let image = premadeCollections[(indexPath as NSIndexPath).row].image {
            cell.circleImageViewWidthConstraint.constant = 48
            cell.circleImageView.image = image
            cell.configureCell(true)
        } else {
            cell.circleImageViewWidthConstraint.constant = 0
            cell.configureCell(false)
        }
        
        cell.isSelected = selectedArray[(indexPath as NSIndexPath).row]

        if cell.isSelected {
            cell.backgroundColor = .secondaryColor()
            cell.titleLabel.textColor = .white
        } else {
            cell.backgroundColor = .white
            cell.titleLabel.textColor = .black
        }
        
        cell.isUserInteractionEnabled = true;
        
        for string in usedRecordNames {
            
            if string.contains(premadeCollections[(indexPath as NSIndexPath).row].name.trim()) {
                cell.backgroundColor = .disabledColor()
                cell.isUserInteractionEnabled = false;
                cell.titleLabel.textColor = .lightGray
                cell.circleImageView.alpha = 0.5
                break
            }
        }

        return cell
    }
}
