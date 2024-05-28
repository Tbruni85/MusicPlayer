//
//  MusicInfo.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 25/05/2024.
//

import SwiftUI

struct MusicInfo: View {
    
    @EnvironmentObject var audioViewModel: AudioPlayerViewModel
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    
    private struct Constants {
        static let frameHeight: CGFloat = 70
        static let bottomPadding: CGFloat = 5
        static let buttonLeadingPadding: CGFloat = 25
        
        static let titleHorizontalPadding: CGFloat = 15
        
        static let artworkFrame: CGSize = CGSize(width: 45, height: 45)
        
        static let animationDuration = 0.3
        
        static func imageArtworkCornerRaius(_ expandSheet: Bool) -> CGFloat {
            expandSheet ? 15 : 5
        }
    }
    
    var body: some View {
        GeometryReader { proxy in
            VStack {
                
                HStack {
                    ZStack {
                        if !expandSheet {
                            GeometryReader {
                                let size = $0.size
                                
                                Image(audioViewModel.playerImage)
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: size.width, height: size.height)
                                    .clipShape(RoundedRectangle(cornerRadius: Constants.imageArtworkCornerRaius(expandSheet),
                                                                style: .continuous))
                            }
                            .matchedGeometryEffect(id: "ARTWORK", in: animation)
                        }
                    }
                    .frame(width: Constants.artworkFrame.width, height: Constants.artworkFrame.height)
                    VStack(alignment: .leading) {
                        Text(audioViewModel.currentSong)
                            .fontWeight(.semibold)
                            .lineLimit(1)
                            .padding(.horizontal, Constants.titleHorizontalPadding)
                        
                        Text(audioViewModel.currentArtist)
                            .font(.system(size: 13))
                            .fontWeight(.light)
                            .lineLimit(1)
                            .padding(.horizontal, Constants.titleHorizontalPadding)
                    }
                    
                    Spacer()
                    
                    CustomPlayerButton(dropSize: 45, iconWeight: 30)
                        .tint(.primary)
                }
                .foregroundColor(.primary)
                .padding(.horizontal)
                .padding(.bottom, Constants.bottomPadding)
                .frame(height: Constants.frameHeight)
                .contentShape(Rectangle())
                .onTapGesture {
                    withAnimation(.easeInOut(duration: Constants.animationDuration)) {
                        expandSheet = true
                    }
                }
                
                ZStack(alignment: .leading) {
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .light)
                        .frame(height: 2)
                    Capsule()
                        .fill(.purple)
                        .environment(\.colorScheme, .light)
                        .frame(width: audioViewModel.playerType == .stream ? nil : proxy.size.width * audioViewModel.currentPercentage, height: 2)
                        .animation(.easeInOut, value: audioViewModel.currentPercentage)
                }
                .offset(y: -10)
            }
        }
        
        
    }
}

#Preview {
    ContentView()
}
