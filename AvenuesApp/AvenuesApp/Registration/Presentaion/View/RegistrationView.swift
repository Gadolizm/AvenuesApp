//
//  RegistrationView.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 17/02/2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @StateObject private var viewModel = RegistrationViewModel()
    @State private var isPasswordVisible: Bool = false
    @State private var isRegistrationSuccessful = false
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("First Name", text: $viewModel.firstName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Last Name", text: $viewModel.lastName)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                TextField("Age", text: $viewModel.age)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.numberPad)
                    .padding()
                
                TextField("Email", text: $viewModel.email)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .keyboardType(.emailAddress)
                    .padding()
                
                HStack {
                    VStack {
                        if isPasswordVisible {
                            TextField("Password", text: $viewModel.password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                        } else {
                            SecureField("Password", text: $viewModel.password)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .padding()
                        }
                    }
                    .overlay(
                        Button(action: {
                            isPasswordVisible.toggle()
                        }) {
                            Image(systemName: isPasswordVisible ? "eye.slash" : "eye")
                                .foregroundColor(.gray)
                        }
                            .padding(.trailing, 20)
                            .buttonStyle(PlainButtonStyle())
                        , alignment: .trailing
                    )
                }
                
                
                Button(action: {
                    viewModel.registerUser{
                        isRegistrationSuccessful = true
                    }
                }) {
                    Text("Register")
                        .padding()
                        .foregroundColor(.white)
                        .background(viewModel.isFormValid() ? Color.blue : Color.gray)
                        .cornerRadius(8)
                }
                .padding()
                .disabled(!viewModel.isFormValid())
                
                if viewModel.firstName.isEmpty {
                    Text("First Name cannot be empty.")
                        .foregroundColor(.red)
                }
                
                if viewModel.lastName.isEmpty {
                    Text("Last Name cannot be empty.")
                        .foregroundColor(.red)
                }
                
                if viewModel.email.isEmpty {
                    Text("Email cannot be empty.")
                        .foregroundColor(.red)
                } else if !viewModel.isValidEmail(viewModel.email) {
                    Text("Invalid email format.")
                        .foregroundColor(.red)
                }
                if !viewModel.isValidAge() {
                    Text("Age must be 18 or above.")
                        .foregroundColor(.red)
                }
                
                if !viewModel.isValidPassword() {
                    Text("Password must be 8 characters long with alphanumeric and special characters.")
                        .foregroundColor(.red)
                }
                NavigationLink(isActive: $isRegistrationSuccessful,
                               destination: {
                    MainTabbedView()
                        .navigationBarBackButtonHidden(true)
                },
                               label: { EmptyView() }
                )
            }
            
            .navigationBarTitle("User Registration")
            .padding()
        }
        
    }
}
#Preview {
    RegistrationView()
}
