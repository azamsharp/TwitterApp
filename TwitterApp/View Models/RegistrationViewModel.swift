//
//  RegistrationViewModel.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import Foundation
import FirebaseAuth

enum RegistrationStatus {
    case success(User)
    case error(Error?)
    case none
}

class RegistrationViewModel: ObservableObject {
    
    @Published var status: RegistrationStatus = .none
    
    func register(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            if let error {
                DispatchQueue.main.async {
                    self?.status = .error(error)
                }
            } else if let user = result?.user {
                self?.status = .success(user)
            }   
        }
            
    }
    
}
