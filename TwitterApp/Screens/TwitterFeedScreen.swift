//
//  TwitterFeedScreen.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/8/22.
//

import SwiftUI

struct TwitterFeedScreen: View {
    
    @StateObject private var vm = TwitterFeedViewModel()
    
    private func updateLikeFor(tweetDocumentId: String) async {
        await vm.updateLikes(like: Like(tweetDocumentId: tweetDocumentId, userId: UserDefaults.userId))
    }
    
    var body: some View {
        List(vm.tweets) { tweet in
            HStack(alignment: .top) {
                Image(systemName: "person.circle.fill")
                    .font(.largeTitle)
                VStack(alignment: .leading, spacing: 10) {
                    HStack {
                        Text("Mohammad Azam")
                            .fontWeight(.bold)
                        Text("@azamsharp")
                            .foregroundColor(Color.init(uiColor: UIColor.darkText))
                            .opacity(0.6)
                            .fontWeight(.bold)
                    }
                    
                    Text(tweet.text)
                    
                    HStack(spacing: 30) {
                        
                        HStack {
                            Image(systemName: "message")
                            Text(tweet.noOfComments != nil ? "\(tweet.noOfComments!)": "485")
                        }
                       
                        HStack {
                            Image(systemName: "arrow.2.squarepath")
                            Text(tweet.noOfRetweets != nil ? "\(tweet.noOfRetweets!)": "\(Int.random(in: 1...2600))")
                        }
                      
                        HStack {
                            Image(systemName: tweet.isLikedByCurrentUser ? "heart.fill": "heart")
                                .onTapGesture {
                                    
                                    guard let tweetDocId = tweet.documentID else {
                                        return
                                    }
                                    Task {
                                        await updateLikeFor(tweetDocumentId: tweetDocId)
                                    }
                                }
                            Text(tweet.noOfLikes != nil ? "\(tweet.noOfLikes!)": "\(Int.random(in: 1...2600))")
                        }
                       
                        HStack {
                            Image(systemName: "square.and.arrow.up")
                        }
                        
                    }.padding([.top], 10)
                        
                }
            }
        }.listStyle(.plain)
    }
}

struct TwitterFeedScreen_Previews: PreviewProvider {
    static var previews: some View {
        TwitterFeedScreen()
    }
}
