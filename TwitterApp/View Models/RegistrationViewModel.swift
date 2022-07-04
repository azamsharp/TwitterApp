//
//  RegistrationViewModel.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import Foundation
import FirebaseAuth

enum RegistrationError: Error, Identifiable {
    case invalidCredentials
    
    var id: UUID {
        UUID() 
    }
}

class RegistrationViewModel: ObservableObject {
    
    @Published var error: RegistrationError?
    
    func register(email: String, password: String, completion: @escaping (Result<Bool, RegistrationError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if error != nil {
                DispatchQueue.main.async {
                    completion(.failure(.invalidCredentials))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }
        }
            
    }
    
}
