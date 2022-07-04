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
    case timeline
}

class Coordinator: ObservableObject {
    @Published var path = [Route]()
}

@main
struct TwitterAppApp: App {
    
    @ObservedObject var coordinator = Coordinator()
    
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            NavigationStack(path: $coordinator.path) {
                LandingScreen()
                    .navigationDestination(for: Route.self) { route in
                        switch route {
                        case .login:
                                LoginScreen().appLogoToolbar()
                        case .register:
                                RegistrationScreen().appLogoToolbar()
                        case .timeline:
                                TimelineScreen() 
                        }
                    }
                   
            } .environmentObject(coordinator)
        }
    }
}
