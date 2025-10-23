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



struct ContentView: View {
    @State private var selectedMarker: Int?
    @State private var route: MKRoute?
    @Environment(LocationManager.self) var locationManager

    var body: some View {

        Map(selection: $selectedMarker){

            ForEach(locationManager.dataSet) { user in
                Marker(coordinate: user.coordinate) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 32))
                }.tag(user.tag)
                    .tint(.green)
            }
            if let userLocation = locationManager.userLocation {
                Marker(
                    coordinate: CLLocationCoordinate2D(
                        latitude: userLocation.coordinate.latitude,
                        longitude: userLocation.coordinate.longitude)
                ) {
                    Image(systemName: "person.fill")
                        .font(.system(size: 32))

                }.tag(2)
                    .tint(.blue)
            }
            if let route {
                MapPolyline(route)
                    .stroke(.blue, lineWidth: 5)
            }

        }
        .edgesIgnoringSafeArea(.all)

        /// viser på kortet, hvor du er. Hvis du har givet lov:)
        .mapControls({
            MapCompass()
            MapUserLocationButton()
        })
        .controlSize(.large)

        .onChange(of: selectedMarker) { oldValue, newValue in
            guard let newValue, let oldValue else { return }
            let source = getLocationFrom(tag: oldValue)
            let destination = getLocationFrom(tag: newValue)
            guard let source, let destination else { return }
            getDirections(source: source, destination: destination)
        }
    }
    private func getLocationFrom(tag: Int) -> CLLocation?{
        let user = locationManager.dataSet.first{$0.tag == tag}
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
