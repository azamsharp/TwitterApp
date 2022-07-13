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
    
    let likeService = LikeService()
    let retweetService = RetweetService()
    
    override init() {
      
        super.init()
        setupSubscriptions(completion: populateUserInfoIntoTweets)
    }
    
    private func populateUserInfoIntoTweets(tweets: [Tweet]) {
        
        var results = [Tweet]()
        
        tweets.forEach { tweet in
            var tweetCopy = tweet
            self.db.collection("users").document(tweetCopy.userId).getDocument(as: UserInfo.self) { result in
                switch result {
                    case .success(let userInfo):
                        tweetCopy.userInfo = userInfo
                        results.append(tweetCopy)
                        
                        if results.count == tweets.count {
                            DispatchQueue.main.async {
                                self.tweets = results.sorted(by: { t1, t2 in
                                    t1.dateCreated > t2.dateCreated
                                })
                            }
                        }
                        
                    case .failure(let error):
                        print(error.localizedDescription)
                }
            }
        }
    }
    
    func updateLike(tweet: Tweet, userId: String) async {
        await likeService.toggleLike(tweet: tweet, userId: userId)
    }
    
    func updateRetweet(tweet: Tweet, userId: String) async {
        await retweetService.toggleRetweet(tweet: tweet, userId: userId)
    }
    
    private func setupSubscriptions(completion: @escaping ([Tweet]) -> Void) {
        
        // listen for changes for the user
        db.collection("tweets")
            .addSnapshotListener { documentSnapshot, error in
        
                guard let snapshot = documentSnapshot else {
                    return
                }
                
                let tweets = snapshot.documents.compactMap { doc in
                   
                    var tweet = try? doc.data(as: Tweet.self)
                    tweet?.documentID = doc.documentID
                    return tweet
                }
                
                DispatchQueue.main.async {
                    print(tweets)
                    completion(tweets)
                }
            }
    }
}
