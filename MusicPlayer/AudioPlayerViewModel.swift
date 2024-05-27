//
//  PlayerViewModel.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 26/05/2024.
//

import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    
    let songs = Bundle.main.decode([Song].self, from: "Songs.json")
    
    private var audioPlayer: AVAudioPlayer!
    private var timer: Timer?
    var activeSong: Song?
    
    @Published var isPlaying = false
    @Published var currentTime: String = "0:00"
    @Published var currentPercentage: CGFloat = 0
    
    func loadTrack(song: Song) {
        if let sound = Bundle.main.path(forResource: song.song, ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                activeSong = song
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
            guard timer != nil else { return }
            timer?.invalidate()
            timer = nil
        } else {
            audioPlayer.play()
            isPlaying = true
            guard timer == nil else { return }
            timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateTrackTime), userInfo: nil, repeats: true)
        }
    }
    
    func forwardTrack() {
        var timeForward = audioPlayer.currentTime
        timeForward += 5.0
        if timeForward < audioPlayer.duration {
            audioPlayer.currentTime = timeForward
            audioPlayer.play(atTime: timeForward)
            updateTrackTime()
        } else {
            audioPlayer.currentTime = audioPlayer.duration
        }
    }
    
    func backwardTrack() {
        var timeForward = audioPlayer.currentTime
        timeForward -= 5.0
        if timeForward > 0 {
            audioPlayer.currentTime = timeForward
            audioPlayer.play(atTime: timeForward)
            updateTrackTime()
        } else {
            audioPlayer.currentTime = 0
        }
    }
    
    var trackLength: String {
        String(format: "%02d:%02d", ((Int)(audioPlayer.duration)) / 60, ((Int)(audioPlayer.duration)) % 60)
    }
    
    @objc
    func updateTrackTime() {
        currentTime = String(format: "%02d:%02d", ((Int)(audioPlayer.currentTime)) / 60, ((Int)(audioPlayer.currentTime)) % 60)
        currentPercentage = CGFloat(audioPlayer.currentTime / audioPlayer.duration)
    }
}
