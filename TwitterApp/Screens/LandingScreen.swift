//
//  LandingScreen.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import SwiftUI

struct LandingScreen: View {
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("See what's happening \n in the world right now")
                .fontWeight(.bold)
                .font(.largeTitle)
                .padding([.bottom], 100)
            
            NavigationLink(value: Route.register) {
                Text("Create account")
                    .frame(maxWidth: .infinity, maxHeight: 44)
            }.buttonStyle(.borderedProminent)
                .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                .padding()
                .tint(.black)
               
            Spacer()
            HStack {
                Text("Have an account already?")
                NavigationLink("Login", value: Route.login)
                Spacer()
            }.padding()
            
                .appLogoToolbar()
            
        }
    }
}

struct LandingScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack {
            LandingScreen()
                .embedNavigationStack()
        }
    }
}
