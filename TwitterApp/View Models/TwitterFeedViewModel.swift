//
//  TwitterFeedScreenViewModel.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/8/22.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

class TwitterFeedViewModel: BaseViewModel {
    
    var db: Firestore
    @Published var tweets = [Tweet]()
    
    init(db: Firestore = Firestore.firestore()) {
        self.db = db
        super.init()
        
        setupSubscriptionsForUserTweets { [weak self] tweets in
            // setup subscriptions for user likes
            self?.setupSubscriptionsForUserLikes(tweets: tweets) { [weak self] tweets in
                DispatchQueue.main.async {
                    self?.tweets = tweets
                }            }
        }
        
        //setupSubscriptions()
    }
    
    func updateLikes(like: Like) async {
        
        do {
            
            // check if the user has already likes if so then remove userId from the collection
            let docRef = db.collection("likes")
                .document(like.tweetDocumentId)
                .collection("users")
                .document(like.userId)
            
            let doc = try await docRef.getDocument()
            if doc.exists {
                // delete it
                try await doc.reference.delete()
            } else {
                try await db.collection("likes")
                    .document(like.tweetDocumentId)
                    .collection("users")
                    .document(like.userId)
                    .setData([
                        "tweetDocumentId": like.tweetDocumentId,
                        "userId": like.userId
                    ])
            }
            
        } catch {
            print(error)
        }
    }
    
    private func setupSubscriptionsForUserTweets(completion: @escaping ([Tweet]) -> Void) {
        
        db.collection("tweets").whereField("userId", isEqualTo: UserDefaults.userId)
            .addSnapshotListener { documentSnapshot, error in
                
                guard let snapshot = documentSnapshot else {
                    return
                }
                
                guard let documents = snapshot.documents else {
                    return
                }
                
                let tweets = documents.compactMap { doc in
                    var tweet = try? doc.data(as: Tweet.self)
                    tweet?.documentID = doc.documentID
                    return tweet
                }
                
                completion(tweets)
            }
        
    }
    
    private func setupSubscriptionsForUserLikes(tweets: [Tweet], completion: ([Tweet]) -> Void) {
        
        var tweetsWithLikes = [Tweet]()
        
        tweets.forEach { tweet in
            
            var tweetCopy = tweet
            
            guard let documentId = tweetCopy.documentID else { return }
            
            let docRef = self.db.collection("likes").document(documentId).collection("users").document(UserDefaults.userId)
            docRef.getDocument(completion: { snapshot, error in
                guard let _ = snapshot?.data() else { return }
                tweetCopy.isLikedByCurrentUser = true
                // add to the array
                tweetsWithLikes.append(tweetCopy)
            })
            
            completion(tweetsWithLikes.isEmpty ? tweets: tweetsWithLikes)
        }
        
    }
     
    
    private func setupSubscriptions() {
     
        
        db.collection("tweets").whereField("userId", isEqualTo: UserDefaults.userId)
            .addSnapshotListener { [weak self] documentSnapshot, error in
                
                guard let snapshot = documentSnapshot else {
                    return
                }
                
                guard let documents = snapshot.documents else {
                    return
                }
                
                self?.tweets = documents.compactMap { doc in
                    var tweet = try? doc.data(as: Tweet.self)
                    tweet?.documentID = doc.documentID
                    let docRef = self?.db.collection("likes").document(doc.documentID).collection("users").document(UserDefaults.userId)
                    docRef?.getDocument(completion: { snapshot, error in
                        guard let _ = snapshot?.data() else { return }
                        tweet?.isLikedByCurrentUser = true
                    })
                    return tweet
                }
            }
    }
    
}
