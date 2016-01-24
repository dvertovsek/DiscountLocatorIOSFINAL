//
//  File.swift
//  Discount Locator
//
//  Created by MTLab on 04/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation

import RealmSwift

public class Store: Object
{
    public dynamic var remoteId: Int = 0
    
    public dynamic var name: String = ""
    public dynamic var desc: String = ""
    public dynamic var imgUrl: String = ""
    
    public dynamic var longitude: Float = 0
    public dynamic var latitude: Float = 0
    
    public var discounts: [Discount]
        {
            return linkingObjects(Discount.self, forProperty: "store")
    }
    
}