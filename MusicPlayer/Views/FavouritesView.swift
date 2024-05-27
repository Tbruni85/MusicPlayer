//
//  FavouritesView.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 27/05/2024.
//

import SwiftUI

struct FavouritesView: View {
    
    @EnvironmentObject var audioViewModel: AudioPlayerViewModel
    
    var body: some View {
        NavigationStack {
            if audioViewModel.favSongs.count > 0 {
                VStack {
                    List {
                        ForEach(audioViewModel.favSongs, id: \.self) { song in
                            SongRowView(song: song)
                                .contentShape(Rectangle())
                                .onTapGesture {
                                    audioViewModel.loadTrack(song: song)
                                }
                        }
                    }
                }
                .listStyle(.inset)
                .navigationTitle("Favourites")
            } else {
                ContentUnavailableView(label: {
                    VStack {
                        Text("Message")
                    }
                }, description: {
                    Text("Add songs to you favourites to see them here")
                })
                .navigationTitle("Favourites")
            }
            
        }
    }
}

#Preview {
    FavouritesView()
}
