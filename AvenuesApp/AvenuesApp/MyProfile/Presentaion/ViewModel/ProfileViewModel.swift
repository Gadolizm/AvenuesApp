//
//  ProfileViewModel.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 17/02/2024.
//

import Combine
import Foundation

class ProfileViewModel: ObservableObject {
    @Published var name = ""
    @Published var email = ""
    @Published var age = ""
    
    init() {
        retrieveUserInfo()
    }
    
    func retrieveUserInfo() {
        
        // Retrieve user details from UserDefaults
        if let userDetails = UserDefaults.standard.dictionary(forKey: "userDetails") {
            if let savedFirstName = userDetails["firstName"] as? String,
               let savedLastName = userDetails["lastName"] as? String,
               let savedEmail = userDetails["email"] as? String,
               let savedAge = userDetails["age"] as? String {
                self.name = ("\(savedFirstName) \(savedLastName)")
                self.email = savedEmail
                self.age = savedAge
            }
        }
    }
}
