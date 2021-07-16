////
////  SpotifyAuth.swift
////  Music-Player-App
////
////  Created by Zari McFadden on 7/15/21.
////
//import UIKit
//
//class ViewController: UIViewController, SPTSessionManagerDelegate, SPTAppRemoteDelegate, SPTAppRemotePlayerStateDelegate {
//    private let SpotifyClientID = "93eb3daf647247079de74ee176e3b7b1"
//    private let SpotifyRedirectURL = URL(string: "spotify-login-sdk-test-app://spotify-login-callback")!
//
//    lazy var configuration = SPTConfiguration(
//      clientID: SpotifyClientID,
//      redirectURL: SpotifyRedirectURL
//    )
//    
//    func sessionManager(manager: SPTSessionManager, didInitiate session: SPTSession) {
//        
//    }
//    
//    func sessionManager(manager: SPTSessionManager, didFailWith error: Error) {
//        
//    }
//    
//    func appRemoteDidEstablishConnection(_ appRemote: SPTAppRemote) {
//        
//    }
//    
//    func appRemote(_ appRemote: SPTAppRemote, didFailConnectionAttemptWithError error: Error?) {
//        
//    }
//    
//    func appRemote(_ appRemote: SPTAppRemote, didDisconnectWithError error: Error?) {
//        
//    }
//    
//    func playerStateDidChange(_ playerState: SPTAppRemotePlayerState) {
//        
//    }
//}
//
