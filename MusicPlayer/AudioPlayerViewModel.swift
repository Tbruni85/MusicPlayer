//
//  PlayerViewModel.swift
//  MusicPlayer
//
//  Created by Tiziano Bruni on 26/05/2024.
//

import AVFoundation

class AudioPlayerViewModel: ObservableObject {
    
    enum PlayerType {
        case local
        case stream
        case none
    }
    
    let songs = Bundle.main.decode([Song].self, from: "Songs.json")
    let radios = Bundle.main.decode([Radio].self, from: "Radios.json")
    
    private var audioPlayer: AVAudioPlayer!
    private var player: AVPlayer!
    private var playerObserver: Any!
    private var timer: Timer?
    
    var activeSong: Song?
    var activeStream: Radio?
    
    @Published var isPlaying = false
    @Published var currentTime: String = "0:00"
    @Published var currentPercentage: CGFloat = 0
    @Published var favSongs: [Song] = []
    @Published var playerType: PlayerType = .none
    
    func loadTrack(song: Song) {
        if let sound = Bundle.main.path(forResource: song.song, ofType: "mp3") {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: sound))
                playerType = .local
                activeSong = song
                audioPlayerPlayPause()
            } catch {
                print("AVAudioPlayer could not be instantiated.")
            }
        } else {
            print("Audio file could not be found.")
        }
    }
    
    func streamURL(radio: Radio) {
        guard let url = URL(string: radio.stream) else {
            print("Malformed URL")
            return
        }
        
        let asset = AVAsset(url: url)
        let item = AVPlayerItem(asset: asset)
        player = AVPlayer(playerItem: item)
        playerType = .stream
        streamPlayPause()
        activeStream = radio
        
        if audioPlayer != nil {
            if audioPlayer.isPlaying {
                audioPlayerPlayPause()
            }
        }
    }
    
    func streamPlayPause() {
        guard let player = player else {
            return
        }
        
        if !isPlaying {
            player.play()
            playerObserver = player.addPeriodicTimeObserver(forInterval: CMTimeMake(value: 1, timescale: 600), queue: DispatchQueue.main, using: { [weak self] time in
                if self?.player.currentItem?.status == .readyToPlay {
                    self?.isPlaying = true
                }
            })
        } else {
            player.pause()
            isPlaying = false
            if let token = playerObserver {
                player.removeTimeObserver(token)
                playerObserver = nil
            }
        }
    }
    
    func audioPlayerPlayPause() {
        streamPlayPause()
        
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
    
    func playOrPause() {
        if playerType == .stream {
            streamPlayPause()
        } else if playerType == .local {
            audioPlayerPlayPause()
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
        guard let audioPlayer = audioPlayer else {
            return  "--:--"
        }
        
        return String(format: "%02d:%02d", ((Int)(audioPlayer.duration)) / 60, ((Int)(audioPlayer.duration)) % 60)
    }
    
    @objc
    func updateTrackTime() {
        
        guard let audioPlayer = audioPlayer else {
            return
        }
        if audioPlayer.isPlaying {
            currentTime = String(format: "%02d:%02d", ((Int)(audioPlayer.currentTime)) / 60, ((Int)(audioPlayer.currentTime)) % 60)
            currentPercentage = CGFloat(audioPlayer.currentTime / audioPlayer.duration)
        }
    }
    
    var isMiniPlayerVisible: Double {
        isPlaying ? 1 : 0
    }
    
    var playerImage: String {
        switch playerType {
        case .local:
            activeSong?.artwork ?? "artwork_placeholder"
        case .stream:
            activeStream?.image ?? "artwork_placeholder"
        case .none:
            "artwork_placeholder"
        }
    }
    
    var currentArtist: String {
        
        switch playerType {
        case .local:
            activeSong?.artist ?? "Unknown"
        case .stream:
            activeStream?.name ?? "Unknown"
        case .none:
            "Unknown"
        }
    }
    
    var currentSong: String {
        
        switch playerType {
        case .local:
            activeSong?.song ?? "Unknown"
        case .stream:
            "Live radio"
        case .none:
            "Unknown"
        }
    }
}

// MARK: Favourites handling
extension AudioPlayerViewModel {
    
    func addToFav() {
        guard let song = activeSong else {
            return
        }
        
        if isFavourite() {
            return
        }
        
        favSongs.append(song)
    }
    
    func isFavourite() -> Bool {
        guard let song = activeSong else {
            return false
        }
        
        return favSongs.contains {
            $0 == song
        }
    }
    
    func removeFromFavourite() {
        guard let song = activeSong, let index = favSongs.firstIndex(of:song) else {
            return
        }
        
        favSongs.remove(at: index)
    }
}
