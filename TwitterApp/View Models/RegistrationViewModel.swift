//
//  RegistrationViewModel.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import Foundation
import FirebaseAuth


class RegistrationViewModel: ObservableObject {
    
    @Published var errorMessage: String? 
    
    func register(email: String, password: String, completion: @escaping (Result<Bool, FBError>) -> Void) {
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
            
            if let error {
                DispatchQueue.main.async {
                    print(error)
                    completion(.failure(.error(error.localizedDescription)))
                }
            } else {
                DispatchQueue.main.async {
                    completion(.success(true))
                }
            }
        }
            
    }
    
}
