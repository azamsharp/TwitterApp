//
//  FBError.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/4/22.
//

import Foundation

enum FBError: Error, Identifiable {
    
    case error(String)
    
    var id: UUID {
        UUID()
    }
    
    var errorMessage: String {
        switch self {
            case .error(let errorMessage):
                return errorMessage
        }
    }
}
