//
//  ContentView.swift
//  Shared
//
//  Created by Zari McFadden on 7/14/21.
//

import SwiftUI
import StoreKit

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
            
        }
        .accentColor(.black)
        .onAppear() {
            requestAccess { auth in
                if auth {
                    DispatchQueue.global(qos: .background).async {
                       print(AppleMusicAPI().fetchStorefrontID())
                    }
                }
            }
        }
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

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
