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
    var isLikedByCurrentUser: Bool = false 
    
    var id: String {
        documentID ?? UUID().uuidString
    }
}
