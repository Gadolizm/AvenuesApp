//
//  MainTabbedView.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 17/02/2024.
//

import SwiftUI

struct MainTabbedView: View {
    
    @State var presentSideMenu = false
    @State var selectedSideMenuTab = 0
    
    var body: some View {
        ZStack{
            
            TabView(selection: $selectedSideMenuTab) {
                HomeView(presentSideMenu: $presentSideMenu)
                    .tag(0)
                    .toolbar(.hidden, for: .tabBar)
                ProfileView(presentSideMenu: $presentSideMenu)
                    .tag(1)
                    .toolbar(.hidden, for: .tabBar)
                TermsAndConditionsView(presentSideMenu: $presentSideMenu)
                    .tag(2)
                    .toolbar(.hidden, for: .tabBar)
                LoginView(presentSideMenu: $presentSideMenu)
                    .tag(3)
                    .toolbar(.hidden, for: .tabBar)
            }
            SideMenu(isShowing: $presentSideMenu, content: AnyView(SideMenuView(selectedSideMenuTab: $selectedSideMenuTab, presentSideMenu: $presentSideMenu)))
        }
    }
}
