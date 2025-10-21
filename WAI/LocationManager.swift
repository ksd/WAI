// LocationManager.swift
// Project: WAI 
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 21/10/2025 at 11.18.
// Copyright © 2025 ksd. All rights reserved.
//
// 


import Foundation
import CoreLocation

@Observable
class LocationManager: NSObject {

    var userLocation: CLLocation?
    var locationManager: CLLocationManager?

}

extension LocationManager: CLLocationManagerDelegate {

}
