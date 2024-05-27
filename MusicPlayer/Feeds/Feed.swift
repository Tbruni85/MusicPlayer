//
//  Feed.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 27/05/2024.
//

import Foundation

struct Feed: Decodable, Hashable {
    
    let image: String
    let name: String
    let details: String
    
#if DEBUG
    static let example = Feed(image: "goku_feed", name: "Goku", details: "22.2k uses • 1.7k likes • Oda")
#endif
}

