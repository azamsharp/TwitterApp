//
//  RegistrationScreen.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    
    @StateObject private var vm = RegistrationViewModel()
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 75)
            TextField("Email", text: $email)
            Divider()
            SecureField("Password", text: $password)
            Divider()
            
            Button {
                // action
                vm.register(email: email, password: password)
            } label: {
                Text("Register")
                    .frame(maxWidth: .infinity, maxHeight: 44)
            }.buttonStyle(.borderedProminent)
            .tint(.black)
            .padding([.top], 20)

            
            Spacer()
            .navigationTitle("Registeration")
        }.padding()
    }
}

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationScreen()
            .embedNavigationStack()
    }
}
