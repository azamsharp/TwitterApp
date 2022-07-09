//
//  HomeTimelineScreen.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/9/22.
//

import SwiftUI

struct HomeTimelineScreen: View {
    
    @StateObject private var vm = HomeTimelineViewModel()
    
    var body: some View {
        List(vm.tweets) { tweet in
            TweetCellView(tweet: tweet, onLiked: {
                Task {
                    await vm.toggleLike(tweet: tweet, userId: UserDefaults.userId)
                }
            })
        }
    }
}

struct HomeTimelineScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeTimelineScreen()
    }
}
