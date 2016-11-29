//
//  Kapalbhati.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation

class Kapalbhati: Pranayama {
        
    var totalRounds: Int!
    var totalCounts: Int!
    var seconds: Int = 0
    var counts: Int = 0
    
    // For Kumbhaka
    var totalSecondsForKumbhaka: Int!
    var doKumbhaka: Bool = false // from settings
    var isHolding: Bool = false
    
    init(_ counts: Int, with _rounds: Int, doKumbhaka exerciseKunbhaka: Bool) {
        super.init(counts, with: _rounds)
        doKumbhaka = exerciseKunbhaka
    }
    
    override func startPractice() {
        counts = 0
        seconds = 0
        rounds = 1
        
        type = Identifier.kapalbhati
        totalCounts = settingSeconds
        totalRounds = settingRounds
        totalSecondsForKumbhaka = UserSettings.kunbhakaSeconds
        
        prepareForPractice()
    }
    
    override func startPranayama() {
        super.startPranayama()

        call("breathe in", in: callInEnglish)
        call("begin", in: callInEnglish, after: 2.0)

        stage = .exhale

        perform(#selector(startTimer), with: self, afterDelay: 3.20)
    }
    
    override func releasePranayama() {
        timer.invalidate()
        super.releasePranayama()
    }
    
    override func count() {

        if !isHolding {
            if counts == totalCounts {
                if doKumbhaka {
                    // do Kumbhaka
                    // if stage != .prepare {
                        timer.invalidate()
                        prepareForKumbhaka()
                    // }
                } else {
                    finish(with: rounds)
                }
            } else if counts > (totalCounts - 4) {
                // call last 4 counts
                let countSecond = totalCounts - counts
                countCall(second: countSecond, in: callInEnglish)
            } else {
                call("1", in: callInEnglish)
            }

            counts += 1
        } else {
            // on Kumbhaka
            if seconds == totalSecondsForKumbhaka {
                isHolding = false
                finish(with: rounds)
                
            } else if seconds == (totalSecondsForKumbhaka - 10) {
                // call 10 more seconds
                call("10 more seconds", in: callInEnglish)
            }
            
            seconds += 1
        }
    }
    
    func finish(with thisRound: Int) {
        // finish
        timer.invalidate()

        if thisRound == totalRounds {
            // Release
            call("exhale gently", in: callInEnglish)
            call("inhale", in: callInEnglish, after: 4.0)
            perform(#selector(releasePranayama), with: self, afterDelay: 10.0)
        } else {
            callNextRound()
        }
    }
    
    func callNextRound() {
        call("exhale gently", in: callInEnglish)
        call("inhale", in: callInEnglish, after: 3.0)
        call("exhale", in: callInEnglish, after: 3.0)
        call("next round", in: callInEnglish, after: 3.0)

        rounds += 1     // count up
        counts = 0      // reset counter
        seconds = 0     // reset counter
        
        perform(#selector(prepareForPractice), with: self, afterDelay: 12.0)
    }
    
    // MARK: - Kumbhaka
    
    func prepareForKumbhaka() {
        //call for Kumbhaka
        stage = .prepare
        counts = 0
        seconds = 0

        call("exhale completely", in: callInEnglish)
        call("inhale", in: callInEnglish, after: 3.0)
        call("exhale", in: callInEnglish, after: 4.0)
        call("inhale comfortably", in: callInEnglish, after: 4.0)
        
        perform(#selector(startKumbhaka), with: self, afterDelay: 18.0)
    }
    
    func startKumbhaka() {
        call("and hold", in: callInEnglish)
        startTimer()
        isHolding = true
    }
    
       
}
