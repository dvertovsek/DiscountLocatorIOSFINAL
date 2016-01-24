//
//  ViewController.swift
//  Application Lifecycle Example
//
//  Created by MTLab on 21/10/15.
//  Copyright (c) 2015 Air Foi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        println("ViewController - viewDidLoad");
    }
    
    override func viewWillAppear(animated: Bool) {
        println("ViewController - viewWillAppear");
    }
    
    override func viewDidAppear(animated: Bool) {
        println("ViewController - viewDidAppear");
    }
    
    override func viewWillDisappear(animated: Bool) {
        println("ViewController - viewWillDisappear")
    }
    
    override func viewDidDisappear(animated: Bool) {
        println("ViewController - viewDidDisappear")
    }

}

