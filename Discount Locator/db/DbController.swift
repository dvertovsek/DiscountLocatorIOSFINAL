//
//  DbController.swift
//  Discount Locator
//
//  Created by MTLab on 04/11/15.
//  Copyright © 2015 air. All rights reserved.
//

import Foundation

import RealmSwift

public class DbController
{
    public static var sharedDBInstance = DbController()
    
    public let realm = try! Realm()
    
    public func realmAdd(o: Object)
    {
        try! self.realm.write
        {
            self.realm.add(o)
        }
    }
    
    public func realmFetch(o: Object.Type) -> Results<Object>
    {
        let data = self.realm.objects(o)
        return data
    }
}



