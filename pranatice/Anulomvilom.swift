//
//  Anulomvilom.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation

class Anulomvilom: Pranayama {

    var baseSeconds: Int = 0
    var countingText: String!
    
    var seconds = 0
    var isBreathingRight: Bool = false

    override func startPractice() {
        // initialize
        rounds = 1
        type = Identifier.anulomvilom
        baseSeconds = settingSeconds
        settingRounds = settingRounds * 2  // 1 Round = (R+L, L+R)

        prepareForPractice()
    }
    
    override func startPranayama() {
        super.startPranayama()
        stage.next()
        countingText = isBreathingRight ? "close left" : "close right"
        call(countingText, in: callInEnglish)
        perform(#selector(startTimer), with: self, afterDelay: 0.50)
    }
    
    override func releasePranayama() {
        call("inhale", in: callInEnglish)
        super.releasePranayama()
    }
    
    
    override func count() {
        // call every second by timer
        switch stage {
        case .inhale:
            switch seconds {
            case 0:
                countingText = isBreathingRight ? "inhale from right" : "inhale from left"
                call(countingText, in: callInEnglish)

            case baseSeconds:
                // finish
                let retain = String(format: "%@", "retain")
                call(retain, in: callInEnglish)

                reset()
            default:
                countCall(second: seconds+1, in: callInEnglish)
            }
        case .retain:
            if seconds == 3 && rounds == (settingRounds - 2) {
                // Last round
                call("last round", in: callInEnglish)
            } else if (seconds >= (baseSeconds * 4 - 3) && seconds < (baseSeconds * 4)) {
                countCall(second: seconds+1, in: callInEnglish)
            } else if (seconds == (baseSeconds * 4)) {
                // finish
                let exhale = isBreathingRight ? "exhale from left" : "exhale from right"
                call(exhale, in: callInEnglish)
                
                reset()
            } else {
                break
            }
        case .exhale:
                if (seconds == (baseSeconds * 2)) {
                    // when should i call "last round"
                    if (rounds == settingRounds) {
                        timer.invalidate()
                        reset()
                        
                        self.call("drop hand", in: callInEnglish)
                        releasePranayama()
                    } else {
                        changeNostril()

                        let inhale = isBreathingRight ? "inhale from right" : "inhale from left"
                        //countingText = String(format: "%d %@", seconds, "inhale")
                        call(inhale, in: callInEnglish)
                        
                        rounds += 1
                        reset()
                    }
                } else {
                    countCall(second: seconds+1, in: callInEnglish)
            }
        default: break
        }
         seconds += 1
    }
    
    func changeNostril() {
        isBreathingRight = !isBreathingRight
    }
    
    func reset() {
        seconds = 0
        countingText = nil
        stage.next()
    }
    

}
