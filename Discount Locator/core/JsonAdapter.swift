//
//  JsonAdapter.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 13/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation

import SwiftyJSON
import db

public class JsonAdapter
{
    public static func getStores(json: AnyObject) -> (stores: Array<Store>, discounts: Array<Discount>)
    {
        var stores = [Store]()
        var discounts = [Discount]()
        let items = JSON(json)
        var storeID:String
        for (key, subJson) in items {
    
            var s:Store = Store()
            s.remoteId = subJson["_id"].string!
            storeID = s.remoteId
            s.name = subJson["name"].string!
            s.desc = subJson["desc"].string!
            s.imgUrl = subJson["imgUrl"].string!
            s.latitude = subJson["lat"].float!
            s.longitude = subJson["lng"].float!
            stores.append(s)

            for (keyDisc, discount) in subJson["discounts"]{
                var d:Discount = Discount()
                d.storeId = storeID
                d.name = discount["name"].string!
                d.desc = discount["desc"].string!
                d.discount = discount["discount"].int!
                d.endDate = discount["endDate"].string!
                d.startDate = discount["startDate"].string!
                discounts.append(d)
            }
        }
        
        return (stores, discounts)
    }
}