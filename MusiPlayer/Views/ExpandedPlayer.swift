//
//  ExpandedPlayer.swift
//  MusiPlayer
//
//  Created by Tiziano Bruni on 25/05/2024.
//

import SwiftUI

struct ExpandedPlayer: View {
    
    private struct Constants {
        static var grabIndicatorSize: CGSize = CGSize(width: 40, height: 5)
        static var horizontalPadding: CGFloat = 25
        static var artoworkCornerRadius: CGFloat = 15
        
        
        static func artworkWidth() -> CGFloat {
            horizontalPadding * 2
        }
    }
    
    
    @Binding var expandSheet: Bool
    var animation: Namespace.ID
    
    @State private var animateContent = false
    
    var body: some View {
        GeometryReader {
            let size = $0.size
            let safeAreaInsets = $0.safeAreaInsets
            
            ZStack {
                Rectangle()
                    .fill(.ultraThickMaterial)
                    .overlay(content: {
                        Rectangle()
                            .fill(Color("BG"))
                            .opacity(animateContent ? 1 : 0)
                    })
                    .overlay(alignment: .top) {
                        MusicInfo(expandSheet: $expandSheet, animation: animation)
                            .allowsHitTesting(false)
                            .opacity(animateContent ? 0 : 1)
                    }
                    .matchedGeometryEffect(id: "BGVIEW", in: animation)
                
                VStack {
                    Capsule()
                        .fill(.gray)
                        .frame(width: Constants.grabIndicatorSize.width, height: Constants.grabIndicatorSize.height)
                        .opacity(animateContent ? 1 : 0)
                    
                    GeometryReader {
                        let size = $0.size
                        
                        Image("Artwork")
                            .resizable()
                            .aspectRatio(contentMode: .fill)
                            .frame(width: size.width, height: size.height)
                            .clipShape(RoundedRectangle(cornerRadius: Constants.artoworkCornerRadius, style: /*@START_MENU_TOKEN@*/.continuous/*@END_MENU_TOKEN@*/))
                    }
                    .matchedGeometryEffect(id: "ARTWORK", in: animation)
                    //the height is derived by the width - the horizontal padding (x2)
                    .frame(height: size.width - Constants.artworkWidth())
                }
                .padding(.top, safeAreaInsets.top + (safeAreaInsets.bottom == 0 ? 10 : 0))
                .padding(.bottom, safeAreaInsets.bottom == 0 ? 10 : safeAreaInsets.bottom)
                .padding(.horizontal, Constants.horizontalPadding)
                .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
                // Animation test
                .onTapGesture {
                    withAnimation(.easeInOut(duration: 0.3)) {
                        expandSheet = false
                        animateContent = false
                    }
                }
            }
            
            .ignoresSafeArea(.container, edges: .all)
        }
        .onAppear {
            withAnimation(.easeInOut(duration: 0.35)) {
                animateContent = true
            }
        }
    }
}

#Preview {
    ContentView()
}
