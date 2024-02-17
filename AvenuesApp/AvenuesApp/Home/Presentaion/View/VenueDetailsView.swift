//
//  VenueDetailsView.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 17/02/2024.
//

import SwiftUI

struct VenueDetailsView: View {
    var venue: Venue
    
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Name: \(venue.name)")
            Text("Address: \(venue.location.fullAddress)")
            Text("Category: \(venue.categories.first?.name ?? "")")
            HStack {
                Spacer()
                image(url: venue.categories.first?.iconURL())
                Spacer()
            }
        }
        .padding(20)
        .background(Color.gray)
    }
    
    func image(url: URL?) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 80, height: 80)
                
            default:
                Image(systemName: "location.fill.viewfinder")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.white)
                    .frame(width: 50, height: 50)
            }
        }
    }
}
