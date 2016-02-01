//
//  DBDataLoader.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 29/01/16.
//  Copyright © 2016 air. All rights reserved.
//

import Foundation
import core
import db
import Realm
import RealmSwift

public class DBDataLoader:DataLoader {
    
    public func LoadData(){
        DbController.sharedDBInstance.dbResultDelegate = self
        showDataFromLocalDB()
    }
    
    private func showDataFromLocalDB()
    {
        DbController.sharedDBInstance.realmFetchStores()
        DbController.sharedDBInstance.realmFetchDiscounts()
    }
}

extension DBDataLoader:DBResultDelegate {
    public func getDiscounts(result: [Discount]) {
        self.discounts = result
        self.dataLoaded()
    }
    public func getStores(result: [Store]) {
        self.stores = result
        self.dataLoaded()
    }
}