//
//  AvenuesAppApp.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 13/02/2024.
//

import SwiftUI

@main
struct AvenuesAppApp: App {
    
    init() {
        // Initialize Google Maps SDK
        GoogleMapsProvider.initialize()
    }
    var body: some Scene {
        WindowGroup {
            MainTabbedView()
        }
    }
}
