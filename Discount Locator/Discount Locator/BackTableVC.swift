//
//  BackTableVC.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 18/12/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation

class BackTableVC: UITableViewController{
    
    var tableArray = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
    
        tableArray = ["Stores list", "Map"]
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray.count
        
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(tableArray[indexPath.row], forIndexPath: indexPath) as UITableViewCell
        cell.textLabel?.text = tableArray [indexPath.row]
        
        return cell
    }
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        VcNav.viewControllerNumber = indexPath.row
    }
    

    
}