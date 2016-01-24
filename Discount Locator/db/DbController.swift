//
//  DbController.swift
//  Discount Locator
//
//  Created by MTLab on 04/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation

import RealmSwift

public class DbController
{
    public static var sharedDBInstance = DbController()
    
    
    
    public let realm = try! Realm()
    
//    public func addStore(remoteId: String, name: String, desc: String, imgUrl: String, longitude: float, latitude: float)
//    {
//        let store = Store()
//        store.remoteId = remoteId
//        store.name = name
//        store.desc = desc
//        store.imgUrl = imgUrl
//        store.longitude = longitude
//        store.latitude = latitude
//        
//        realmAdd(store)
//    }
//    
//    public func addDiscount(storeId: String, name: String)
//    {
//        let discount = Discount()
//        discount.storeId = storeId
//        discount.name = name
//        
//        realmAdd(discount)
//    }
    
    public func realmAdd(o: Object)
    {
        try! self.realm.write
        {
            self.realm.add(o)
        }
    }
}



