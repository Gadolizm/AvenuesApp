//
//  AvenuesDataModel.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 13/02/2024.
//

import Foundation

// MARK: - Welcome
struct AvenuesDataModel: Codable {
    let meta: Meta
    let response: Response
}

// MARK: - Meta
struct Meta: Codable {
    let code: Int
    let requestID: String
    
    enum CodingKeys: String, CodingKey {
        case code
        case requestID = "requestId"
    }
}

// MARK: - Response
struct Response: Codable {
    let venues: [Venue]
    let confident: Bool
}

// MARK: - Venue
struct Venue: Codable {
    let id, name: String
    let location: Location
    let categories: [Category]
    let createdAt: Int
    
    var fullAddress: String {
        return location.fullAddress
    }
}

// MARK: - Category
struct Category: Codable {
    let id, name, pluralName, shortName: String
    let icon: Icon
    let mapIcon: String
    let primary: Bool
    
    // Function to generate URL for the icon
    func iconURL(size: String = "88") -> URL? {
        let urlString = icon.iconPrefix + size + icon.suffix.rawValue
        return URL(string: urlString)
    }
}

// MARK: - Icon
struct Icon: Codable {
    let iconPrefix: String
    let suffix: Suffix
    
    enum CodingKeys: String, CodingKey {
        case iconPrefix = "prefix"
        case suffix
    }
}

enum Suffix: String, Codable {
    case png = ".png"
}

// MARK: - Location
struct Location: Codable {
    let address: String?
    let lat, lng: Double
    let labeledLatLngs: [LabeledLatLng]
    let distance: Int
    let postalCode: String?
    let cc: String
    let city: String?
    let state: String?
    let country: String
    let formattedAddress: [String]
    let crossStreet: String?
    
    var fullAddress: String {
        var components: [String] = []
        
        if let address = address {
            components.append(address)
        }
        
        if let crossStreet = crossStreet {
            components.append(crossStreet)
        }
        
        if let postalCode = postalCode {
            components.append(postalCode)
        }
        
        if let city = city {
            components.append(city)
        }
        
        if let state = state {
            components.append(state)
        }
        components.append(country)
        return components.joined(separator: ", ")
    }
}


// MARK: - LabeledLatLng
struct LabeledLatLng: Codable {
    let label: String
    let lat, lng: Double
}

