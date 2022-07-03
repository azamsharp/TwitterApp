//
//  View+Extensions.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import Foundation
import SwiftUI

extension View {
    
    func embedNavigationStack() -> some View {
        NavigationStack {
            self
                .navigationDestination(for: Route.self) { route in
                    switch route {
                        case .login:
                            Text("Login")
                        case .register:
                            Text("Register")
                    }
                }
        }
    }
}



