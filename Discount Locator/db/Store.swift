//
//  File.swift
//  Discount Locator
//
//  Created by MTLab on 04/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation

import RealmSwift

class Store: Object
{
    dynamic var remoteId: Int = 0
    
    dynamic var name: String = ""
    dynamic var desc: String = ""
    dynamic var imgUrl: String = ""
    
    dynamic var longitude: Int = 0
    dynamic var latitude: Int = 0
    
    var discounts: [Discount]
    {
        return linkingObjects(Discount.self, forProperty: "store")
    }
}