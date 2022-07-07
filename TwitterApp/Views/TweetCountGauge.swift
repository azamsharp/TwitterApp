//
//  TweetCountGauge.swift
//  TwitterApp
//
//  Created by Mohammad Azam on 7/7/22.
//

import SwiftUI

struct TweetCountGauge: View {
    
    let tweetCount: Int
    
    var gaugeColor: Color {
        switch tweetCount {
            case 0...119:
                return .purple
            case 120...139:
                return .orange
            case 140...:
                return .red
            default:
                return .gray
        }
    }
    
    var percentage: Double {
        return Double(tweetCount) / Double(Constants.StaticValues.maximumTweetCount)
    }
    
    var remainingCharactersCountText: String {
        switch tweetCount {
            case 120...:
                return "\(Constants.StaticValues.maximumTweetCount - tweetCount)"
            default:
                return ""
        }
    }
    
    var body: some View {
        ZStack {
            Circle()
                .stroke(lineWidth: 4)
                .foregroundColor(.gray)
                .opacity(0.4)
                .frame(maxWidth: 30, maxHeight: 30)
            
            Circle()
                .trim(from: 0, to: percentage)
                .stroke(lineWidth: 4)
                .foregroundColor(gaugeColor)
                .frame(maxWidth: 30, maxHeight: 30)
                .rotation3DEffect(Angle(degrees: 270), axis: (x: 0, y: 0, z: 1))
                .overlay(alignment: .center) {
                    Text(remainingCharactersCountText)
                        .font(.caption)
                        .fontWeight(.medium)
                }
            
        }
    }
}

struct TweetCountGauge_Previews: PreviewProvider {
    static var previews: some View {
        TweetCountGauge(tweetCount: 152)
    }
}
