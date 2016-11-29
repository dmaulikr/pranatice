//
//  Identifier.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation


struct Identifier {
    static let kapalbhati       = "kapalbhati"
    static let anulomvilom      = "anulomvilom"
    static let suryabhedana     = "suryabhedana"
    static let chandrabhedana   = "chandrabhedana"
    
    
    static func section(from identifier: String) -> Int {
        switch identifier {
        case Identifier.kapalbhati:
            return 0
        case Identifier.anulomvilom:
            return 1
        case Identifier.suryabhedana:
            return 2
        case Identifier.chandrabhedana:
            return 3
        default:
            return 0
        }
    }
    
    static func type(from identifier: String) -> Int16 {
       return Int16(section(from: identifier))
    }

    static func title(from section: Int) -> String {
        switch section {
        case 0:
            return Identifier.kapalbhati
        case 1:
            return Identifier.anulomvilom
        case 2:
            return Identifier.suryabhedana
        case 3:
            return Identifier.chandrabhedana
        case 4:
            return "call"
        case 5:
            return "export"
        default:
            return "none"
        }
    }
    
}


