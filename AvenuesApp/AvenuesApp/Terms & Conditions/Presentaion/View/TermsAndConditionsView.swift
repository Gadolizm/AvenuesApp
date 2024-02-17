//
//  TermsAndConditionsView.swift
//  AvenuesApp
//
//  Created by Haitham Gado on 17/02/2024.
//

import SwiftUI

struct TermsAndConditionsView: View {
    @Binding var presentSideMenu: Bool
    
    let terms = [
        "The content of the pages of this app is for your general information and use only. It is subject to change without notice.",
        "Neither we nor any third parties provide any warranty or guarantee as to the accuracy, timeliness, performance, completeness, or suitability of the information and materials found or offered on this app for any particular purpose.",
        "Your use of any information or materials on this app is entirely at your own risk, for which we shall not be liable. It shall be your own responsibility to ensure that any products, services, or information available through this app meet your specific requirements.",
        "This app contains material which is owned by or licensed to us. This material includes, but is not limited to, the design, layout, look, appearance, and graphics. Reproduction is prohibited other than in accordance with the copyright notice, which forms part of these terms and conditions.",
        "All trademarks reproduced in this app, which is not the property of, or licensed to the operator, are acknowledged on the app.",
        "Unauthorized use of this app may give rise to a claim for damages and/or be a criminal offense.",
        "From time to time, this app may also include links to other apps. These links are provided for your convenience to provide further information. They do not signify that we endorse the app(s). We have no responsibility for the content of the linked app(s).",
        "Your use of this app and any dispute arising out of such use of the app is subject to the laws of your country.",
    ]
    
    
    
    var body: some View {
        VStack {
            
            headerView
            
            ScrollView{
                VStack(alignment: .leading, spacing: 20) {
                    ForEach(terms, id: \.self) { term in
                        Text(term)
                    }
                }
            }
            .padding(.horizontal)
            .ignoresSafeArea()
        }
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
            Text("Terms & Conditions")
                .font(.largeTitle)
                .foregroundColor(.blue)
                .frame(maxWidth: .infinity, alignment: .center)
        }
    }
}
