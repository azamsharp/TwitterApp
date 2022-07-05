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
    
    var body: some View {
        VStack {
            TextEditor(text: $tweetText)
                .padding()
            Divider()
            HStack {
                Image(systemName: "photo")
                Spacer()
                Image(systemName: "circle")
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
                            // send the tweet
                        }.buttonStyle(.borderedProminent)
                            .clipShape(RoundedRectangle(cornerRadius: 20.0, style: .continuous))
                            .disabled(tweetText.isEmpty)
                    }
                }
                .onAppear {
                    UITextView.appearance().backgroundColor = .systemGray5
                }
        }.embedNavigationStack()
    }
}

struct ComposeTweetScreen_Previews: PreviewProvider {
    static var previews: some View {
        ComposeTweetScreen().embedNavigationStack()
    }
}
