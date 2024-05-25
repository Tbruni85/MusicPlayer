//
//  Home.swift
//  MusiPlayer
//
//  Created by Tiziano Bruni on 25/05/2024.
//

import SwiftUI

struct Home: View {
    
    @State private var expandSheet: Bool = false
    @Namespace private var animation
    
    private struct Constants {
        static var defaultTabBarHeight: CGFloat = 49
    }
    
    var body: some View {
        TabView {
            sampleTab(title: "Listen now", image: "play.circle.fill")
            sampleTab(title: "Browse", image: "square.grid.2x2.fill")
            sampleTab(title: "Radio", image: "dot.radiowaves.left.and.right")
            sampleTab(title: "Music", image: "magnifyingglass")
        }
        .tint(.purple)
        .safeAreaInset(edge: .bottom) {
            BottomSheetPlayer(expandSheet: $expandSheet, animation: animation)
                .offset(y: -Constants.defaultTabBarHeight)
        }
    }
    
    @ViewBuilder func sampleTab(title: String, image: String) -> some View {
        Text(title)
            .tabItem {
                Image(systemName: image)
                Text(title)
            }
            .toolbarBackground(.visible, for: .tabBar)
            .toolbarBackground(.ultraThinMaterial, for: .tabBar)
    }
}

#Preview {
    Home()
}
