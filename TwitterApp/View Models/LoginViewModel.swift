//
//  LoginViewModel.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/4/22.
//

import Foundation
import FirebaseAuth
import FirebaseFirestore
import FirebaseFirestoreSwift

class LoginViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    var db: Firestore = Firestore.firestore()
    
    func login(email: String, password: String, completion: @escaping (Result<UserInfo?,FBError>) -> Void) {
        
        Auth.auth().signIn(withEmail: email, password: password) { [weak self] result, error in
            if let error {
                completion(.failure(.error(error.localizedDescription)))
            } else {
                
                if let result {
                    
                    self?.db.collection("users").document(result.user.uid).getDocument(as: UserInfo.self) { result in
                        switch result {
                            case .success(let userInfo):
                                completion(.success(userInfo))
                            case .failure(let error):
                                completion(.failure(.error(error.localizedDescription)))
                        }
                    }
                }
            }
        }
        
    }
    
}
