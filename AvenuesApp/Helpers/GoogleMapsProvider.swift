//
//  GoogleMapsProvider.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 16/02/2024.
//

import Foundation
import GoogleMaps
import GooglePlaces

class GoogleMapsProvider {
    static func initialize() {
        GMSServices.provideAPIKey("AIzaSyBrRSgDSEL2PpJ_iUY1i5_jmhir3DC4_WI")
        GMSPlacesClient.provideAPIKey("AIzaSyBrRSgDSEL2PpJ_iUY1i5_jmhir3DC4_WI")
    }
}
