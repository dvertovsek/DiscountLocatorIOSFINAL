//
//  DbController.swift
//  Discount Locator
//
//  Created by MTLab on 04/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation
import RealmSwift

public protocol DBResultDelegate{
    func getStores(result:[Store])
    func getDiscounts(result:[Discount])
}
public class DbController
{
    
    public static var sharedDBInstance = DbController()
    
    public var dbResultDelegate:DBResultDelegate?
    public let realm = try! Realm()
    
    public func realmAdd(o: Object)
    {
        try! self.realm.write
        {
            self.realm.add(o)
        }
    }
    
    public func realmFetchStores()
    {
        let data = self.realm.objects(Store)
        dbResultDelegate?.getStores(data.reverse())
    }
    public func realmFetchDiscounts()
    {
        let data = self.realm.objects(Discount)
        dbResultDelegate?.getDiscounts(data.reverse())
    }
}



