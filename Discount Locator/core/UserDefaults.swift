//
//  UserDefaults.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 26/01/16.
//  Copyright © 2016 air. All rights reserved.
//


public class UserDefaults: UIViewController {
    public static func checkIfUserDefaultsAreSet() {
        if NSUserDefaults.standardUserDefaults().objectForKey("useAnimations") == nil
        {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "useAnimations")
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("useBackSwipe") == nil
        {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "useBackSwipe")
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("EnableWebService") == nil
        {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "EnableWebService")
        }
        if NSUserDefaults.standardUserDefaults().objectForKey("EnableNotificationService") == nil
        {
            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "EnableNotificationService")
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("StoreRadius") == nil
        {
            NSUserDefaults.standardUserDefaults().setInteger(100000, forKey: "StoreRadius")
        }
    }
}
