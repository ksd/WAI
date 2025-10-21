// WAIApp.swift
// Project: WAI 
// Compiled with Swift version 6.0
//
// Created by ksd/Kaj Schermer Didriksen on 21/10/2025 at 11.17.
// Copyright © 2025 ksd. All rights reserved.
//
// 

import SwiftUI

@main
struct WAIApp: App {
    @State private var locationManager = LocationManager()
    var body: some Scene {
        WindowGroup {
            ContentView().environment(locationManager)
        }
    }
}
