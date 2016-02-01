//
//  ModalRadiusPickerViewController.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 24/12/15.
//  Copyright © 2015 air. All rights reserved.
//

import UIKit

class ModalRadiusPickerViewController: UIViewController, UIPickerViewDelegate,UIPickerViewDataSource {
    
    var prefs = NSUserDefaults()
    
    @IBOutlet var pickerView: UIPickerView!
    //swift je miracle
    var pickerDataSource = ["500m":500,"1Km":1000,"2Km":2000,"10Km":10000,"100Km":100000]
    @IBAction func onClose(sender: UIButton) {
         let index = pickerDataSource.startIndex.advancedBy(pickerView.selectedRowInComponent(0)) //da se dobije index tipa DictionaryIndex, ne moze se direktno preko indexa tipa int
         prefs.setInteger(pickerDataSource.values[index], forKey: "StoreRadius")
         self.dismissViewControllerAnimated(true, completion: nil);
    }
    func loadDefaultPickerValue(){
        let radiusInt=prefs.integerForKey("StoreRadius") //vraca 0 ako ne postoji pref StoreRadius
        var selectedRowInt=0
        if radiusInt != 0 {
            for (_,value) in pickerDataSource {
                if(value==radiusInt){
                    break
                }
                selectedRowInt++
            }
        }
        self.pickerView.selectRow(selectedRowInt, inComponent: 0, animated: false)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.pickerView.dataSource=self
        self.pickerView.delegate=self
        loadDefaultPickerValue()
    }
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerDataSource.count;
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let index = pickerDataSource.startIndex.advancedBy(row) //vraca index
        return pickerDataSource.keys[index]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
