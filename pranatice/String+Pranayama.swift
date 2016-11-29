//
//  String+Pranayama.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation
import UIKit

extension String {
    
    static func bhednaDescription(from pranayama: String, baseSeconds: Int, rounds: Int) -> String {
        // this is also used at main.start.buttons
        let label = NSLocalizedString(pranayama, comment: "")
        let inhale = baseSeconds
        let hold = baseSeconds * 4
        let exhale = baseSeconds * 2
        var totalSeconds = rounds * (inhale + hold + exhale)
        if pranayama == Identifier.anulomvilom {
            totalSeconds = totalSeconds * 2
        }
        var totalRoughMinutes = totalSeconds / 60
        if (totalSeconds % 60) != 0 {
            totalRoughMinutes += 1
        }
        let roughMinutesString = String(format: NSLocalizedString("format.rough-minutes", comment: ""), totalRoughMinutes)
        
        let labelString = String(format: "%@ (%d-%d-%d)x%d %@",
                                 label,
                                 inhale,hold,exhale,
                                 rounds,
                                 roughMinutesString)
        return labelString
    }
    
    static func reWriteLabel(with headerTitle: String) -> String {
        switch headerTitle {
        case Identifier.kapalbhati:
            let label = NSLocalizedString("kapalbhati", comment: "")
            var labelString = String(format: "%@ (%d", label, UserSettings.kapalbhatiCounts)
            if UserSettings.doKunbhaka {
                labelString = labelString.appendingFormat("+%d", UserSettings.kunbhakaSeconds)
            }
            
            var totalSeconds = UserSettings.kapalbhatiCounts * UserSettings.kapalbhatiRounds
            if UserSettings.doKunbhaka {
                totalSeconds += UserSettings.kunbhakaSeconds * UserSettings.kapalbhatiRounds
                
            }
            var totalRoughMinutes = totalSeconds / 60
            if (totalSeconds % 60) != 0 {
                totalRoughMinutes += 1
            }
            
            let roughMinutesString = String(format: NSLocalizedString("format.rough-minutes", comment: ""), totalRoughMinutes)
            
            labelString = labelString.appendingFormat(")x%d %@",
                                                      UserSettings.kapalbhatiRounds, roughMinutesString)
            return labelString
        case Identifier.anulomvilom:
            let labelString = bhednaDescription(from: "anulomvilom",
                                                baseSeconds: UserSettings.anulomvilomSeconds,
                                                rounds: UserSettings.anulomvilomRounds)
            return labelString
        case Identifier.suryabhedana:
            let labelString = bhednaDescription(from: "suryabhedana",
                                                baseSeconds: UserSettings.suryabhedanaSeconds,
                                                rounds: UserSettings.suryabhedanaRounds)
            return labelString
        case Identifier.chandrabhedana:
            let labelString = bhednaDescription(from: "chandrabhedana",
                                                baseSeconds: UserSettings.chandrabhedanaSeconds,
                                                rounds: UserSettings.chandrabhedanaRounds)
            return labelString
        default:
            let title = String(format: "settings.section.tile.%@", headerTitle)
            return NSLocalizedString(title, comment: "Section Title")
        }
    }
    
    
}
