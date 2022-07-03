//
//  TwitterAppApp.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import SwiftUI


enum Route: Hashable {
    case login
    case register
}


@main
struct TwitterAppApp: App {
    var body: some Scene {
        WindowGroup {
            NavigationStack {
                LandingScreen()
                    .embedNavigationStack()
            }
        }
    }
}
