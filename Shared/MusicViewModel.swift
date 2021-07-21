//
//  MusicViewModel.swift
//  Music-Player-App (iOS)
//
//  Created by Zari McFadden on 7/20/21.
//

import Foundation
import MediaPlayer

final class MusicViewModel: ObservableObject {
    @Published var searchResults = [SongData]()
    @Published var isPlaying = false
    @Published var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    @Published var song: SongData?
    @Published var progress: Float = 0.0
    @Published var state: SearchState?
    
    init() {
        state = .loading
    }
    
    func search(search: String) {
        DispatchQueue.global(qos: .background).async {
            self.state = .loading
            AppleMusicAPI().searchAppleMusic(search) { data, state in
                self.searchResults = data
                self.state = state
            }
        }
    }
    
    func setSong(song: SongData) {
        self.song = song
    }
    
    func startProgress() -> Float {
        self.progress += musicPlayer.currentPlaybackRate
        return self.progress
    }
}
