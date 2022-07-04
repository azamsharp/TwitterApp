//
//  NavigationBarContainerScreen.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import SwiftUI

struct NavigationBarContainerScreen: View {
    var body: some View {
       
        VStack {
            
            LandingScreen()
               // .embedNavigationStack()
            
                .toolbar {
                    ToolbarItem(placement: .principal) {
                        Image(Constants.Icons.twitterIcon)
                            .resizable()
                            .frame(width: 50, height: 50)
                    }
                }
        }
        
    }
}

struct NavigationBarContainerScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationBarContainerScreen()
            .embedNavigationStack()
    }
}
