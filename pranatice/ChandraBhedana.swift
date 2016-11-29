//
//  ChandraBhedana.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//


import Foundation


class ChandraBhedana: Anulomvilom {

    override func startPractice() {
        rounds = 1
        type = Identifier.chandrabhedana
        baseSeconds = settingSeconds
        settingRounds = settingRounds
        isBreathingRight = false
        
        prepareForPractice()
    }
    
    override func changeNostril() {
        return
    }
}
