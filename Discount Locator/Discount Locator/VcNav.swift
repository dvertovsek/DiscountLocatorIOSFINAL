//
//  VcNav.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 18/12/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation

class VcNav:UIViewController{
    
    
    
    @IBOutlet var containerView: UIView!
    @IBOutlet var Open: UIBarButtonItem!
    static var viewControllerNumber:Int = 0
    
    var firstViewController: UIViewController?
    var secondViewController: UIViewController?
    var backTableViewController: BackTableVC?
    private var activeViewController: UIViewController? {
        didSet {
            removeInactiveViewController(oldValue)
            updateActiveViewController()
        }
    }
    private func removeInactiveViewController(inactiveViewController: UIViewController?) {
        if let inActiveVC = inactiveViewController {
            // call before removing child view controller's view from hierarchy
            inActiveVC.willMoveToParentViewController(nil)
            
            inActiveVC.view.removeFromSuperview()
            
            // call after removing child view controller's view from hierarchy
            inActiveVC.removeFromParentViewController()
        }
    }
    
    private func updateActiveViewController() {
        if let activeVC = activeViewController {
            // call before adding child view controller's view as subview
            addChildViewController(activeVC)
            
            activeVC.view.frame = containerView.bounds
            containerView.addSubview(activeVC.view)
            
            // call before adding child view controller's view as subview
            activeVC.didMoveToParentViewController(self)
        }
    }
    func showView(content:UIViewController){
         // TODO PRIKAZATI MAPE/STOREOVE UNUTAR KONTEJNERAScontainerView.
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        firstViewController = UIStoryboard.firstViewController()
        secondViewController = UIStoryboard.secondViewController()
        
     
        if(VcNav.viewControllerNumber==0) {
            activeViewController = firstViewController
        }
        else {
            activeViewController = secondViewController
        }

        Open.target=self.revealViewController()
        Open.action = Selector("revealToggle:")
        
       
        //showView("stores")
        self.view.addGestureRecognizer(self.revealViewController().panGestureRecognizer())
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
   
}

private extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle()) }
    
    class func secondViewController() -> MapViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("MapViewController") as? MapViewController
    }
    class func firstViewController() -> ViewController? {
        return mainStoryboard().instantiateViewControllerWithIdentifier("StoresViewController") as? ViewController
    }
    
}