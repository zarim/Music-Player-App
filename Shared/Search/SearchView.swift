//
//  SearchView.swift
//  Music-Player-App
//
//  Created by Zari McFadden on 7/15/21.
//

import SwiftUI

struct SearchView: View {
    @State private var search: String = ""
    @State var showResults = false
    var results: [String] = ["Result 1", "Result 2", "Result 3", "Result 4", "Result 5"]
    var body: some View {
        VStack {
            HStack {
                TextField("Search", text: $search, onCommit: {
                    showResults = !showResults
                    print(search)
                })
                if search != "" {
                    Button(action: {
                        showResults = false
                        search = ""
                    }, label: {
                        Image("CLOSE").resizable().aspectRatio(contentMode: .fit)
                    })
                }
            }.frame(height: 30)
            .frame(width: 300)
            .padding()
            if showResults {
                VStack {
                    List {
                        ForEach(results, id: \.self) { result in
                            Text(result)
                        }
                    }
                }
            }
        }
    }
}

struct SearchView_Previews: PreviewProvider {
    static var previews: some View {
        SearchView()
    }
}
