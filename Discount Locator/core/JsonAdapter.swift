
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
    public static func getStores(json: AnyObject) -> Array<Store>
    {
        var stores = [Store]()
        let jsonStores = JSON(json)
        
        var items = jsonStores["items"]
        var itemsString = String(items)
        
        itemsString = itemsString.stringByReplacingOccurrencesOfString(String(Character(UnicodeScalar(92))), withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
  
        if let dataFromString = itemsString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json2 = JSON(data: dataFromString)
            for (key, subJson) in json2 {
                var s:Store = Store()
                s.remoteId = Int(String(subJson["id"]))!
                s.name = subJson["name"].string!
                s.desc = subJson["description"].string!
                s.imgUrl = subJson["imgUrl"].string!
                s.latitude = Float(String(subJson["latitude"]))! / 1000000
                s.longitude = Float(String(subJson["longitude"]))! / 1000000
                print("lat: ", s.latitude)
                print("lng: ", s.longitude)
                stores.append(s)
            }
        }
        return stores
    }
    
    public static func getDiscounts(json: AnyObject) -> Array<Discount>
    {
        var discounts = [Discount]()
        let jsonStores = JSON(json)
        
        let items = jsonStores["items"]
        var itemsString = String(items)
        
        itemsString = itemsString.stringByReplacingOccurrencesOfString(String(Character(UnicodeScalar(92))), withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil)
    
        if let dataFromString = itemsString.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: false) {
            let json2 = JSON(data: dataFromString)
            for (key, subJson) in json2 {
                
                var d:Discount = Discount()
                d.remoteId = Int(String(subJson["id"]))!
                d.name = subJson["name"].string!
                d.desc = subJson["description"].string!
                d.discount = Int(String(subJson["discount"]))!
                d.endDate = subJson["endDate"].string!
                d.startDate = subJson["startDate"].string!
                d.storeId = Int(String(subJson["storeId"]))!
                discounts.append(d)
            }
        }
        return discounts
    }
}