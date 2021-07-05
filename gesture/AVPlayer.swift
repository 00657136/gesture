//
//  AVPlayer.swift
//  gesture
//
//  Created by 張凱翔 on 2021/7/5.
//

import Foundation
import SwiftUI
import AVFoundation

extension AVPlayer{
    static var BGMQueuePlayer = AVQueuePlayer()
    
    static var BGMPlayerLooper: AVPlayerLooper!
    
    static func BGM() {
        guard let url = Bundle.main.url(forResource: "redLine", withExtension:"mp3")
        else {
            fatalError("Failed to find sound file.")
            
        }
        let item = AVPlayerItem(url: url)
        BGMPlayerLooper = AVPlayerLooper(player: BGMQueuePlayer, templateItem: item)
    }
    
    static let VoiceCorrectPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "答對音效", withExtension: "mp3")
        else{
            
            fatalError("Failed to find sound file.")
            
        }
        return AVPlayer(url: url)
    }()
    
    static let VoiceWroungPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "答錯音效", withExtension: "mp3")
        else{
            
            fatalError("Failed to find sound file.")
            
        }
        return AVPlayer(url: url)
    }()
    
    static let VoiceNextPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "下一题", withExtension: "mp3")
        else{
            
            fatalError("Failed to find sound file.")
            
        }
        return AVPlayer(url: url)
    }()
    
    func playFromStart() {
        seek(to: .zero)
        play()
    }
    
}


func wordSound(word:String){
    let utterance =  AVSpeechUtterance(string: word)
    
        utterance.pitchMultiplier = 1
        utterance.rate = 0.4
        utterance.voice = AVSpeechSynthesisVoice(language: "en-ZA")//改
        let synthesizer = AVSpeechSynthesizer()
        synthesizer.speak(utterance)
}
