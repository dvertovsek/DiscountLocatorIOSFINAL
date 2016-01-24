//
//  SettingsTableViewController.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 20/12/15.
//  Copyright © 2015 air. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController, UIGestureRecognizerDelegate {

    let prefs = NSUserDefaults.standardUserDefaults()
 
    @IBOutlet var useBackSwipeSwitch: UISwitch!
    @IBOutlet var useAnimationsSwitch: UISwitch!
    
    @IBAction func OnUseAnimationsChanged(sender: UISwitch) {
        prefs.setBool(sender.on, forKey: "UseAnimations")
        Settings.changeAnimationSetting(sender.on)
    }

    @IBAction func OnBackSwipeChanged(sender: UISwitch) {
         prefs.setBool(sender.on, forKey: "UseBackSwipe")
         backSwipeCheck()
    }
    
    func loadFromUserPrefs(){
        useAnimationsSwitch.setOn(prefs.boolForKey("UseAnimations"),animated:false)
        useBackSwipeSwitch.setOn(prefs.boolForKey("UseBackSwipe"), animated:false)
    }
    func handleGesture(gestureRecongizer: UISwipeGestureRecognizer){
        if gestureRecongizer.state == .Ended{
            performSegueWithIdentifier("settingsToRevealSegue", sender: self)
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        loadFromUserPrefs()
        backSwipeCheck()
        //dodavanje handlera za swipe
    self.navigationController?.interactivePopGestureRecognizer?.delegate = self
        self.navigationController?.interactivePopGestureRecognizer
    self.navigationController?.interactivePopGestureRecognizer?.addTarget(self, action: "handleGesture:")
    }
   
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    

  

}
