//
//  Pranayama.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import UIKit
import AVFoundation


protocol PranayamaDelegate {
    func pranayamaDidFinish(pranayama: Pranayama)
}


class Pranayama: Yoga {
    
    var delegate: PranayamaDelegate? = nil
    var timer: Timer!
    // var player: AVAudioPlayer?

    var type: String = Identifier.kapalbhati
    // From Setting
    var settingSeconds: Int!
    var settingRounds: Int!
    
    // Counter
    // var counts = 0
    var rounds = 0
    var stage: Stage = .prepare
    
    var startTime: Date!
    var length: Double = 0

    init(_ baseNumber: Int, with totalRound: Int) {
        super.init()
        settingSeconds = baseNumber
        settingRounds = totalRound
        callInEnglish = UserSettings.callInEnglish
        startTime = Date()
        
        // do this because of thread and avoiding errors
        self.speechSynthesizer = AVSpeechSynthesizer()
        UIApplication.shared.isIdleTimerDisabled = true
    }
    
    func startPractice() {}

    func prepareForPractice() {
        stage = .prepare

        // prepare need couple of seconds to start
        call("inhale", in: callInEnglish, after: 2.0)
        call("exhale", in: callInEnglish, after: 3.0)
        call("inhale", in: callInEnglish, after: 3.5)
        call("exhale", in: callInEnglish, after: 4.0)
        
        perform(#selector(startPranayama), with: self, afterDelay: 20.0)
    }
    
    func startPranayama() {}

    func startTimer() {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(count),
                                     userInfo: nil,
                                     repeats: true)
    }

    func count() {}
    
    func releasePranayama() {
        call("exhale", in: callInEnglish, after: 3.0)
        call("inhale", in: callInEnglish, after: 3.0)
        call("exhale", in: callInEnglish, after: 4.0)
        call("release", in: callInEnglish, after: 3.0)
        perform(#selector(ringFinishingBell), with: self, afterDelay: 20.0)
    }
    
    override func done() {
        length = Date().timeIntervalSince(startTime)
        UIApplication.shared.isIdleTimerDisabled = false
        delegate?.pranayamaDidFinish(pranayama: self)
    }
    
    func cancel() {
        speechSynthesizer?.stopSpeaking(at: .immediate)
        NSObject.cancelPreviousPerformRequests(withTarget: self)
        UIApplication.shared.isIdleTimerDisabled = false
        if let startedTimer = timer {
            startedTimer.invalidate()
        }
    }
 
}
