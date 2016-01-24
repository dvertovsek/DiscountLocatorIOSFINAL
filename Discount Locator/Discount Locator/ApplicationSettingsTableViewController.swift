//
//  ApplicationSettingsTableViewController.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 24/12/15.
//  Copyright © 2015 air. All rights reserved.
//

import UIKit

class ApplicationSettingsTableViewController: UITableViewController {
    
    @IBOutlet var enableWSSwitch: UISwitch!
    @IBOutlet var notificationServiceSwtich: UISwitch!
    var prefs = NSUserDefaults()
    @IBAction func onEnableWSChange(sender: UISwitch) {
        prefs.setBool(sender.on, forKey: "EnableWebService")
    }
    @IBAction func onNotificationServiceChange(sender: UISwitch) {
        prefs.setBool(sender.on, forKey: "EnableNotificationService")
    }
    func loadFromUserPrefs(){
        enableWSSwitch.setOn(prefs.boolForKey("EnableWebService"),animated:false)
        notificationServiceSwtich.setOn(prefs.boolForKey("EnableNotificationService"), animated:false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromUserPrefs()
        backSwipeCheck()
    }
    
    
}
