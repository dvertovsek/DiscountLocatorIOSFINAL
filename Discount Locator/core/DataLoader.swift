//
//  DataLoader.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 13/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation
import db
public protocol DataLoader
{
    var stores:[Store]{get set}
    var discounts:[Discount]{get set}
    func LoadData()
}
