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
    let tweetService = TweetService()
    
    var db: Firestore
    
    init() {
        db = Firestore.firestore()
    }
    
    func saveTweet(tweet: Tweet, completion: @escaping (Result<Bool, FBError>) -> Void) {
       
        tweetService.addTweet(tweet: tweet) { result in
            switch result {
                case .success(let saved):
                    completion(.success(saved))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
}
