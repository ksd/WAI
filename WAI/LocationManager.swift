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
    private var locationManager = CLLocationManager()

    override init(){
        super.init()
        locationManager.delegate = self
    }

}

extension LocationManager: CLLocationManagerDelegate {

    func locationManager(
        _ manager: CLLocationManager,
        didUpdateLocations locations: [CLLocation]
    ) {
        userLocation = locations.last
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {

        switch locationManager.authorizationStatus {
                
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .restricted, .denied, .authorizedAlways:
                print("Ha ha")
            case .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            @unknown default:
                fatalError()
        }
    }
}
