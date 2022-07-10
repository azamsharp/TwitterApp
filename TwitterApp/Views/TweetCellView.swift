//
//  TweetCellView.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/9/22.
//

import SwiftUI

struct TweetCellView: View {
    
    let tweet: Tweet
    let onLiked: () -> Void
    
    var body: some View {
        HStack(alignment: .top) {
            Image(systemName: "person.circle.fill")
                .font(.largeTitle)
            VStack(alignment: .leading, spacing: 10) {
                HStack {
                    if let userInfo = tweet.userInfo {
                        Text(userInfo.name)
                            .fontWeight(.bold)
                        Text("@azamsharp")
                            .foregroundColor(Color.init(uiColor: UIColor.darkText))
                            .opacity(0.6)
                            .fontWeight(.bold)
                    }
                }
                
                Text(tweet.text)
                
                HStack(spacing: 20) {
                    
                    HStack {
                        Image(systemName: "message")
                        Text(tweet.noOfComments != nil ? "\(tweet.noOfComments!)": "485")
                    }.frame(maxWidth: .infinity)
                   
                    HStack {
                        Image(systemName: "arrow.2.squarepath")
                        Text(tweet.noOfRetweets != nil ? "\(tweet.noOfRetweets!)": "\(Int.random(in: 1...500))")
                    }.frame(maxWidth: .infinity)
                  
                    HStack {
                        Image(systemName: tweet.isLiked ? "heart.fill": "heart")
                            .foregroundColor(tweet.isLiked ? .red: .black)
                            .onTapGesture {
                               onLiked()
                            }
                        Text(tweet.likeCount > 0 ? "\(tweet.likeCount)": "")
                    }.frame(maxWidth: .infinity)
                   
                    HStack {
                        Image(systemName: "square.and.arrow.up")
                    }.frame(maxWidth: .infinity)
                    
                }.padding([.top], 10)
            }
        }
    }
}

struct TweetCellView_Previews: PreviewProvider {
    static var previews: some View {
        let tweet = Tweet(userId: UserDefaults.userId, text: "Hello World!")
        TweetCellView(tweet: tweet, onLiked: { })
    }
}
