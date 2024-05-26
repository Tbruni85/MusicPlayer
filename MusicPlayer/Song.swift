//
//  Song.swift
//  MusiPlayer
//
//  Created by Tiziano Bruni on 26/05/2024.
//

import Foundation

struct Song: Decodable, Hashable {
    
    let artwork: String
    let song: String
    let artist: String
    
#if DEBUG
    static let example = Song(artwork: "pala", song: "This is for you", artist: "DJ Mix")
#endif
}

