//
//  PlayerView.swift
//  MusiPlayer
//
//  Created by Tiziano Bruni on 26/05/2024.
//

import SwiftUI

struct PlayerView: View {
    
    private struct Constants {
        static var spacingScale: CGFloat = 0.04
        
        static func playerButtonFont(size: CGSize) -> Font {
            size.height < 300 ? .title3 : .title
        }
        
        static func playerMainButtonFont(size: CGSize) -> Font {
            size.height < 300 ? .largeTitle : .system(size: 50)
        }
    }
    
    var mainSize: CGSize
    
    var body: some View {
        GeometryReader { proxy in
            let spacing = proxy.size.height * Constants.spacingScale
            
            VStack(spacing: spacing) {
                VStack(spacing: spacing) {
                    HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: 15) {
                        VStack(alignment: .leading, spacing: 4) {
                            Text("Don't give up on me now")
                                .font(.title3)
                                .fontWeight(.semibold)
                            Text("Ben Harper")
                                .foregroundColor(.gray)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        
                        Button {
                            
                        } label: {
                            Image(systemName: "ellipsis")
                                .foregroundColor(.white)
                                .padding(12)
                                .background {
                                    Circle()
                                        .fill(.ultraThinMaterial)
                                        .environment(\.colorScheme, .light)
                                }
                        }
                    }
                    
                    Capsule()
                        .fill(.ultraThinMaterial)
                        .environment(\.colorScheme, .light)
                        .frame(height: 5)
                        .padding(.top, spacing)
                    
                    HStack {
                        Text("0:00")
                            .font(.caption)
                            .foregroundColor(.gray)
                        Spacer()
                        Text("3:33")
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                }
                HStack(spacing: proxy.size.width * 0.18) {
                    Button {
                        
                    } label: {
                        Image(systemName: "backward.fill")
                            .font(Constants.playerButtonFont(size: proxy.size))
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "pause.fill")
                            .font(Constants.playerMainButtonFont(size: proxy.size))
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "forward.fill")
                            .font(Constants.playerButtonFont(size: proxy.size))
                    }
                }
                .foregroundColor(.white)
            }
        }
    }
}

#Preview {
    PlayerView(mainSize: CGSize(width: 200, height: 450))
}
