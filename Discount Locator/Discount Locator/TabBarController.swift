//
//  TabBarController.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 09/12/15.
//  Copyright © 2015 air. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {


    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.items![1].enabled=false
    }
}
