//
//  LocationManager.swift
//  EKTracking
//
//  Created by Debashree on 12/22/16.
//  Copyright © 2016 Debashree. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation


protocol LocationDidUpdateDelegate: class {
    func didUpdateLocationWithResult(location: CLLocation?, error: Error?)
    func didUpdateLocationWithHeading(heading: CLHeading?, error: Error?)
    func locationAccessDenied()
}


class LocationManager: NSObject {
    static let shared: LocationManager = LocationManager()
    public var location: CLLocation? = CLLocation(latitude: 27.679481480007, longitude: 85.3220117899974)
    
    let manager: CLLocationManager?
    weak var delegate: LocationDidUpdateDelegate?
    
    override init() {
        manager = CLLocationManager()
        super.init()
        manager?.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
        manager?.delegate = self
        manager?.distanceFilter = 5
        manager?.requestWhenInUseAuthorization()
        manager?.pausesLocationUpdatesAutomatically = true
        manager?.startUpdatingHeading()
    }
    
    func startLocationUpdate() {
        self.manager?.startUpdatingLocation()
    }
    
    func stopLocationUpdate() {
        self.manager?.stopUpdatingLocation()
    }
    
    func locationPermissionAuthorized() -> Bool {
        return [CLAuthorizationStatus.authorizedAlways, CLAuthorizationStatus.authorizedWhenInUse, CLAuthorizationStatus.notDetermined].contains(CLLocationManager.authorizationStatus())
    }
    
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        self.location = locations.last
        delegate?.didUpdateLocationWithResult(location: self.location, error: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateHeading newHeading: CLHeading) {
        delegate?.didUpdateLocationWithHeading(heading: newHeading, error: nil)
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        if !self.locationPermissionAuthorized() {
//            self.delegate?.locationAccessDenied()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if !self.locationPermissionAuthorized() {
            self.delegate?.locationAccessDenied()
        }
    }
}
