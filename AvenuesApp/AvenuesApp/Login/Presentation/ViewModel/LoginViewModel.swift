//
//  LoginViewModel.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 17/02/2024.
//

import Combine
import Foundation

class LoginViewModel: ObservableObject {
    @Published var email = ""
    @Published var password = ""
    
    @Published var loginStatus: LoginStatus = .none
    
    enum LoginStatus {
        case none
        case success
        case failure(String)
    }
    
    private var cancellables: Set<AnyCancellable> = []
    
    func loginUser(completion: () -> Void) {
        guard isValidEmail(email) && isValidPassword() else {
            self.loginStatus = .failure("Invalid email or password.")
            return
        }
        
        // Retrieve user details from UserDefaults
        if let userDetails = UserDefaults.standard.dictionary(forKey: "userDetails") {
            if let savedEmail = userDetails["email"] as? String,
               let savedPassword = userDetails["password"] as? String {
                if email == savedEmail && password == savedPassword {
                    self.loginStatus = .success
                    completion()
                } else {
                    self.loginStatus = .failure("Incorrect email or password.")
                }
            } else {
                self.loginStatus = .failure("Invalid user details. Please register first.")
            }
        } else {
            self.loginStatus = .failure("User not found. Please register first.")
        }
    }
    
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email) && !email.isEmpty
    }
    
    private func isValidPassword() -> Bool {
        
        return password.count >= 6
    }
    
    func isValidLogInInfo() -> Bool {
        return isValidEmail(email) && isValidPassword()
    }
}
