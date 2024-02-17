//
//  RegistrationViewModel.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 17/02/2024.
//

import SwiftUI
import Combine

class RegistrationViewModel: ObservableObject {
    @Published var firstName = ""
    @Published var lastName = ""
    @Published var age = ""
    @Published var email = ""
    @Published var password = ""
    
    private var cancellables: Set<AnyCancellable> = []
    
    func isValidAge() -> Bool {
        guard let ageValue = Int(age) else { return false }
        return ageValue >= 18
    }
    
    func isValidPassword() -> Bool {
        let passwordRegex = "^(?=.*[A-Za-z])(?=.*\\d)(?=.*[@$!%*?&])[A-Za-z\\d@$!%*?&]{8,}$"
        return NSPredicate(format: "SELF MATCHES %@", passwordRegex).evaluate(with: password)
    }
    
    // Helper function to validate email format
    func isValidEmail(_ email: String) -> Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: email)
    }
    
    func isFormValid() -> Bool {
        return !firstName.isEmpty &&
        !lastName.isEmpty &&
        !age.isEmpty &&
        !email.isEmpty &&
        isValidAge() &&
        isValidEmail(email) &&
        isValidPassword()
    }
    
    func registerUser(completion: () -> Void) {
        
        guard isValidAge() && isValidPassword() else {
            print("Invalid registration details.")
            return
        }
        
        print("Registration successful!")
        self.saveUserDetails()
        completion()
    }
    
    
    func saveUserDetails() {
        // Save registration details in UserDefaults
        let userDetails: [String: Any] = ["firstName": firstName,
                                          "lastName": lastName,
                                          "email": email,
                                          "age": age,
                                          "password": password]
        
        UserDefaults.standard.set(userDetails, forKey: "userDetails")
    }
}
