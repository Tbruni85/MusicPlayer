//
//  MusiPlayerApp.swift
//  MusiPlayer
//
//  Created by Tiziano Bruni on 24/05/2024.
//

import SwiftUI

@main
struct MusiPlayerApp: App {
    
    @StateObject var audioViewModel = AudioPlayerViewModel()
    
    var body: some Scene {
        WindowGroup {
            Home()
                .environmentObject(audioViewModel)
        }
    }
}
