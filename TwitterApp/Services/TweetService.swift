//
//  TweetService.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/13/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TweetService {
    
    var db: Firestore = Firestore.firestore()
        
    func addTweet(tweet: Tweet, completion: @escaping (Result<Bool, FBError>) -> Void) {
         
        db.collection("tweets").addDocument(data: tweet.toDictionary()) { error in
            if let error = error {
                completion(.failure(.error(error.localizedDescription)))
            } else {
                // tweet saved successfully
                completion(.success(true))
            }
        }
        
        /*
        do {
            let _ = try db.collection("tweets").addDocument(data: tweet.toDictionary()) { error in
                if let error = error {
                    completion(.failure(.error(error.localizedDescription)))
                } else {
                    // tweet saved successfully
                    completion(.success(true))
                }
            }
            
        } catch {
            completion(.failure(.error(error.localizedDescription)))
        } */
            
    }
    
}
