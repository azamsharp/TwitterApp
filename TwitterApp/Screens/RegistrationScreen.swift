//
//  RegistrationScreen.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import SwiftUI

struct RegistrationScreen: View {
    
    @State private var name: String = ""
    @State private var username: String = ""
    @State private var email: String = ""
    @State private var password: String = ""
    
    @StateObject private var vm = RegistrationViewModel()
    @EnvironmentObject var coordinator: Coordinator
    
    @State private var foo: String?
    
    var body: some View {
    
        VStack(spacing: 20) {
            Group {
                Spacer().frame(height: 15)
                TextField("Name", text: $name)
                Divider()
                TextField("Username", text: $username)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                Divider()
                TextField("Email", text: $email)
                    .textInputAutocapitalization(.never)
                    .disableAutocorrection(true)
                Divider()
                SecureField("Password", text: $password)
                Divider()
            }
            
            Button {
                // action
                Task {
                    let isRegistered = await vm.register(name: name, username: username.lowercased(), email: email, password: password)
                    if isRegistered {
                        coordinator.path.append(.login)
                    }
                }
                
            } label: {
                Text("Register")
                    .frame(maxWidth: .infinity, maxHeight: 44)
            }.buttonStyle(.borderedProminent)
            .tint(.black)
            .padding([.top], 50)
            Spacer()
            
            .navigationTitle("Registeration")
        }.padding()
            .alert(item: $vm.errorMessage) { errorMessage in
                Alert(title: Text("Registration failed"), message: Text(errorMessage))
            }
    }
}

struct RegistrationScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegistrationScreen()
            .embedNavigationStack()
    }
}
