//
//  BottomSheetPlayer.swift
//  MusiPlayer
//
//  Created by Tiziano Bruni on 25/05/2024.
//

import SwiftUI

struct BottomSheetPlayer: View {
    
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(.ultraThickMaterial)
                .frame(height: 70)
                .overlay(alignment: .bottom, content: {
                    Rectangle()
                        .fill(.gray.opacity(0.3))
                        .frame(height: 1)
                        .offset(y: -5)
                })
                .overlay {
                    MusicInfo(expandSheet: $expandSheet, animation: animation)
                }
        }
    }
}

#Preview {
    ContentView()
}
