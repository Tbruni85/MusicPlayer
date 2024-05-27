//
//  SongRowView.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 26/05/2024.
//

import SwiftUI

struct SongRowView: View {
    
    let song: Song
    
    var body: some View {
        HStack {
            Image(song.artwork)
                .resizable()
                .frame(width: 50, height: 50)
                .clipShape(RoundedRectangle(cornerRadius: 5))

            VStack(alignment: .leading) {
                Text(song.song)
                    .font(.headline)
                Text(song.artist)
                    .font(.footnote)
            }
            Spacer()
        }
    }
}

#Preview {
    SongRowView(song: Song.example)
}
