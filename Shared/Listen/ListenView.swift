//
//  ListenView.swift
//  Music-Player-App
//
//  Created by Zari McFadden on 7/15/21.
//

import SwiftUI

struct ListenView: View {
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                RoundedRectangle(cornerRadius: 16).fill(Color.pink).frame(width: 175, height: 200, alignment: .center)
                Spacer()
                Text("Song Title").font(.title).padding(5)
                Text("Artist").font(.subheadline)
                Spacer()
                ZStack {
                    Rectangle().fill(Color.blue).frame(maxWidth: .infinity, minHeight: 50, maxHeight: 300).cornerRadius(50, corners: [.topLeft, .topRight])
                    VStack {
                        HStack {
                            Text("0:00")
                            Spacer()
                            Text("3:50")
                        }.padding()
                        ProgressView(value: 0.50).accentColor(.black).padding()
                        HStack {
                            Button(action: {
                                print("Shuffle")
                            }, label: {
                                Image("SHUFFLE").resizable().aspectRatio(contentMode: .fit)
                            })
                            Button(action: {
                                print("Go Back")
                            }, label: {
                                Image("FORWARD").resizable().aspectRatio(contentMode: .fit).rotationEffect(.degrees(180))
                            })
                            Button(action: {
                                print("Play")
                            }, label: {
                                Image("PLAY").resizable().aspectRatio(contentMode: .fit)
                            })
                            Button(action: {
                                print("Go Forward")
                            }, label: {
                                Image("FORWARD").resizable().aspectRatio(contentMode: .fit)
                            })
                            Button(action: {
                                print("Repeat")
                            }, label: {
                                Image("REPEAT").resizable().aspectRatio(contentMode: .fit)
                            })
                        }
                        .frame(height: 50)
                        .padding()
                        HStack(spacing: 30){
                            Button(action: {
                                print("Lyrics")
                            }, label: {
                                Image("BLANK").resizable().aspectRatio(contentMode: .fit)
                            })
                            Button(action: {
                                print("Love")
                            }, label: {
                                Image("HEART").resizable().aspectRatio(contentMode: .fit)
                            })
                            Button(action: {
                                print("Download")
                            }, label: {
                                Image("DOWNLOAD").resizable().aspectRatio(contentMode: .fit)
                            })
                        }.frame(height: 25)
                    }
                }
            }
        }.background(Color(#colorLiteral(red: 0.906668961, green: 0.9068210721, blue: 0.9066489339, alpha: 0.5671768707)).edgesIgnoringSafeArea(.all))
    }
}

struct ListenView_Previews: PreviewProvider {
    static var previews: some View {
        ListenView()
    }
}

extension View {
    func cornerRadius(_ radius: CGFloat, corners: UIRectCorner) -> some View {
        clipShape( RoundedCorner(radius: radius, corners: corners) )
    }
}
struct RoundedCorner: Shape {

    var radius: CGFloat = .infinity
    var corners: UIRectCorner = .allCorners

    func path(in rect: CGRect) -> Path {
        let path = UIBezierPath(roundedRect: rect, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        return Path(path.cgPath)
    }
}
