//
//  Discount.swift
//  Discount Locator
//
//  Created by MTLab on 04/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation

import RealmSwift

class Discount: Object
{
    dynamic var remoteId: Int = 0
    
    dynamic var name: String = ""
    
    
    dynamic var store: Store?
    
    func storeSet(s: Store)
    {
        self.store = s
    }
}