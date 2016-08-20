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
    var appIsSyncing = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        styleNavBar()
        styleTableView()
        
        NotificationCenter.default.addObserver(self, selector: #selector(SettingsViewController.receivedNotification(notification:)), name: NSNotification.Name(rawValue: "iCloudSyncFinished"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    func styleNavBar() {
        navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationController?.navigationBar.shadowImage = UIImage()
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.view.backgroundColor = UIColor.white
        navigationController?.navigationBar.tintColor = .primaryColor()
        navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.primaryColor()]
    }
    
    func styleTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        //tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = .backgroundColor()
        tableView.backgroundColor = .white
    }
    
    func receivedNotification(notification: NSNotification) {
        
        if notification.name == NSNotification.Name(rawValue: "iCloudSyncFinished") {
            appIsSyncing = false
            tableView.reloadData()
        }
    }
    
    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let backItem = UIBarButtonItem()
        backItem.title = ""
        navigationItem.backBarButtonItem = backItem
        
        if let controller = segue.destination as? AddListsViewController {
            
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
            appIsSyncing = true
            tableView.reloadData()
        }

        tableView.deselectRow(at: indexPath, animated: false)
    }
    
    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
        
        if let cell = tableView.cellForRow(at: indexPath) as? SettingsTableViewCell {
            
            var imageName: String
            
            switch cell.tag {
            case 1:
                imageName = "Sync"
            case 2:
                imageName = "AddPremade"
            case 3:
                imageName = "About"
            default:
                imageName = ""
            }
            cell.titleLabel.textColor = .white
            cell.descriptionImageView.image = UIImage(named:imageName)?.withRenderingMode(.alwaysTemplate)
            cell.descriptionImageView.tintColor = .white
            
            if cell.accessoryImageView != nil {
                cell.accessoryImageView.image = UIImage(named:"ForwardArrow")?.withRenderingMode(.alwaysTemplate)
                cell.accessoryImageView.tintColor = .white
            }

        }
        
//        let cell = tableView.cellForRow(at: indexPath)
//        cell?.backgroundColor = .secondaryColor()
//        cell?.contentView.backgroundColor = .secondaryColor()
//        cell?.accessoryView?.tintColor = .white()
//        cell?.tintColor = .white()
    }
    
    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {

        if let cell = tableView.cellForRow(at: indexPath) as? SettingsTableViewCell {
            
            var imageName: String
            
            switch cell.tag {
            case 1:
                imageName = "Sync"
            case 2:
                imageName = "AddPremade"
            case 3:
                imageName = "About"
            default:
                imageName = ""
            }
            cell.titleLabel.textColor = .headingColor()
            cell.descriptionImageView.image = UIImage(named:imageName)?.withRenderingMode(.alwaysTemplate)
            cell.descriptionImageView.tintColor = .primaryColor()
            
            if cell.accessoryImageView != nil {
                cell.accessoryImageView.image = UIImage(named:"ForwardArrow")?.withRenderingMode(.alwaysTemplate)
                cell.accessoryImageView.tintColor = .primaryColor()
            }
        }
    }
}

extension SettingsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if (indexPath as NSIndexPath).row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "iCloudCell", for: indexPath) as! SyncingTableViewCell
            cell.configureCell()
            cell.configureCell(syncing: appIsSyncing)
            cell.tag = 1

            return cell
        } else if (indexPath as NSIndexPath).row == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddListsCell", for: indexPath) as! SettingsTableViewCell
            cell.configureCell()
            cell.tag = 2

            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "AboutCell", for: indexPath) as! SettingsTableViewCell
            cell.configureCell()
            cell.tag = 3
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
