//
//  AppleMusicAPI.swift
//  Music-Player-App (iOS)
//
//  Created by Zari McFadden on 7/16/21.
//

// 1
import StoreKit
 
class AppleMusicAPI {
    // 3
    let developerToken = "eyJ0eXAiOiJKV1QiLCJhbGciOiJFUzI1NiIsImtpZCI6IlJVU05XTjMzVzQifQ.eyJpc3MiOiJQWVI5VEVWMjI1IiwiZXhwIjoxNjQyMjIxMTMyLCJpYXQiOjE2MjY0NDk1MzJ9.KRSyKrTO6xaJzBBDPKRQXfC98mLqN2UUE-rvpoVurhpLiBYniP-a8OX5uDvbdGqf_wnCr9nOhx49_KzdovQXSw"
    
    // 4
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
    func fetchStorefrontID() -> String {
        let userToken = getToken()
        // 1
        let lock = DispatchSemaphore(value: 0)
        var storefrontID: String!
     
        // 2
        let musicURL = URL(string: "https://api.music.apple.com/v1/me/storefront")!
        var musicRequest = URLRequest(url: musicURL)
        musicRequest.httpMethod = "GET"
        musicRequest.addValue("Bearer \(developerToken)", forHTTPHeaderField: "Authorization")
        musicRequest.addValue(userToken, forHTTPHeaderField: "Music-User-Token")
     
        // 3
        URLSession.shared.dataTask(with: musicRequest) { (data, response, error) in
               guard error == nil else { return }
        
               // 4
               if let json = try? JSON(data: data!) {
                   print(json.rawString())
               }
           }.resume()
     
        // 5
        lock.wait()
        return storefrontID
    }
    
    func getToken() -> String {
        var token: String = ""
        let lock = DispatchSemaphore(value: 0)
        getUserToken { userToken in
            token = userToken
            lock.signal()
        }
        lock.wait()
        return token
    }
}
