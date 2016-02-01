//
//  WebServiceDataLoader.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 13/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation
import db
import core
import ws

public class WebServiceDataLoader:DataLoader
{
    private var discountsLoaded: Bool = false
    private var storesLoaded: Bool = false
    
    private var prefs = NSUserDefaults()

    var httpRequest = HTTPRequest()
    
    public func LoadData() {
        
        httpRequest.wsResultDelegate = self
        httpRequest.httprequest("http://cortex.foi.hr/mtl/courses/air/stores.php", params: ["method": "getAll"])
    }
    
    
    private func showLoadedData()
    {

        if(self.storesLoaded && self.discountsLoaded){
            self.bindData()
            self.dataLoaded()//from DataLoader class
        }
       
        
    }
    

    private func bindData()
    {
        DbController.sharedDBInstance.realm.beginWrite()
        DbController.sharedDBInstance.realm.deleteAll()
        try! DbController.sharedDBInstance.realm.commitWrite()

        for store in stores!
        {
            DbController.sharedDBInstance.realmAdd(store)
            for discount in discounts!
            {
                if(discount.storeId == store.remoteId)
                {
                    discount.storeSet(store)
                    DbController.sharedDBInstance.realmAdd(discount)
                }
            }
        }
    }
}

extension WebServiceDataLoader: WebServiceResultDelegate{
    public func getResult(json: AnyObject) {
        if(!storesLoaded){
            storesLoaded = true
            self.stores = JsonAdapter.getStores(json)
            self.storesLoaded = true
            self.showLoadedData()
            httpRequest.httprequest("http://cortex.foi.hr/mtl/courses/air/discounts.php", params: ["method":"getAll"])
        }else{
            self.discounts = JsonAdapter.getDiscounts(json)
            self.discountsLoaded = true
            self.showLoadedData()
        }
        
    }

}