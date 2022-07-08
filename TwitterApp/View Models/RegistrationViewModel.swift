//
//  RegistrationViewModel.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/3/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift


class RegistrationViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func register(name: String, username: String, email: String, password: String, completion: @escaping (Result<Bool, FBError>) -> Void) {
        
        Auth.auth().createUser(withEmail: email, password: password) { [weak self] result, error in
            
            if let error {
                   completion(.failure(.error(error.localizedDescription)))
            } else if let result {
                
                // save user name and username in Firestore
                self?.db.collection("users").document(result.user.uid).setData(
                    ["name": name,"username": username]
                ) { error in
                    if let error {
                        completion(.failure(.error(error.localizedDescription)))
                    } else {
                        completion(.success(true))
                    }
                }
            }
        }
            
    }
    
}
