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
        setupSubscriptions { [weak self] tweets in
            
            var results = [Tweet]()
            
            tweets.forEach { tweet in
                var tweetCopy = tweet
                self?.db.collection("users").document(tweetCopy.userId).getDocument(as: UserInfo.self) { result in
                    switch result {
                        case .success(let userInfo):
                            tweetCopy.userInfo = userInfo
                            results.append(tweetCopy)
                            
                            if results.count == tweets.count {
                                DispatchQueue.main.async {
                                    self?.tweets = results
                                }
                            }
                            
                        case .failure(let error):
                            print(error.localizedDescription)
                    }
                }
                
              
                
            }
        }
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
    
    private func setupSubscriptions(completion: @escaping ([Tweet]) -> Void) {
        
        // listen for changes for the user
        db.collection("tweets")
            .addSnapshotListener { documentSnapshot, error in
                print("SNAPSHOT")
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
                
                DispatchQueue.main.async {
                   completion(tweets)
                }
            }
    }
}
