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
    
    func toggleRetweet(tweet: Tweet, userId: String) async {
        
        guard let tweetDocumentId = tweet.documentID else {
            return
        }
        
        if tweet.retweets != nil {
            if let retweets = tweet.retweets {
                if retweets.contains(userId) {
                    await removeRetweet(tweetDocumentId: tweetDocumentId, userId: UserDefaults.userId)
                } else {
                    await addRetweet(tweetDocumentId: tweetDocumentId, userId: UserDefaults.userId)
                }
            }
            
        } else {
            // add the tweet
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
