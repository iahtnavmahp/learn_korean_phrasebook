//
//  PlaySound.swift
//  learn_korean_phrasebook
//
//  Created by Pham Van Thai on 27/11/2021.
//

import Foundation
import AVFoundation
class PlaySound{
    static func playSound(str:String,synth:AVSpeechSynthesizer){
        let audioSession = AVAudioSession.sharedInstance()
        do {
            try audioSession.setCategory(AVAudioSession.Category.soloAmbient)
            try audioSession.setMode(AVAudioSession.Mode.spokenAudio)
            try audioSession.setActive(true, options: .notifyOthersOnDeactivation)
        } catch {
            print("err text to speech")
        }
        
        let utterance = AVSpeechUtterance(string: str)
        
        utterance.voice = AVSpeechSynthesisVoice(language: "ko-KR")
        
        synth.speak(utterance)
    }
}
