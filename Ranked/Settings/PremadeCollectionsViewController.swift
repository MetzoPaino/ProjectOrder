//
//  PremadeCollectionsViewController.swift
//  Project Order
//
//  Created by William Robinson on 03/04/2016.
//  Copyright © 2016 William Robinson. All rights reserved.
//

import UIKit

class PremadeCollectionsViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        styleTableView()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func styleTableView() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 88
        tableView.tableFooterView = UIView()
        tableView.separatorInset = UIEdgeInsetsZero
        tableView.separatorColor = UIColor.backgroundColor()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

// MARK: - TableViewDelegate
private typealias TableViewDelegate = PremadeCollectionsViewController
extension TableViewDelegate: UITableViewDelegate {
    
    //    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    //
    //        tableView.deselectRowAtIndexPath(indexPath, animated: false)
    //    }
}

private typealias TableViewDataSource = PremadeCollectionsViewController
extension TableViewDataSource: UITableViewDataSource {
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return preMadeCollectionsArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 
        cell.separatorInset = UIEdgeInsetsMake(0, cell.bounds.size.width, 0, 0);
        
        if let label = self.view.viewWithTag(100) as? UILabel {
            label.text = preMadeCollectionsArray[indexPath.row].name
        }
        return cell
    }
}