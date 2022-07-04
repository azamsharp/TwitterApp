//
//  RegistrationViewModel.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import Foundation
import FirebaseAuth

class RegistrationViewModel: ObservableObject {
    
    @Published var message: String = ""
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error {
                print(error)
                DispatchQueue.main.async {
                    self?.message = error.localizedDescription
                }
            } else {
                // account has been created
                print("account created")
            }
                
        }
            
    }
    
}
