//
//  ProfileView.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 17/02/2024.
//

import SwiftUI


struct ProfileView: View {
    
    
    @Binding var presentSideMenu: Bool
    @ObservedObject var viewModel: ProfileViewModel = ProfileViewModel()
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {
            headerView
            VStack(alignment: .leading, spacing: 10) {
                Text("Name:")
                    .font(.headline)
                    .foregroundColor(.blue)
                Text("\(viewModel.name)")
                    .font(.title)
                    .foregroundColor(.black)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Email:")
                    .font(.headline)
                    .foregroundColor(.blue)
                Text("\(viewModel.email)")
                    .font(.title)
                    .foregroundColor(.black)
            }
            
            VStack(alignment: .leading, spacing: 10) {
                Text("Age:")
                    .font(.headline)
                    .foregroundColor(.blue)
                Text("\(viewModel.age)")
                    .font(.title)
                    .foregroundColor(.black)
            }
            Spacer()
        }
        .padding()
        .onAppear(perform: {
            viewModel.retrieveUserInfo()
        })
    }
    
    var headerView: some View {
        ZStack{
            HStack{
                Button(action: {
                    presentSideMenu.toggle()
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                        .padding(.leading)
                        .foregroundColor(.gray)
                }
                .frame(alignment: .leading)
                Spacer()
            }
            Text("Profile")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}



