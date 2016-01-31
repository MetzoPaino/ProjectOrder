//
//  CategoriesViewController.swift
//  Ranked
//
//  Created by William Robinson on 30/01/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol CategoriesViewControllerDelegate: class {
    func selectedCategory(category: CollectionType)
}

class CategoryCell: UITableViewCell {
    
    @IBOutlet weak var label: UILabel!
}

class CategoriesViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: CategoriesViewControllerDelegate?

    
    let categories = CategoriesManager().categories
    

    
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTableView()
    }
    
    func styleTableView() {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
    }
}

extension CategoriesViewController: UITableViewDelegate {
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        delegate?.selectedCategory(categories[indexPath.row].type)
        navigationController?.popViewControllerAnimated(true)
    }
}

extension CategoriesViewController: UITableViewDataSource {
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return categories.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as! CategoryCell
        cell.label.text = categories[indexPath.row].title;
        return cell
    }
}