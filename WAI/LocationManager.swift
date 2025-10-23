// LocationManager.swift
// Project: WAI
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 21/10/2025 at 11.18.
// Copyright © 2025 ksd. All rights reserved.
//
//


import Foundation
import MapKit

@Observable
class LocationManager: NSObject {

    var userLocation: CLLocation?

    let dataSet = [
        User(coordinate: CLLocationCoordinate2D(latitude: 56.119821, longitude: 10.158652), tag: 0),
        User(coordinate: CLLocationCoordinate2D(latitude: 56.442701, longitude: 10.148295), tag: 1),
    ]

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
        ///find and update the user in the dataSet

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
