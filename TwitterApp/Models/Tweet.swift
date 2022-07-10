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
    var noOfLikes: Int?
    var noOfComments: Int?
    var noOfRetweets: Int?
    var likes: [String] = [String]()
    var userInfo: UserInfo?
    
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
