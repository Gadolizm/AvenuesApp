//
//  AvenueListItemView.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 16/02/2024.
//

import SwiftUI

struct AvenueListItemView: View {
    
    let data: Venue
    var body: some View {
        
        VStack(alignment: .leading){
            HStack {
                Text("Name:")
                Text(data.name)
                Spacer()
            }
            HStack {
                Text("Location:")
                Text(data.location.fullAddress)
            }
            HStack {
                Text("Category:")
                Text(data.categories.first?.name ?? "")
                image(url: data.categories.first?.iconURL())
            }
        }
        .padding()
        
        .background(
            RoundedRectangle(cornerRadius: 10)
                .stroke(Color.black, lineWidth: 2)
                .fill(Color.gray)
        )
    }
    
    func image(url: URL?) -> some View {
        AsyncImage(url: url) { phase in
            switch phase {
                
            case .success(let image):
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 40, height: 40)
            default:
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .foregroundColor(.white)
                    .frame(width: 25, height: 25)
            }
        }
    }
}
