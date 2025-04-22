//
//  video.swift
//  Tomato Tock
//
//  Created by Vanessa Pollice on 5/22/24.
//  Copyright © 2024 Steven J. Selcuk. All rights reserved.
//

import Foundation
import SwiftUI
import AVKit

struct LoopingVideoView: UIViewControllerRepresentable {
    var videoURL: URL
    
    func makeUIViewController(context: Context) -> UIViewController {
        let viewController = UIViewController()
        let player = AVPlayer(url: videoURL)
        let playerLayer = AVPlayerLayer(player: player)
        
        player.isMuted = true
        player.actionAtItemEnd = .none
        playerLayer.videoGravity = .resizeAspectFill
        
        playerLayer.frame = viewController.view.bounds
        viewController.view.layer.addSublayer(playerLayer)
        
        NotificationCenter.default.addObserver(forName: .AVPlayerItemDidPlayToEndTime, object: player.currentItem, queue: .main) { _ in
            player.seek(to: .zero)
            player.play()
        }
        
        player.play()
        
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Update view controller if needed
    }
    
    func dismantleUIViewController(_ uiViewController: UIViewController, coordinator: ()) {
        NotificationCenter.default.removeObserver(uiViewController)
    }
}
