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
    @Environment(LocationManager.self) var locationManager
    var body: some View {

        Map()
            .edgesIgnoringSafeArea(.all)
            .overlay {
                Text(
                    "location: \(locationManager.userLocation?.coordinate.latitude ?? 0)"
                )
            }
    }
}

#Preview {
    ContentView().environment(LocationManager())
}
