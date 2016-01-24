//
//  ModalViewController.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 20/12/15.
//  Copyright © 2015 air. All rights reserved.
//

import UIKit
import db

class ModalViewController: UIViewController {

    
    var webServiceDataLoader = WebServiceDataLoader()
    @IBAction func onClose(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: {});

    }
   
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) { //slanje podataka searchDiscountTableViewControlleru
        
       if segue.identifier == "onSearchDiscountsSegue" {
        if let destination = segue.destinationViewController as? UINavigationController {
                   var discountsForPassing: [Discount] = []
        let discounts = DbController.sharedDBInstance.realmFetch(Discount)
        for discount in discounts{
            discountsForPassing.append(discount as! Discount)
        }
            //pošto segue ide u navigController treba ga prvo dohvatit pa iz njega pripadajući view kojem predajemo discounte
            let searchViewcontroller = destination.viewControllers.first as! SearchDiscountsTabeViewController
            searchViewcontroller.discounts = discountsForPassing
        }
    }
        
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
