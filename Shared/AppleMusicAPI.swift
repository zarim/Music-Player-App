//
//  AppleMusicAPI.swift
//  Music-Player-App (iOS)
//
//  Created by Zari McFadden on 7/16/21.
//
import StoreKit
 
class AppleMusicAPI {
    let developerToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6IlJVU05XTjMzVzQifQ.eyJpc3MiOiJQWVI5VEVWMjI1IiwiZXhwIjoxNjQyMjIxMTMyLCJpYXQiOjE2MjY0NDk1MzJ9.KRSyKrTO6xaJzBBDPKRQXfC98mLqN2UUE-rvpoVurhpLiBYniP-a8OX5uDvbdGqf_wnCr9nOhx49_KzdovQXSw"
    
    func getUserToken(_ completion: @escaping(String) -> Void) {
        SKCloudServiceController().requestUserToken(forDeveloperToken: developerToken) { (receivedToken, error) in
            guard error == nil else { return }
            if let token = receivedToken {
                DispatchQueue.main.async {
                    completion(token)
                }
            }
        }
    }
    
    ///A storefront is an object that represents the iTunes Store territory that the content is available in. When we perform a search using the Apple Music API, we’d like to show results relevant to our user’s location.
    func fetchStorefrontID(completion: @escaping (String) -> Void){
        var storefrontID: String = ""
        var userToken = ""
        let lock = DispatchSemaphore(value: 0)
        getUserToken { token in
            userToken = token
            lock.signal()
        }
        lock.wait()

        let musicURL = URL(string: "https://api.music.apple.com/v1/me/storefront")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        musicRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
        
        URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
            guard error == nil else { return }
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(StorefrontModel.self, from: data)
                    storefrontID = results.data[0].id
                    DispatchQueue.main.async {
                        completion(storefrontID)
                    }
                } catch { print(error) }
            }
        }.resume()
    }
    
    func searchAppleMusic(_ searchTerm: String!, completion: @escaping ([SongData], SearchState) -> Void) {
        let lock = DispatchSemaphore(value: 0)
        let lock1 = DispatchSemaphore(value: 0)
        let cleanSearch = cleanSearch(search: searchTerm)
        var storefront: String = ""
        var songs = [SongData]()
        var userToken = ""
        
        getUserToken { token in
            userToken = token
            lock.signal()
        }
        lock.wait()
        
        fetchStorefrontID { id in
            storefront = id
            lock1.signal()
        }
        lock1.wait()
        
        var musicRequest = URLRequest(url: URL(string: "https://api.music.apple.com/v1/catalog/\(storefront)/search?term=\(cleanSearch)&limit=25&types=songs,artists,albums")!)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        musicRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
     
        URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
            guard error == nil else { return }
            if let data = data {
                do {
                    let results = try JSONDecoder().decode(MusicAPIModel.self, from: data)
                    for result in results.results.songs.data {
                        songs.append(result)
                    }
                    DispatchQueue.main.async {
                        completion(songs, .success)
                    }
                } catch {completion([], .error) }
            } else { completion([], .loading)}
        }.resume()
    }
}

func cleanSearch(search: String) -> String {
    let okayChars = Set("abcdefghijklmnopqrstuvwxyz ABCDEFGHIJKLKMNOPQRSTUVWXYZ1234567890+-=().!_")
    var newSearch = search
    newSearch = search.trimmingCharacters(in: .whitespacesAndNewlines)
    newSearch = newSearch.replacingOccurrences(of: " ", with: "+")
    newSearch = newSearch.filter { okayChars.contains($0) }.lowercased()
    return newSearch
}
