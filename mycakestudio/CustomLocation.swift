//
//  Artwork.swift
//  mycakestudio
//
//  Created by Dan Qian on 2019/8/12.
//  Copyright © 2019 dyq. All rights reserved.
//

import MapKit
import Contacts

class CustomLocation: NSObject,MKAnnotation{
    let title: String?
    let locationName: String
    let discipline: String
    let coordinate: CLLocationCoordinate2D
    
    init(title: String, locationName: String, discipline: String, coordinate: CLLocationCoordinate2D){
        self.title = title
        self.locationName = locationName
        self.discipline = discipline
        self.coordinate = coordinate
        
        super.init()
        
    }
    
    var subtitle: String?{
        return "Is not a real business :) "
    }
    
    func mapItem()-> MKMapItem{
        let addressDict = [CNPostalAddressStreetKey: subtitle!]
        let placemark = MKPlacemark(coordinate: coordinate, addressDictionary: addressDict)
        let mapItem = MKMapItem(placemark: placemark)
        mapItem.name = title
        return mapItem
    }
}
