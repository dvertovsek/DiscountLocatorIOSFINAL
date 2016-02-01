//
//  Article.swift
//  Discount Locator
//
//  Created by MTLab on 05/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation

import RealmSwift

class Article: Object
{
    dynamic var remoteId: Int = 0
    
    dynamic var name: String = ""
    dynamic var price: Float = 0
    dynamic var imgUrl: String = ""
}