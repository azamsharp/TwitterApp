//
//  ComposeTweetViewModel.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/8/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class ComposeTweetViewModel: ObservableObject {
    
    @Published var errorMessage: String? 
    
    var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    
    func saveTweet(tweet: Tweet, completion: @escaping (Result<Bool, FBError>) -> Void) {
        
        do {
            
            let _ = try db.collection("tweets").addDocument(from: tweet) { error in
                if let error = error {
                    completion(.failure(.error(error.localizedDescription)))
                } else {
                    // tweet saved successfully
                    completion(.success(true))
                }
            }
            
        } catch {
            
        }
    }
    
    
}
