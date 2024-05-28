//
//  LiveRadioView.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 28/05/2024.
//

import SwiftUI

struct LiveRadioView: View {
    
    @EnvironmentObject var audioViewModel: AudioPlayerViewModel
    
    var body: some View {
        NavigationStack {
            VStack {
                List {
                    ForEach(audioViewModel.radios, id: \.self) { radio in
                        RadioRowView(radio: radio)
                            .contentShape(Rectangle())
                            .onTapGesture {
                                audioViewModel.streamURL(radio: radio)
                            }
                    }
                }
            }
            .listStyle(.inset)
            .navigationTitle("Live Radio")
        }
    }
}

#Preview {
    LiveRadioView()
}
