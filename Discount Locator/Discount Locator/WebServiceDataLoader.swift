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
    public var stores: [Store] = []
    public var discounts: [Discount] = []
    public var storesTableView: UITableView?
    

    private var discountsLoaded: Bool = false
    private var storesLoaded: Bool = false
    
    private var prefs = NSUserDefaults()

    
    public func LoadData() {
        var params:[String:String] = ["method": "getAll"]
        if(NetConnection.Connection.isConnectedToNetwork() && prefs.boolForKey("EnableWebService")){
            print("loadam s web servisa")
            HTTPRequest.sharedWSInstance.httprequest("http://cortex.foi.hr/mtl/courses/air/stores.php", params: params)
                        {
                            (result: AnyObject) in
                            self.stores = JsonAdapter.getStores(result)
                            self.storesLoaded = true
                            self.showLoadedData()
                    }
            HTTPRequest.sharedWSInstance.httprequest("http://cortex.foi.hr/mtl/courses/air/discounts.php", params: params)
                        {
                            (result: AnyObject) in
                            self.discounts = JsonAdapter.getDiscounts(result)
                            self.discountsLoaded = true
                            self.showLoadedData()
                    }
        }
        else {
            print("loadam lokalno")
            self.showDataFromLocalDB()
        }
    }
    
    
    private func showLoadedData()
    {

        if(self.storesLoaded && self.discountsLoaded){
            self.bindData()
            storesTableView?.reloadData()
        }
       
        
    }
    
    private func showDataFromLocalDB()
    {
        let stores = DbController.sharedDBInstance.realmFetch(Store)
        let discounts = DbController.sharedDBInstance.realmFetch(Discount)
        
        for store in stores{
            self.stores.append(store as! Store)
        }
        for discount in discounts{
            self.discounts.append(discount as! Discount)
        }
        storesTableView?.reloadData()
    }

    private func bindData()
    {
        DbController.sharedDBInstance.realm.beginWrite()
        DbController.sharedDBInstance.realm.deleteAll()
        try! DbController.sharedDBInstance.realm.commitWrite()

        for store in stores
        {
            print(DbController.sharedDBInstance)
            DbController.sharedDBInstance.realmAdd(store)
            for discount in discounts
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