//
//  ContentView.swift
//  Shared
//
//  Created by Zari McFadden on 7/14/21.
//

import SwiftUI
import StoreKit
import MediaPlayer

struct ContentView: View {
    @ObservedObject var model: MusicViewModel = MusicViewModel()
    @State private var musicPlayer = MPMusicPlayerController.applicationMusicPlayer
    var body: some View {
        TabView {
            BrowseView().tabItem {
                Image("HOME")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                Text("Home")
            }
            
            ListenView(model: model).tabItem {
                Image("HEADPHONES")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                Text("Listen")
            }
            
            SearchView(model: model).tabItem {
                Image("MAGNIFYING GLASS")
                    .renderingMode(.template)
                    .foregroundColor(.white)
                Text("Search")
            }
            
        }
        .accentColor(.white)
    }
}

func requestAccess(_ completion: @escaping(Bool) -> Void) {
    SKCloudServiceController.requestAuthorization { (status) in
        switch status {
        case .authorized:
            completion(true)
        case .denied, .notDetermined, .restricted:
            completion(false)
        @unknown default:
            completion(false)
        }
    }
}
