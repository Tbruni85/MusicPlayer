//
//  PlayerViewModel.swift
//  MusiPlayer
//
//  Created by Tiziano Bruni on 26/05/2024.
//

import AVFoundation

class AudioPlayerViewModel: ObservableObject {

    let songs = Bundle.main.decode([Song].self, from: "Songs.json")

    private var audioPlayer: AVAudioPlayer!

    @Published var isPlaying = false
        
    func loadTrack(song: Song) {
        if let sound = Bundle.main.path(forResource: song.song, ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                playOrPause()
            } catch {
                print("AVAudioPlayer could not be instantiated.")
            }
        } else {
            print("Audio file could not be found.")
        }
    }
    
    func playOrPause() {
       
        if audioPlayer.isPlaying {
            audioPlayer.pause()
            isPlaying = false
        } else {
            audioPlayer.play()
            isPlaying = true
        }
    }
}
