//
//  TimelineScreen.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/4/22.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView {
                Text("Home Screen")
                    .tabItem {
                        Label("Home", systemImage: "house")
                    }
                
                Text("Search")
                    .tabItem {
                        Label("Search", systemImage: "magnifyingglass")
                    }
                
                Text("Notifications")
                    .tabItem {
                        Label("Notifications", systemImage: "bell")
                    }
                
                Text("Direct Message")
                    .tabItem {
                        Label("Direct Message", systemImage: "envelope")
                    }
            }
            
            // add tweet button
            Button {
                // add tweet button
            } label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 50))
                    
                    
            }.padding([.bottom], 60)
                .padding([.trailing], 20)

        }
        
       
    }
}

struct TimelineScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}