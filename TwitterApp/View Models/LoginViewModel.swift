//
//  LoginViewModel.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/4/22.
//

import Foundation
import FirebaseAuth

class LoginViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    
    func login(email: String, password: String, completion: @escaping (Result<User?,FBError>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { result, error in
            if let error {
                completion(.failure(.error(error.localizedDescription)))
            } else {
                // user has been signed in
                completion(.success(result?.user))
            }
                
        }
        
    }
    
}
