//
//  Tweet.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/8/22.
//

import Foundation

struct Tweet: Codable, Identifiable {
    var documentID: String?
    let userId: String
    let text: String
    var noOfComments: Int?
    var noOfRetweets: Int?
    var likes: [String]?
    var retweets: [String]?
    var userInfo: UserInfo?
    var dateCreated: Date = Date()
    
    var isRetweeted: Bool {
        retweets?.contains(UserDefaults.userId) ?? false
    }
    
    var retweetCount: Int {
        retweets?.count ?? 0
    }
    
    var isLiked: Bool {
        likes?.contains(UserDefaults.userId) ?? false
    }
    
    var likeCount: Int {
        likes?.count ?? 0 
    }
    
    var id: String {
        documentID ?? UUID().uuidString
    }
    
}
