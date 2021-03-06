//
//  LoginScreen.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/4/22.
//

import SwiftUI

struct LoginScreen: View {
    
    @State private var email: String = "azamsharp@gmail.com"
    @State private var password: String = "password"
    
    @StateObject private var vm = LoginViewModel()
    @EnvironmentObject var coordinator: Coordinator
    
    var body: some View {
        VStack(spacing: 20) {
            Spacer().frame(height: 75)
            TextField("Email", text: $email)
                .textInputAutocapitalization(.never)
                .disableAutocorrection(true)
            Divider()
            SecureField("Password", text: $password)
            Divider()
            
            Button {
                // action
                vm.login(email: email, password: password) { result in
                    switch result {
                        case .success(let userInfo):
                            if let userInfo {
                                
                                UserDefaults.isSignedIn = true
                                UserDefaults.userId = userInfo.userId
                                UserDefaults.name = userInfo.name
                                UserDefaults.username = userInfo.username 
                                // go to the timeline screen
                                coordinator.path.append(.home)
                            }
                        case .failure(let error):
                            vm.errorMessage = error.errorMessage
                    }
                }
                
            } label: {
                Text("Login")
                    .frame(maxWidth: .infinity, maxHeight: 44)
            }.buttonStyle(.borderedProminent)
            .tint(.black)
            .padding([.top], 20)
            
            Spacer()
            .navigationTitle("Login")
        }.padding()
            .alert(item: $vm.errorMessage) { errorMessage in
                Alert(title: Text("Authentication failed"), message: Text(errorMessage))
            }

    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen().embedNavigationStack()
    }
}
