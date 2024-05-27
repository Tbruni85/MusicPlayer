//
//  CuratedView.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 26/05/2024.
//

import SwiftUI

struct CuratedView: View {
    
    @EnvironmentObject var audioViewModel: AudioPlayerViewModel
   
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(audioViewModel.songs, id: \.self) { song in
                        SongRowView(song: song)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                audioViewModel.loadTrack(song: song)
                            }
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("Curated for you")
        }
    }
}

#Preview {
    CuratedView()
}
