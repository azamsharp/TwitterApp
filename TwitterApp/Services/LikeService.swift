//
//  LikeService.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/12/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class LikeService {
    
    var db: Firestore = Firestore.firestore()
    
    func toggleLike(tweet: Tweet, userId: String) async {
        
        guard let tweetDocumentId = tweet.documentID else {
            return
        }
        
        if tweet.likes.contains(UserDefaults.userId) {
            // remove the like
             await removeLike(tweetDocumentId: tweetDocumentId, userId: UserDefaults.userId)
        } else {
            await addLike(tweetDocumentId: tweetDocumentId, userId: UserDefaults.userId)
        }
      
    }
    
    private func addLike(tweetDocumentId: String, userId: String) async {
        
        do {
            try await db.collection("tweets").document(tweetDocumentId)
                .updateData(
                    ["likes": FieldValue.arrayUnion([userId])]
                )
        } catch {
            print(error.localizedDescription)
        }
    }
    
    private func removeLike(tweetDocumentId: String, userId: String) async {
        
        do {
            try await db.collection("tweets").document(tweetDocumentId)
                .updateData(
                    ["likes": FieldValue.arrayRemove([userId])]
                )
        } catch {
            print(error.localizedDescription)
        }
    }
    
}
