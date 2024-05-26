//
//  MusicInfo.swift
//  MusiPlayer
//
//  Created by Tiziano Bruni on 25/05/2024.
//

import SwiftUI

struct MusicInfo: View {
    
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
        HStack(spacing: 0) {
            ZStack {
                if !expandSheet {
                    GeometryReader {
                        let size = $0.size
                        
                        Image("Artwork")
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
            
           
            
            Text("Don't give up on me now")
                .fontWeight(.semibold)
                .lineLimit(1)
                .padding(.horizontal, Constants.titleHorizontalPadding)
            
            Spacer(minLength: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/)
            
            Button {
                
            } label: {
                Image(systemName: "pause.fill")
                    .font(.title2)
            }
            
            Button {
                
            } label: {
                Image(systemName: "forward.fill")
                    .font(.title2)
            }
            .padding(.leading, Constants.buttonLeadingPadding)

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
    }
}

#Preview {
    ContentView()
    //MusicInfo(expandSheet: .constant(false), animation: Namespace.ID() )
}
