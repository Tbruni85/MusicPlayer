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
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThinMaterial, for: .tabBar)
                .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
            FeedsView()
                .tabItem {
                    Image(systemName: "newspaper")
                    Text("Feeds")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThinMaterial, for: .tabBar)
                .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
            FavouritesView()
                .tabItem {
                    Image(systemName: "star")
                    Text("Favourites")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThinMaterial, for: .tabBar)
                .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
            
            LiveRadioView()
                .tabItem {
                    Image(systemName: "dot.radiowaves.left.and.right")
                    Text("Live Radio")
                }
                .toolbarBackground(.visible, for: .tabBar)
                .toolbarBackground(.ultraThinMaterial, for: .tabBar)
                .toolbar(expandSheet ? .hidden : .visible, for: .tabBar)
        }
        .tint(.purple)
        .safeAreaInset(edge: .bottom) {
            BottomSheetPlayer(expandSheet: $expandSheet,
                              animation: animation)
                .offset(y: -Constants.defaultTabBarHeight)
                .opacity(audioViewModel.isMiniPlayerVisible)
        }
        .overlay {
            if expandSheet {
                ExpandedPlayer(expandSheet: $expandSheet, animation: animation)
                    .transition(.asymmetric(insertion: .identity, removal: .offset(y: -5)))
            }
        }
    }
}

#Preview {
    Home()
}
