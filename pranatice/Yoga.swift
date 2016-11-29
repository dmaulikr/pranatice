//
//  Yoga.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import UIKit
import AVFoundation


class Yoga: NSObject {
    
    var player: AVAudioPlayer?

    var speechSynthesizer: AVSpeechSynthesizer? = nil
    var callInEnglish: Bool!
    
    func countCall(second: Int, in English: Bool) {
        call("\(second)", in: English)
    }
  
    func call(_ string: String, in English: Bool) {
        call(string, in: English, after: 0.0)
    }

    func call(_ callString: String, in englishCall: Bool, after delay: TimeInterval) {
                
        let localizedCall = englishCall ? String.inEnglish(key: callString) : NSLocalizedString(callString, comment: "")
        let utterance: AVSpeechUtterance = AVSpeechUtterance(string: localizedCall)
        //  rate:
        //  default = 0.5 ; min = 0.0 ; max = 1.0
        //  English 0.515, Japanese 0.540
        
        utterance.rate = UserSettings.speed
        utterance.volume = UserSettings.volume
        utterance.pitchMultiplier = 0.95    // [0.5 - 2] Default = 1

        utterance.preUtteranceDelay = delay
        utterance.postUtteranceDelay = 0.0
        
        if englishCall {
            utterance.voice = AVSpeechSynthesisVoice(language: "en-us")
        }
        // print(localizedCall)
        speechSynthesizer!.speak(utterance)
    }

    func ringFinishingBell() {
        let soundUrl = Bundle.main.url(forResource: "SingleWindBell", withExtension: "caf")!
        do {
            player = try AVAudioPlayer(contentsOf: soundUrl)
            guard let player = player else { return }
            
            player.volume = 0.5
            player.prepareToPlay()
            player.play()
        } catch let error {
            print(error.localizedDescription)
        }

        perform(#selector(done), with: self, afterDelay: 2.0)
    }
    
    func done() {}
    
    
}
