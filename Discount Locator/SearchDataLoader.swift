//
//  SearchDataLoader.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 29/01/16.
//  Copyright © 2016 air. All rights reserved.
//

import Foundation
import core
import db

public class SearchDataLoader: DataLoader {
    private var searchTerm = String ()
    public func SearchData(query: String){
        self.searchTerm = query
        DbController.sharedDBInstance.dbResultDelegate = self
        showDataFromLocalDB()
    }
    func alreadyExists(keyDiscount:Discount)->Bool{
        for discount in self.discounts! {
            if(discount.name==keyDiscount.name) {
                return true;
            }
        }
        return false;
    }
    private func showDataFromLocalDB()
    {
        DbController.sharedDBInstance.realmFetchStores()
        DbController.sharedDBInstance.realmFetchDiscounts()
    }
}

extension SearchDataLoader: DBResultDelegate {
    public func getDiscounts(result: [Discount]) {
        if(searchTerm != ""){
            self.discounts = result.filter {
                discount in
                return discount.name.lowercaseString.containsString(searchTerm.lowercaseString)
            }
            
            self.discounts!.appendContentsOf(result.filter { discount in
                if(!self.alreadyExists(discount)){
                    return discount.description.lowercaseString.containsString(searchTerm.lowercaseString)
                }
                else {
                    return false
                }
                })
        }
        else {
            self.discounts = result
        }
        self.dataLoaded()
    }
    public func getStores(result: [Store]) {
        self.stores = result 
    }
}