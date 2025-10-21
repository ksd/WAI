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
    var body: some View {
        Map()
            .edgesIgnoringSafeArea(.all)
    }
}

#Preview {
    ContentView()
}
