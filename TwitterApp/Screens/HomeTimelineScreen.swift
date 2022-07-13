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
    
    var body: some View {
        List(vm.tweets) { tweet in
            TweetCellView(tweet: tweet, onLiked: {
                Task {
                    await vm.updateLike(tweet: tweet, userId: UserDefaults.userId)
                }
            }, onRetweet: {
                isPresented = true
                // show action sheet to RT
                /*
                Task {
                    await vm.updateRetweet(tweet: tweet, userId: UserDefaults.userId)
                }
                 */
            })
        }.listStyle(.plain)
            .sheet(isPresented: $isPresented) {
                ZStack {
                    Color(red: 0.95, green: 0.9, blue: 1)
                    Text("This is my sheet. It could be a whole view, or just a text.")
                }.presentationDetents([.fraction(0.25)])
            }
            
    }
}

struct HomeTimelineScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeTimelineScreen()
    }
}
