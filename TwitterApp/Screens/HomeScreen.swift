//
//  TimelineScreen.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/4/22.
//

import SwiftUI

struct HomeScreen: View {
    
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottomTrailing) {
            TabView {
                HomeTimelineScreen()
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
            
            Button {
                // add tweet button
                isPresented = true
            } label: {
                Image(systemName: "plus.circle.fill")
                    .foregroundColor(.blue)
                    .font(.system(size: 50))
                    
                    
            }.padding([.bottom], 60)
                .padding([.trailing], 20)

        }.sheet(isPresented: $isPresented) {
            ComposeTweetScreen()
        }
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen()
    }
}
