//
//  HomeTimelineViewModel.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/9/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class HomeTimelineViewModel: BaseViewModel {
    
    @Published var tweets = [Tweet]()
    var db: Firestore = Firestore.firestore()
    
    override init() {
        super.init()
        setupSubscriptions()
    }
    
    func toggleLike(tweet: Tweet, userId: String) async {
        
        guard let tweetDocumentId = tweet.documentID else {
            return
        }
        
        if tweet.likes.contains(UserDefaults.userId) {
           // remove the like
            await removeLike(tweetDocumentId: tweetDocumentId, userId: UserDefaults.userId)
        } else {
            // add the like
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
            errorMessage = error.localizedDescription
        }
    }
    
    private func removeLike(tweetDocumentId: String, userId: String) async {
        
        do {
            try await db.collection("tweets").document(tweetDocumentId)
                .updateData(
                    ["likes": FieldValue.arrayRemove([userId])]
                )
        } catch {
            errorMessage = error.localizedDescription
        }
    }
    
    private func setupSubscriptions() {
        
        // listen for changes for the user
        db.collection("tweets")
            .addSnapshotListener { [weak self] documentSnapshot, error in
                
                guard let snapshot = documentSnapshot else {
                    return
                }
                
                guard let documents = snapshot.documents else {
                    return
                }
                
                DispatchQueue.main.async {
                    self?.tweets = documents.compactMap { doc in
                        var tweet = try? doc.data(as: Tweet.self)
                        tweet?.documentID = doc.documentID
                        return tweet
                    }
                }
            }
    }
}
