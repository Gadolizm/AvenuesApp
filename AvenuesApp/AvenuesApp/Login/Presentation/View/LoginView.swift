//
//  LoginView.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 17/02/2024.
//

import SwiftUI

struct LoginView: View {
    @ObservedObject var viewModel: LoginViewModel = LoginViewModel()
    @State private var isPasswordVisible: Bool = false
    @Binding var presentSideMenu: Bool
    @State private var isLogInSuccessful = false
    
    
    var body: some View {
        NavigationView {
            VStack {
                TextField("Email", text: $viewModel.email)
                    .padding()
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                
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
                
                
                Button("Login") {
                    viewModel.loginUser{
                        isLogInSuccessful = true
                    }
                }
                .disabled(!viewModel.isValidLogInInfo())
                .padding()
                .foregroundColor(.white)
                .background(viewModel.isValidLogInInfo() ? Color.blue : Color.gray)
                .cornerRadius(8)
                
                switch viewModel.loginStatus {
                case .none:
                    EmptyView()
                case .success:
                    Text("Login successful!")
                        .foregroundColor(.green)
                case .failure(let errorMessage):
                    Text(errorMessage)
                        .foregroundColor(.red)
                }
                NavigationLink(isActive: $isLogInSuccessful,
                               destination: {
                    MainTabbedView()
                        .navigationBarBackButtonHidden(true)
                },
                               label: { EmptyView() }
                )
            }
            .navigationBarTitle("Login")
        }
        .padding()
    }
}
