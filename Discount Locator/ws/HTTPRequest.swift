//
//  HTTPRequest.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 10/11/15.
//  Copyright © 2015 air. All rights reserved.
//
import Alamofire
import SwiftyJSON

public class HTTPRequest
{
    public static var sharedWSInstance = HTTPRequest()
    
    public func httprequest(url: String, completion: (result: AnyObject) -> Void)
    {
        Alamofire.request(.GET, url)
            .responseJSON { response in
                if let json = response.result.value{
                
                    completion(result: json)
                
                }
        }
    }
}