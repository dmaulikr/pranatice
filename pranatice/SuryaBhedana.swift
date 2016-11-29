//
//  SuryaBhedana.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation


class SuryaBhedana: Anulomvilom {

    override func startPractice() {
        rounds = 1
        type = Identifier.suryabhedana
        baseSeconds = settingSeconds
        settingRounds = settingRounds
        isBreathingRight = true

        prepareForPractice()
    }

    override func changeNostril() {
        return
    }

}

    
