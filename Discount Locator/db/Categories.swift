//
//  Categories.swift
//  Discount Locator
//
//  Created by MTLab on 05/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation

import RealmSwift

class Categories: Object
{
    dynamic var remoteId: Int = 0
    
    dynamic var name: String = ""
    
    dynamic var subcategoryOf: Int = 0
}