// ContentView.swift
// Project: WAI 
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 21/10/2025 at 11.17.
// Copyright © 2025 ksd. All rights reserved.
//
// 

import SwiftUI
import MapKit

struct User: Identifiable {
    let coordinate: CLLocationCoordinate2D
    let tag: Int
    var id: Int {tag}
}

struct ContentView: View {
    @State private var selectedMarker: Int?
    @State private var route: MKRoute?
    @Environment(LocationManager.self) var locationManager

    let dataSet = [
        User(coordinate: CLLocationCoordinate2D(latitude: 56.119821, longitude: 10.158652), tag: 0),
        User(coordinate: CLLocationCoordinate2D(latitude: 56.442701, longitude: 10.148295), tag: 1)
    ]

    var body: some View {

        Map(selection: $selectedMarker){

            ForEach(dataSet) { user in
                Marker(coordinate: user.coordinate) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 32))
                        .foregroundColor(.blue)
                }.tag(user.tag)
            }

            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }

        }
            .edgesIgnoringSafeArea(.all)
            .onChange(of: selectedMarker) { oldValue, newValue in
                guard let newValue, let oldValue else { return }
                let source = getLocationFrom(tag: oldValue)
                let destination = getLocationFrom(tag: newValue)
                guard let source, let destination else { return }
                getDirections(source: source, destination: destination)
            }
    }
    private func getLocationFrom(tag: Int) -> CLLocation?{
        let user = dataSet.first{$0.tag == tag}
        guard let user else { return nil }
        return CLLocation(
            latitude: user.coordinate.latitude,
            longitude: user.coordinate.longitude
        )
    }

   private func getDirections(source: CLLocation, destination: CLLocation) {
        route = nil
       selectedMarker = nil
        let request = MKDirections.Request()
        request.transportType = .walking
        request.source = MKMapItem(
            location: source,
            address: nil
        )
        request.destination = MKMapItem(
            location: destination,
            address: nil
        )
        Task {
            let directions = MKDirections(request: request)
            let response = try? await directions.calculate()
            withAnimation {
                route = response?.routes.first
            }
        }
    }

}

#Preview {
    ContentView().environment(LocationManager())
}
