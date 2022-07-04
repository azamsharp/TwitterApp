//
//  TwitterAppApp.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import SwiftUI
import FirebaseCore

enum Route: Hashable {
    case login
    case register
}


@main
struct TwitterAppApp: App {
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LandingScreen()
                    .embedNavigationStack()
            }
        }
    }
}
