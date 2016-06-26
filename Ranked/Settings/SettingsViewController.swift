//
//  SettingsViewController.swift
//  Project Order
//
//  Created by William Robinson on 07/05/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

protocol SettingsViewControllerDelegate: class {
    func appendPreMadeCollections(_ collections: [CollectionModel])
    func performFulliCloudSync()
}

class SettingsViewController: UIViewController {

    @IBOutlet weak var closeBarButton: UIBarButtonItem!
    @IBOutlet weak var tableView: UITableView!
    
    weak var delegate: SettingsViewControllerDelegate?
    
    var collections: [CollectionModel]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleNavBar()
        styleTableView()
    }

    func styleNavBar() {
        navigationController?.navigationBar.setBackgroundImage(nil, for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = nil
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor.white()
        navigationController?.navigationBar.tintColor = .primaryColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.primaryColor()]
    }
    
    func styleTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = .backgroundColor()
        tableView.backgroundColor = .backgroundColor()
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: AnyObject?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        if let controller = segue.destinationViewController as? AddListsViewController {
            
            controller.delegate = self
            controller.userCollections = collections
        }
    }
    
    // MARK: - IBActions

    @IBAction func closeBarButtonPressed(_ sender: UIBarButtonItem) {
        
        self.navigationController?.dismiss(animated: true, completion: nil)
    }
}

extension SettingsViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.row == 0 {
            self.delegate?.performFulliCloudSync()
        }
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "iCloudCell", for: indexPath)
            return cell
        } else if (indexPath as NSIndexPath).row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddListsCell", for: indexPath)
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath)
            return cell
        }
    }
}

extension SettingsViewController: AddListsViewControllerDelegate {
    
    func finishedPickingCollections(_ collections: [CollectionModel]) {
        
        self.collections.append(contentsOf: collections)
        self.delegate?.appendPreMadeCollections(collections)
    }
}
