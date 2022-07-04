//
//  UserDefaults+Extensions.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/4/22.
//

import Foundation

extension UserDefaults {
    
    @UserDefault(key: "is_signed_in", defaultValue: false)
    static var isSignedIn: Bool
    
    @UserDefault(key: "user_id", defaultValue: "")
    static var userId: String
    
}
