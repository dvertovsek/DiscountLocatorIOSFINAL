//
//  Artwork.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 09/12/15.
//  Copyright © 2015 air. All rights reserved.
//
import MapKit

class Artwork: NSObject, MKAnnotation {
    let title: String?
    let locationName: String
    let discipline: String
    let storeId: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, storeId:String, discipline: String, coordinate: CLLocationCoordinate2D) {
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        self.storeId = storeId
        super.init()
    }
    
    var subtitle: String? {
        return locationName
    }
}