//
//  UserDefault.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/4/22.
//

import Foundation

@propertyWrapper
struct UserDefault<Value> {
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get {
            return container.value(forKey: key) as? Value ?? defaultValue
        } set {
            container.set(newValue, forKey: key)
        }
    }
}
