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
    
    private let likeService = LikeService()
    private let retweetService = RetweetService()
    
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
                                    t1.dateUpdated > t2.dateUpdated
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
    
    func retweet(tweet: Tweet, userId: String) async {
        
        // check if the tweet has been retweeted before
        if tweet.isRetweeted {
            Task {
                await self.updateRetweet(tweet: tweet, userId: userId)
            }
        } else {
            retweetService.retweet(tweet: tweet, userId: userId) { result in
                switch result {
                    case .success(let success):
                        if success {
                            Task {
                                await self.updateRetweet(tweet: tweet, userId: userId)
                            }
                        }
                       
                    case .failure(let error):
                        print(error)
                }
            }
        }
        
        
       
    }
    
    private func updateRetweet(tweet: Tweet, userId: String) async {
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
