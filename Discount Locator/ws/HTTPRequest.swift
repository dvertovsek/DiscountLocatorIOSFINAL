//
//  HTTPRequest.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 10/11/15.
//  Copyright © 2015 air. All rights reserved.
//
import Alamofire

public protocol WebServiceResultDelegate{
    func getResult(json:AnyObject)
}

public class HTTPRequest
{
    
    public var delegate:WebServiceResultDelegate?
    
    public init(){}
    
    public func httprequest(url: String, params: [String:String])
    {
        Alamofire.request(.POST, url, parameters: params)
            .responseJSON { response in
                if let json = response.result.value{
                
                    self.delegate?.getResult(json)
                
                }
        }
    }
}