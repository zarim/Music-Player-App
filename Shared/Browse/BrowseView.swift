//
//  BrowseView.swift
//  Music-Player-App
//
//  Created by Zari McFadden on 7/15/21.
//

import SwiftUI

struct BrowseView: View {
    @State private var search: String = ""
    @State var moodsClicked = true
    @State var artistClicked = false
    @State var podcastsClicked = false
    @State var showSearch = false
    var buttonItems: [BrowseMenuItem] = BrowseMenuItem.allCases
    var moodItems: [Moods] = Moods.allCases
    var podcastItems: [Podcasts] = Podcasts.allCases
    var artistItems: [Artists] = Artists.allCases
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                Text("Browse").font(.largeTitle)
                Spacer(minLength: 32)
                HStack {
                    ForEach(buttonItems) { item in
                        switch item {
                        case .moods:
                            Button(action: {
                                (moodsClicked, artistClicked, podcastsClicked) = didTap(item: .moods)
                            }, label: {
                                Text(item.title)
                                    .foregroundColor(.black)
                                    .opacity(moodsClicked ? 1 : 0.5)
                                Spacer()
                                }
                            )
                        case .artists:
                            Button(action: {
                                (moodsClicked, artistClicked, podcastsClicked) = didTap(item: .artists)
                            }, label: {
                                Text(item.title)
                                    .foregroundColor(.black)
                                    .opacity(artistClicked ? 1 : 0.5)
                                Spacer()
                                }
                            )
                        case .podcasts:
                            Button(action: {
                                (moodsClicked, artistClicked, podcastsClicked) = didTap(item: .podcasts)
                            }, label: {
                                Text(item.title)
                                    .foregroundColor(.black)
                                    .opacity(podcastsClicked ? 1 : 0.5)
                                Spacer()
                                }
                            )
                        }
                    }
                    .frame(alignment: .leading)
                    .padding(.bottom)
                }
                ScrollView(.horizontal) {
                    HStack {
                        if artistClicked {
                            ForEach(artistItems) {artist in
                                menuCard(item: .artists, title: artist.title)
                            }
                        } else if podcastsClicked {
                            ForEach(podcastItems) {podcast in
                                menuCard(item: .podcasts, title: podcast.title)
                            }
                        } else {
                            ForEach(moodItems) { mood in
                                menuCard(item: .moods, title: mood.title)
                            }
                        }
                    }
                }.padding(.bottom, 25)
                Text("Recently Played")
                ScrollView {
                    List {
                        
                    }
                }
            }
            .padding()
            .frame(alignment: .leading)
        }
    }
}

func didTap(item: BrowseMenuItem)  -> (Bool, Bool, Bool) {
    var moodClicked = false
    var artistClicked = false
    var podcastsClicked = false
    
    switch item {
    case .moods:
        moodClicked = true
    case .artists:
        artistClicked = true
    case .podcasts:
        podcastsClicked = true
    }
    
    return (moodClicked, artistClicked, podcastsClicked)
}

struct menuCard: View {
    var item: BrowseMenuItem
    var title: String
    var body: some View {
        Button(action: {
            print(item)
            print(title)
            print()
        }, label: {
            ZStack(alignment: .bottom) {
                RoundedRectangle(cornerRadius: 25.0, style: .continuous)
                    .fill(Color.purple)
                Rectangle()
                    .fill(Color.white)
                    .frame(minWidth: 0, maxWidth: .infinity, maxHeight: 75, alignment: .bottom)
                    .clipped()
                    .opacity(0.8)
                Text(title)
                    .foregroundColor(.black)
                    .fontWeight(.semibold)
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: 75, alignment: .center)
                    .multilineTextAlignment(.center)
                    .lineLimit(2)
            }.clipShape(RoundedRectangle(cornerRadius: 25.0))
            .frame(width: 175, height: 225, alignment: .bottom)
            .padding(10)
        })

    }
}

struct BrowseView_Previews: PreviewProvider {
    static var previews: some View {
        BrowseView()
    }
}
