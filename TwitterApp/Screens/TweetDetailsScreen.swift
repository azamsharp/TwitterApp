//
//  TweetDetailsScreen.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/13/22.
//

import SwiftUI

struct TweetDetailsScreen: View {
    
    let tweet: Tweet
    
    var body: some View {
        List {
            
            TweetCellView(tweet: tweet) {
                Task {
                    //await vm.updateLike(tweet: tweet, userId: UserDefaults.userId)
                }
            } onRetweet: {
                
            }
            
            ForEach(1...20, id: \.self) { index in
                Text("\(index)")
            }

            
        }
    }
}

struct TweetDetailsScreen_Previews: PreviewProvider {
    static var previews: some View {
        TweetDetailsScreen(tweet: Tweet(userId: "azamsharp", text: "Hello World"))
    }
}
