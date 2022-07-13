//
//  HomeTimelineScreen.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/9/22.
//

import SwiftUI

struct HomeTimelineScreen: View {
    
    @State private var isPresented: Bool = false
    @StateObject private var vm = HomeTimelineViewModel()
    @State var selectedTweet: Tweet?
    @State private var retweetText: String = "Retweet"
    
    func retweet() {
        Task {
            guard let tweet = selectedTweet else { return }
            await vm.retweet(tweet: tweet, userId: UserDefaults.userId)
            isPresented = false
        }
    }
    
    var body: some View {
        List(vm.tweets) { tweet in
            
            NavigationLink(value: Route.detail(tweet)) {
                TweetCellView(tweet: tweet, onLiked: {
                    Task {
                        await vm.updateLike(tweet: tweet, userId: UserDefaults.userId)
                    }
                }, onRetweet: {
                    isPresented = true
                    selectedTweet = tweet
                    retweetText = tweet.isRetweeted ? "Undo Retweet": "Retweet"
                })
            }
           
        }.listStyle(.plain)
            .sheet(isPresented: $isPresented) {
                VStack(alignment: .leading, spacing: 50) {
                    HStack {
                        Image(systemName: "arrow.2.squarepath")
                        Text(retweetText)
                        Spacer()
                    }.onTapGesture {
                        // perform retweet action
                        retweet()
                    }
                    
                    Button(role: .cancel) {
                        isPresented = false
                    } label: {
                        Text("Cancel")
                            .frame(maxWidth: .infinity, maxHeight: 44)
                    }.buttonStyle(.bordered)
                    
                }.padding()
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .foregroundColor(.white)
                .background(content: {
                    Color.black
                })
                .presentationDetents([.fraction(0.25)])
               
            }
            
    }
}

struct HomeTimelineScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeTimelineScreen()
            .embedNavigationStack()
    }
}
