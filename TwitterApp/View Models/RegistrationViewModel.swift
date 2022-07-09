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

@MainActor 
class RegistrationViewModel: ObservableObject {
    
    @Published var errorMessage: String?
    var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func register(name: String, username: String, email: String, password: String) async -> Bool {
        
        var isRegistered = false
        
        do {
            let userRef = db.collection("users").document(username)
            let userDoc = try await userRef.getDocument()
            if userDoc.exists {
                isRegistered = false
                errorMessage = "Username already taken!"
            } else {
                let result = try await Auth.auth().createUser(withEmail: email, password: password)
                // save in firestore
                try await self.db.collection("users").document(username)
                    .setData(["name": name,"username": username, "userId": result.user.uid])
                
                isRegistered = true
            }
        }
        catch {
            errorMessage = error.localizedDescription
        }
        
        return isRegistered
    }
}
