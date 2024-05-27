//
//  FeedsViewModel.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 27/05/2024.
//

import Foundation

class FeedsViewModel: ObservableObject {
    
    let feeds = Bundle.main.decode([Feed].self, from: "Feeds.json")
}
