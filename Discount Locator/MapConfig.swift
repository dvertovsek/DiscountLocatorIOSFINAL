//
//  MapConfig.swift
//  Discount Locator
//
//  Created by Faculty of Organisation and Informatics on 26/01/16.
//  Copyright © 2016 air. All rights reserved.
//

import MapKit
import db

public protocol Map {
    func placeAnnotations(annotations: [MKAnnotation])
    func addCircle(circle: MKCircle)
    func centerMap(coordReg: MKCoordinateRegion)
}

public class MapConfig
{
    public var delegate:Map?
    
    public init(){}
    
    public func generateAnnotations(stores: [Store], currentLocation: CLLocation)
    {
        let storeRadiusInMeters: Double = Double(NSUserDefaults().integerForKey("StoreRadius"))
        var annotationsArray: [MKAnnotation] = []
            for store in stores {
                let location = CLLocation(latitude: Double(store.latitude), longitude: Double(store.longitude))
                if(location.distanceFromLocation(currentLocation) < storeRadiusInMeters){
                    let artwork = Artwork(title: store.name,
                        locationName: store.desc,
                        storeId: String(store.remoteId),
                        discipline: "NaN",
                        coordinate: CLLocationCoordinate2D(latitude: Double(store.latitude),longitude: Double(store.longitude)))
                    annotationsArray.append(artwork)
                }
            }
        self.delegate?.placeAnnotations(annotationsArray)
    }
    
    public func addRadiusCircle(location: CLLocation){
        let circle = MKCircle(centerCoordinate: location.coordinate, radius: Double(NSUserDefaults.standardUserDefaults().integerForKey("StoreRadius")) as CLLocationDistance)
        self.delegate?.addCircle(circle)
    }
    
    public func centerMapOnLocation(location: CLLocation)
    {
        let regionRadius: CLLocationDistance = 20000
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(location.coordinate, regionRadius * 2.0, regionRadius * 2.0)
        self.delegate?.centerMap(coordinateRegion)
    }
}
