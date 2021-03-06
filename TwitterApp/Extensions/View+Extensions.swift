//
//  View+Extensions.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import Foundation
import SwiftUI



extension View {
    
    
    func appLogoToolbar() -> some View {
        self.toolbar {
            ToolbarItem(placement: .principal) {
                Image(Constants.Icons.twitterIcon)
                    .resizable()
                    .frame(width: 50, height: 50)
            }
        }
    }
    
    func embedNavigationStack() -> some View {
        
        @EnvironmentObject var appRoute: Coordinator
        
        return NavigationStack {
            self
                .navigationDestination(for: Route.self) { route in
                    switch route {
                        case .login:
                            Text("Login")
                        case .register:
                            RegistrationScreen()
                        case .home:
                            HomeScreen()
                        case .detail:
                            Text("DETAIL")
                    }
                }//.appLogoToolbar()
        }
    }
}



