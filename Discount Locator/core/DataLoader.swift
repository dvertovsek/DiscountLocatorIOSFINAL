//
//  DataLoader.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 13/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation
import db
public protocol OnDataLoadedDelegate {
    func onDataLoaded(stores : [Store], discounts: [Discount])
}
public class DataLoader
{
    public var stores:[Store]?
    public var discounts:[Discount]?
    public var onDataLoadedDelegate:OnDataLoadedDelegate?
    
    func LoadData() {}
    public init(){}
    public func dataLoaded() -> Bool {
        if (stores==nil || discounts == nil) {
            return false
        }
        else {
            onDataLoadedDelegate?.onDataLoaded(stores!, discounts: discounts!)
            return true
        }
    
    }
}
