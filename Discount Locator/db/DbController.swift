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
    
    private let realm = try! Realm()
    
    public func addStore(remoteId: Int, name: String, desc: String, imgUrl: String, longitude: Int, latitude: Int)
    {
        let store = Store()
        store.remoteId = remoteId
        store.name = name
        store.desc = desc
        store.imgUrl = imgUrl
        store.longitude = longitude
        store.latitude = latitude
        
        realmAdd(store)
    }
    
    public func addDiscount(remoteId: Int, name: String)
    {
        let discount = Discount()
        discount.remoteId = remoteId
        discount.name = name
        
        realmAdd(discount)
    }
    
    public func bindStoresToDiscount()
    {
        /*
        *       TO DO: BIND SOTRES TO DISCOUNTS
        */
    }
    
    func realmAdd(o: Object)
    {
        try! self.realm.write
            {
                self.realm.add(o)
        }
    }
}