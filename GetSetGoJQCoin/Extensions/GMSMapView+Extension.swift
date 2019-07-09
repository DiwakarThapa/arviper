//
//  GMSMapView+Extension.swift
//  GetSetGoJQCoin
//
//  Created by rozan on 5/16/19.
//  Copyright © 2019 ekbana. All rights reserved.
//

import Foundation
import GoogleMaps

extension GMSMapView {
    
    func setupBoundary(geoCoordinate:String, radius:Double = 20) {
        let cordinate = geoCoordinate.components(separatedBy: ",")
        let lat = Double(cordinate.first ?? "") ?? 0
        let long = Double(cordinate.last ?? "") ?? 0
        let circle = GMSCircle(position: CLLocationCoordinate2D(latitude: lat, longitude:long), radius:CLLocationDistance(exactly: radius) ?? 0)
        circle.strokeColor = UIColor.red.withAlphaComponent(0.0)
        circle.fillColor = UIColor.red.withAlphaComponent(0.5)
        circle.strokeWidth = 2.0
        circle.map = self
        
//        
//        let circle2 = GMSCircle(position: CLLocationCoordinate2D(latitude: lat, longitude:long), radius:CLLocationDistance(exactly: 30) ?? 0)
//        circle2.strokeColor = UIColor.green.withAlphaComponent(0.0)
//        circle2.fillColor = UIColor.green.withAlphaComponent(0.5)
//        circle2.strokeWidth = 2.0
//        circle2.map = self
    }
}
