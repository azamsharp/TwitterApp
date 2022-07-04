//
//  String+Extensions.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/4/22.
//

import Foundation

extension String: Identifiable {
    
    public var id: Int {
        return hash
    }
    
}
