//
//  Home.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 25/05/2024.
//

import SwiftUI

struct Home: View {
    
    @State private var expandSheet: Bool = false
    @Namespace private var animation
    
    @EnvironmentObject var audioViewModel: AudioPlayerViewModel
    
    private struct Constants {
        static var defaultTabBarHeight: CGFloat = 49
    }
    
    var body: some View {
        TabView {
            CuratedView()
                .tabItem { 
                    Image(systemName: "shared.with.you")
                    Text("For you")
                }
            FeedsView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Feeds")
                }
            FavouritesView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Favourites")
                }
            sampleTab(title: "Music", image: "magnifyingglass")
        }
        .tint(.purple)
        .safeAreaInset(edge: .bottom) {
            BottomSheetPlayer(expandSheet: $expandSheet,
                              animation: animation)
                .offset(y: -Constants.defaultTabBarHeight)
                .opacity(audioViewModel.activeSong != nil ? 1 : 0)
        }
        .overlay {
            if expandSheet {
                ExpandedPlayer(expandSheet: $expandSheet, animation: animation)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
    }
    
    @ViewBuilder func sampleTab(title: String, image: String) -> some View {
        // iOS bug when animating tabBar items, avoided using a ScrollView as wrapper
        ScrollView(.vertical, showsIndicators: false) {
            Text(title)
                .padding(.top, 25)
        }
        .tabItem {
            Image(systemName: image)
            Text(title)
        }
        .toolbarBackground(.visible, for: .tabBar)
        .toolbarBackground(.ultraThinMaterial, for: .tabBar)
        .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
    }
}

#Preview {
    Home()
}
