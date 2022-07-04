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
    @EnvironmentObject var coordinator: Coordinator
    
    @State private var foo: String?
    
    var body: some View {
    
        VStack(spacing: 20) {
            Spacer().frame(height: 75)
            TextField("Email", text: $email)
            Divider()
            SecureField("Password", text: $password)
            Divider()
            
            Button {
                // action
                vm.register(email: email, password: password) { result in
                    switch result {
                        case .success(_):
                            coordinator.path.append(Route.login)
                        case .failure(let error):
                            vm.errorMessage = error.errorMessage
                    }
                }
            } label: {
                Text("Register")
                    .frame(maxWidth: .infinity, maxHeight: 44)
            }.buttonStyle(.borderedProminent)
            .tint(.black)
            .padding([.top], 20)
            
            
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
