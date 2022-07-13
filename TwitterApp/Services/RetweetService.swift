//
//  RetweetService.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class RetweetService {
    
    var db: Firestore = Firestore.firestore()
    let twitterService = TweetService()
    
    func retweet(tweet: Tweet, userId: String, completion: @escaping (Result<Bool, FBError>) -> Void) {
        
        var tweet = tweet
        tweet.dateUpdated = Date()
        
        twitterService.addTweet(tweet: tweet) { result in
            switch result {
                case .success(let retweeted):
                    completion(.success(retweeted))
                case .failure(let error):
                    completion(.failure(error))
            }
        }
    }
    
    
    func toggleRetweet(tweet: Tweet, userId: String) async {
        
        guard let tweetDocumentId = tweet.documentID else {
            return
        }
        
        if tweet.retweets.contains(userId) {
            await removeRetweet(tweetDocumentId: tweetDocumentId, userId: UserDefaults.userId)
        } else {
            await addRetweet(tweetDocumentId: tweetDocumentId, userId: UserDefaults.userId)
        }
      
    }
    
    private func addRetweet(tweetDocumentId: String, userId: String) async {
        
        do {
            try await db.collection("tweets").document(tweetDocumentId)
                .updateData(
                    ["retweets": FieldValue.arrayUnion([userId])]
                )
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func removeRetweet(tweetDocumentId: String, userId: String) async {
        
        do {
            try await db.collection("tweets").document(tweetDocumentId)
                .updateData(
                    ["retweets": FieldValue.arrayRemove([userId])]
                )
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
