//
//  Discount.swift
//  Discount Locator
//
//  Created by MTLab on 04/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation

import RealmSwift

public class Discount: Object
{
    public dynamic var storeId: String = ""
    
    public dynamic var name: String = ""
    public dynamic var desc: String = ""
    public dynamic var discount: Int = 0
    public dynamic var startDate: String = ""
    public dynamic var endDate: String = ""
    
    public dynamic var store: Store?
    
    public func storeSet(s: Store)
    {
        self.store = s
    }
}