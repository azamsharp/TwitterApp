//
//  TextView.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/4/22.
//

import Foundation
import SwiftUI

struct TextView: UIViewRepresentable {
    
    typealias UIViewType = UITextView
    
    func makeUIView(context: Context) -> UIViewType {
        let textView = UITextView() 
        
        return textView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
    }
    
}
