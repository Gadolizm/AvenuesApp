//
//  MapView.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 16/02/2024.
//


import SwiftUI
import GoogleMaps

struct MapView: UIViewRepresentable {
    var locations: [Venue]
    @Binding var selectedVenue: Venue?
    
    func makeUIView(context: Context) -> GMSMapView {
        let mapView = GMSMapView()
        mapView.delegate = context.coordinator
        return mapView
    }
    
    func updateUIView(_ uiView: GMSMapView, context: Context) {
        uiView.clear()
        
        for location in locations {
            let marker = GMSMarker(position: CLLocationCoordinate2D(latitude: location.location.lat, longitude: location.location.lng))
            marker.title = location.name
            marker.snippet = location.location.fullAddress
            marker.userData = location
            marker.map = uiView
        }
        // Focus the camera on the area of the pins
        if let bounds = boundingBox() {
            let update = GMSCameraUpdate.fit(bounds, withPadding: 50.0)
            uiView.animate(with: update)
        }
    }
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    
    // Function to calculate the bounding box of all locations
    private func boundingBox() -> GMSCoordinateBounds? {
        guard let firstLocation = locations.first else {
            return nil
        }
        
        var bounds = GMSCoordinateBounds(coordinate: CLLocationCoordinate2D(latitude: firstLocation.location.lat, longitude: firstLocation.location.lng), coordinate: CLLocationCoordinate2D(latitude: firstLocation.location.lat, longitude: firstLocation.location.lng))
        
        for location in locations {
            bounds = bounds.includingCoordinate(CLLocationCoordinate2D(latitude: location.location.lat, longitude: location.location.lng))
        }
        return bounds
    }
    
}

class Coordinator: NSObject, GMSMapViewDelegate {
    var parent: MapView
    
    init(_ parent: MapView) {
        self.parent = parent
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool {
        // Retrieve the venue associated with the tapped marker
        if let venue = marker.userData as? Venue {
            parent.selectedVenue = venue
        }
        return true
    }
}
