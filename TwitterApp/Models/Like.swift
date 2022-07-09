//
//  Like.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/9/22.
//

import Foundation

struct Like: Codable {
    let tweetDocumentId: String
    let userId: String
}

extension Like {
    
    func toDictionary() -> [String: Any] {
        return [
            "tweetDocumentId": tweetDocumentId,
            "userId": userId 
        ]
    }
    
}
