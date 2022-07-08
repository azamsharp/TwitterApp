//
//  ComposeTweetScreen.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/4/22.
//

import SwiftUI

struct ComposeTweetScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    @State private var tweetText: String = ""
    
    @StateObject private var vm = ComposeTweetViewModel()
    
    var isTweetButtonDisabled: Bool {
        tweetText.isEmpty || tweetText.count >= Constants.StaticValues.maximumTweetCount
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            
            TextEditor(text: $tweetText)
                .overlay(alignment: .topLeading) {
                    Text("What's happening").opacity(tweetText.isEmpty ? 0.4: 0.0)
                        .position(x: 75, y: 20)
                }.padding()
            
            Spacer()
            Divider()
            HStack {
                Image(systemName: "photo")
                Spacer()
                TweetCountGauge(tweetCount: tweetText.count)
            }
            .foregroundColor(.blue)
            .font(.system(size: 28))
            .padding()
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Cancel") {
                            dismiss()
                        }
                    }
                    
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Tweet") {
                               
                            // save the tweet
                            vm.saveTweet(tweet: Tweet(userName: UserDefaults.userId, text: tweetText)) { result in
                                switch result {
                                    case .success(_):
                                        dismiss()
                                    case .failure(let error):
                                        vm.errorMessage = error.localizedDescription
                                }
                            }
                            
                        }.buttonStyle(.borderedProminent)
                            .clipShape(RoundedRectangle(cornerRadius: 16.0, style: .circular))
                            .disabled(isTweetButtonDisabled)
                          
                    }
                }
               
        }.embedNavigationStack()
    }
}

struct ComposeTweetScreen_Previews: PreviewProvider {
    static var previews: some View {
        ComposeTweetScreen().embedNavigationStack()
    }
}
