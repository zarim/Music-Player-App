//
//  ListenView.swift
//  Music-Player-App
//
//  Created by Zari McFadden on 7/15/21.
//

import SwiftUI
import SDWebImageSwiftUI
import MediaPlayer

struct ListenView: View {
    @ObservedObject var model: MusicViewModel
    @State var shufflePressed: Bool = false
    @State var repreatPressed: Bool = false
    @State var progress: Float = 0.0
    @State var love: Bool = false
    var body: some View {
        ZStack {
            Spacer()
            VStack {
                Spacer()
                WebImage(url: URL(string: model.song?.attributes.artwork.url.replacingOccurrences(of: "{w}", with: "600").replacingOccurrences(of: "{h}", with: "700") ?? "https://images.unsplash.com/photo-1585298723682-7115561c51b7?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=1300&q=80"))
                    .resizable()
                    .frame(width: 300, height: 350)
                    .cornerRadius(5)
                    .shadow(radius: 2)
                Spacer()
                Text(model.song?.attributes.name ?? "Not Playing")
                    .font(.title)
                    .multilineTextAlignment(.center)
                    .foregroundColor(hexStringToUIColor(hex: model.song?.attributes.artwork.textColor1 ??  "fffff"))
                Text(model.song?.attributes.artistName ?? "")
                    .font(.title3)
                    .foregroundColor(hexStringToUIColor(hex: model.song?.attributes.artwork.textColor1 ?? "fffff"))
                Spacer()
                VStack {
                    HStack {
                        Text("0:00")
                            .foregroundColor(hexStringToUIColor(hex: model.song?.attributes.artwork.textColor1 ?? "fffff"))
                        Spacer()
                        Text(TimeInterval(model.song?.attributes.durationInMillis.msToSeconds ?? 0).minuteSecond)
                            .foregroundColor(hexStringToUIColor(hex: model.song?.attributes.artwork.textColor1 ?? "fffff"))
                    }.padding()
                    ProgressView(value: progress)
                        .accentColor(.black)
                        .padding()
                    HStack {
                        Button(action: {
                            shufflePressed = !shufflePressed
                            switch model.musicPlayer.shuffleMode {
                            case .default, .off:
                                model.musicPlayer.shuffleMode = .songs
                            case .songs:
                                model.musicPlayer.shuffleMode = .albums
                            case .albums:
                                model.musicPlayer.shuffleMode = .off
                            @unknown default:
                                model.musicPlayer.shuffleMode = .default
                            }
                        }, label: {
                            Image("SHUFFLE")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(hexStringToUIColor(hex: model.song?.attributes.artwork.textColor1 ?? "fffff"))
                                .opacity(shufflePressed ? 1 : 0.5)
                        })
                        Button(action: {
                            model.musicPlayer.skipToBeginning()
                        }, label: {
                            Image("FORWARD")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(hexStringToUIColor(hex: model.song?.attributes.artwork.textColor1 ?? "fffff"))
                                .rotationEffect(.degrees(180))
                        })
                        .onTapGesture(count: 2, perform: {
                            model.musicPlayer.skipToPreviousItem()
                        })
                        .onLongPressGesture {
                            model.musicPlayer.beginSeekingBackward()
                        }
                        Button(action: {
                            model.isPlaying = !model.isPlaying
                            if model.musicPlayer.playbackState == .stopped {
                                model.isPlaying = false
                            }
                            model.isPlaying ? model.musicPlayer.play() : model.musicPlayer.pause()
                        }, label: {
                            Image(model.isPlaying ? "PAUSE" : "PLAY")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(hexStringToUIColor(hex: model.song?.attributes.artwork.textColor1 ?? "fffff"))
                        })
                        Button(action: {
                            model.musicPlayer.skipToNextItem()
                        }, label: {
                            Image("FORWARD")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(hexStringToUIColor(hex: model.song?.attributes.artwork.textColor1 ?? "fffff"))
                        }).onLongPressGesture {
                            model.musicPlayer.beginSeekingForward()
                        }
                        Button(action: {
                            repreatPressed = !repreatPressed
                            switch model.musicPlayer.repeatMode {
                            case .one:
                                model.musicPlayer.repeatMode = .all
                            case .default, .none:
                                model.musicPlayer.repeatMode = .one
                            case .all:
                                model.musicPlayer.repeatMode = .none
                            @unknown default:
                                model.musicPlayer.repeatMode = .default
                            }
                        }, label: {
                            Image("REPEAT")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(hexStringToUIColor(hex: model.song?.attributes.artwork.textColor1 ?? "fffff"))
                                .opacity(repreatPressed ? 1 : 0.5)
                        })
                    }
                    .frame(height: 50)
                    .padding()
                    HStack(spacing: 30){
                        Button(action: {
                            print("Lyrics")
                        }, label: {
                            Image("BLANK")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(hexStringToUIColor(hex: model.song?.attributes.artwork.textColor1 ?? "fffff"))
                        })
                        Button(action: {
                            love = !love
                        }, label: {
                            Image("HEART")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(love ? Color(.red) : hexStringToUIColor(hex: model.song?.attributes.artwork.textColor1 ?? "fffff"))
                        })
                        Button(action: {
                            print("Save song")
                        }, label: {
                            Image("DOWNLOAD")
                                .renderingMode(.template)
                                .resizable()
                                .aspectRatio(contentMode: .fit)
                                .foregroundColor(hexStringToUIColor(hex: model.song?.attributes.artwork.textColor1 ?? "fffff"))
                        })
                    }.frame(height: 25)
                }
                Spacer()
            }
        }
        .background(hexStringToUIColor(hex: model.song?.attributes.artwork.bgColor ?? "#000000"))
        .edgesIgnoringSafeArea(.top)
    }
}

func hexStringToUIColor (hex:String) -> Color {
    var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

    if (cString.hasPrefix("#")) {
        cString.remove(at: cString.startIndex)
    }

    if ((cString.count) != 6) {
        return Color.gray
    }

    var rgbValue:UInt64 = 0
    Scanner(string: cString).scanHexInt64(&rgbValue)

    return Color(
        red: Double(CGFloat((rgbValue & 0xFF0000) >> 16)) / 255.0,
        green: Double(CGFloat((rgbValue & 0x00FF00) >> 8)) / 255.0,
        blue: Double(CGFloat(rgbValue & 0x0000FF) / 255.0)
    )
}

func getProgress(model: MusicViewModel) -> Float {
    let time = model.musicPlayer.currentPlaybackTime * 1000
    return Float(time)
}
