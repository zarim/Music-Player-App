//
//  SearchView.swift
//  Music-Player-App
//
//  Created by Zari McFadden on 7/15/21.
//

import SwiftUI
import StoreKit
import SDWebImageSwiftUI
import MediaPlayer

struct SearchView: View {
    @ObservedObject var model: MusicViewModel
    @State private var search: String = ""
    @State var showResults = false
    @State var active: Bool = false
    @State var isPlaying: Bool = false
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $search, onCommit: {
                    UIApplication.shared.resignFirstResponder()
                    if search.isEmpty {
                        model.search(search: "")
                    } else {
                        requestAccess { auth in
                            if auth {
                                DispatchQueue.global(qos: .background).async {
                                    model.search(search: search)
                                }
                            }
                        }
                        showResults = true
                    }
                })
                if search != "" {
                    Button(action: {
                        model.searchResults = []
                        showResults = false
                        search = ""
                    }, label: {
                        Image("CLOSE")
                            .renderingMode(.template)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .foregroundColor(.white)
                    })
                }
            }
            .frame(width: 300, height: 30)
            .padding()
            if showResults {
                switch model.state {
                case .success:
                    List(model.searchResults, id: \.id) { song in
                        HStack {
                            WebImage(url: URL(string: song.attributes.artwork.url.replacingOccurrences(of: "{w}", with: "100").replacingOccurrences(of: "{h}", with: "100")))
                                .resizable()
                                .frame(width: 50, height: 50)
                                .cornerRadius(5)
                                .shadow(radius: 2)
                            VStack(alignment: .leading) {
                                Text(song.attributes.name)
                                Text(song.attributes.albumName).font(.footnote)
                                Text(song.attributes.artistName).font(.footnote)
                            }
                        }
                        .onTapGesture {
                            model.musicPlayer.setQueue(with: [song.id])
                            model.setSong(song: song)
                            active = true
                            model.musicPlayer.play()
                            model.isPlaying = true
                        }
                        .popover(isPresented: $active) {
                            ListenView(model: model).ignoresSafeArea()
                        }
                    }.ignoresSafeArea()
                case .loading:
                    ProgressView().foregroundColor(.white)
                case .error, .none:
                    Text("No Results").padding()
                }
            }
        }.navigationBarHidden(true)
    }
}
