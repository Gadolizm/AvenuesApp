//
//  ContentView.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 13/02/2024.
//

import SwiftUI


struct HomeView: View {
    
    @StateObject var viewModel: HomeViewModel = HomeViewModel()
    @State private var selectedVenue: Venue?
    @State private var viewMapOrAvenuesList = true
    @State private var isSideMenuOpen = false
    @Binding var presentSideMenu: Bool
    
    var body: some View {
        VStack {
            headerView
            Toggle(isOn: $viewMapOrAvenuesList) {
                Text("View Avenues List or Map")
            }
            .frame(maxWidth: .infinity, alignment: .center)
            
            .padding(.horizontal, 20)
            
            if viewMapOrAvenuesList {
                avenueList
            } else {
                mapView
                    .ignoresSafeArea()
            }
        }
        .onAppear(perform: {
            viewModel.fetchData()
        })
    }
    
    var avenueList: some View {
        ScrollView{
            VStack {
                ForEach(viewModel.dataModel?.response.venues ?? [], id: \.id) { avenue in
                    AvenueListItemView(data: avenue)
                }
            }
            .padding()
        }
    }
    
    var mapView: some View {
        MapView(locations: viewModel.dataModel?.response.venues ?? [], selectedVenue: $selectedVenue)
            .ignoresSafeArea()
            .overlay(
                venueDetailsViewOverLay
            )
    }
    
    var venueDetailsViewOverLay: some View {
        VStack() {
            Spacer()
            if let venue = selectedVenue {
                VenueDetailsView(venue: venue)
                    .background(Color.white)
                    .cornerRadius(10)
                    .padding()
                    .shadow(radius: 5)
                    .onTapGesture {
                        selectedVenue = nil
                    }
                    .transition(.slide)
            }
        }
    }
    
    var headerView: some View {
        ZStack{
            HStack{
                Button(action: {
                    presentSideMenu.toggle()
                }) {
                    Image(systemName: "line.horizontal.3") // Use a side menu icon
                        .imageScale(.large)
                        .padding(.leading)
                        .foregroundColor(.gray)
                }
                .frame(alignment: .leading)
                Spacer()
            }
            Text("Home")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}

