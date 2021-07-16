//
//  ContentView.swift
//  Shared
//
//  Created by Zari McFadden on 7/14/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BrowseView().tabItem {
                Image("HOME")
                Text("Home")
            }
            ListenView().tabItem {
                Image("HEADPHONES")
                Text("Listen")
            }
            SearchView().tabItem {
                Image("MAGNIFYING GLASS")
                Text("Search")
            }
            
        }.accentColor(.black)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
