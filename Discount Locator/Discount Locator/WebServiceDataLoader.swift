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
    
    public func LoadData() {
<<<<<<< HEAD
//        HTTPRequest.sharedWSInstance.httprequest("http://www.json-generator.com/api/json/get/csbvEnjqnC")
//            {
//                (result: AnyObject) in
//                self.stores = JsonAdapter.getStores(result)
//                self.storesLoaded = true
//                self.showLoadedData()
//        }
//        HTTPRequest.sharedWSInstance.httprequest("http://www.json-generator.com/api/json/get/ccWtDCAmRe")
//            {
//                (result: AnyObject) in
//                self.discounts = JsonAdapter.getDiscounts(result)
//                self.discountsLoaded = true
//                self.showLoadedData()
//        }
=======
        HTTPRequest.sharedWSInstance.httprequest("https://obscure-lake-7668.herokuapp.com/stores")
            {
                (result: AnyObject) in
                let result = JsonAdapter.getStores(result)
                self.stores = result.stores
                self.discounts = result.discounts
                self.showLoadedData()
        }
>>>>>>> WebService
    }
    
    private func showLoadedData()
    {
        self.bindData()
        storesTableView?.reloadData()
    }

    private func bindData()
    {
        
        DbController.sharedDBInstance.realm.beginWrite()
        DbController.sharedDBInstance.realm.deleteAll()
        try! DbController.sharedDBInstance.realm.commitWrite()

        for store in stores
        {

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