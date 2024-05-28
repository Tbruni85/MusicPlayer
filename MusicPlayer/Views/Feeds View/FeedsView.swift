//
//  Feeds.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 27/05/2024.
//

import SwiftUI

struct FeedsView: View {
    
    let viewModel = FeedsViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 20) {
                    ForEach(viewModel.feeds, id: \.self) { feed in
                        FeedItem(feed: feed)
                    }
                }
            }
            .navigationTitle("Feeds")
            .padding(.bottom, 70)
        }
    }
}

#Preview {
    FeedsView()
}
