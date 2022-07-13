//
//  Tweet.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/8/22.
//

import Foundation

struct Tweet: Codable, Identifiable, Equatable, Hashable {
    
    static func == (lhs: Tweet, rhs: Tweet) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    var documentID: String?
    let userId: String
    let text: String
    var noOfComments: Int?
    var noOfRetweets: Int?
    var likes: [String] = [String]()
    var retweets: [String] = [String]()
    var userInfo: UserInfo?
    var dateUpdated: Date = Date()
    var dateCreated: Date = Date()
    
    func toDictionary() -> [String: Any] {
        
        var tweetDict = ["userId": userId, "text": text, "dateCreated": dateCreated, "dateUpdated": dateUpdated, "likes": likes, "retweets": retweets] as [String : Any]
        
        if let documentID {
            tweetDict["documentID"] = documentID
        }
         
        return tweetDict
    }
 
    
    var isRetweeted: Bool {
        retweets.contains(UserDefaults.userId)
    }
    
    var retweetCount: Int {
        retweets.count
    }
    
    var isLiked: Bool {
        likes.contains(UserDefaults.userId)
    }
    
    var likeCount: Int {
        likes.count 
    }
    
    var id: String {
        documentID ?? UUID().uuidString
    }
    
}
