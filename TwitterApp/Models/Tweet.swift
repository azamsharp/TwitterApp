//
//  Tweet.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/8/22.
//

import Foundation

struct Tweet: Codable, Identifiable {
    var documentId: String?
    let userId: String
    let text: String
    var noOfLikes: Int?
    var noOfComments: Int?
    var noOfRetweets: Int? 
    
    var id: String {
        documentId ?? UUID().uuidString
    }
}
