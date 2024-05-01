//
//  ChatSounds.swift
//  AESDemo
//
//  Created by Ernest Nyumbu on 2024/04/20.
//

import Foundation
import AVFoundation

struct ChatPlayer {

    private var audioPlayer: AVAudioPlayer?

    init(audioFile: String) {
        if let soundURL = Bundle.main.url(forResource: audioFile, withExtension: "mp3") {
            do {
                // Initialize AVAudioPlayer with the audio file URL
                audioPlayer = try AVAudioPlayer(contentsOf: soundURL)
            } catch {
                // Handle initialization error
                print("Failed to load audio file: \(error)")
            }
        } else {
            // Handle missing audio file
            print("Audio file not found")
        }
    }

    func play() {
        if let audioPlayer = audioPlayer {
            audioPlayer.play()
        }
    }

}
