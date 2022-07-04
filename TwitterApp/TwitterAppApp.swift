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

class Coordinator: ObservableObject {
    @Published var path = [Route]()
}

/*
struct RootView: View {
    
    @EnvironmentObject var routePath: Coordinator
    
    var body: some View {
        NavigationStack(path: $routePath.path) {
            LandingScreen()
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case .login:
                        Text("Login")
                    case .register:
                        RegistrationScreen()
                    }
                }
        }
        
    }
} */

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
                            Text("Login")
                        case .register:
                            RegistrationScreen()
                        }
                    }
                   
            } .environmentObject(coordinator)
        }
    }
}
