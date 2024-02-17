//
//  SideMenuRowType.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 17/02/2024.
//

import Foundation

enum SideMenuRowType: Int, CaseIterable{
    case home = 0
    case profile
    case termsAndConditions
    case logout
    
    var title: String{
        switch self {
        case .home:
            return "Home"
        case .profile:
            return "Profile"
        case .termsAndConditions:
            return "Terms & Conditions"
        case .logout:
            return "Logout"
        }
    }
    
    var iconName: String{
        switch self {
            
        case .home:
            return "house"
        case .profile:
            return "person.crop.circle.fill"
        case .termsAndConditions:
            return "doc.plaintext"
        case .logout:
            return "door.left.hand.closed"
            
        }
    }
}
