//
//  NewsItem.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 27/05/2024.
//

import SwiftUI

struct FeedItem: View {
    let feed: Feed
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(feed.image)
                .resizable()
                .aspectRatio(contentMode: .fit)
            Rectangle()
                .fill(.white)
                .frame(height: 50)
                .overlay(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text(feed.name)
                            .fontWeight(.bold)
                            .lineLimit(1)
                            .padding(.horizontal, 15)
                            .foregroundColor(.black)
                        
                        Text(feed.details)
                            .font(.system(size: 13))
                            .fontWeight(.light)
                            .lineLimit(1)
                            .padding(.horizontal, 15)
                            .foregroundColor(.black)
                    }
                }
        }
        .cornerRadius(8)
    }
}

#Preview {
    FeedItem(feed: Feed.example)
}
