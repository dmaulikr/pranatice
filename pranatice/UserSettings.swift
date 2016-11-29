//
//  SatiSetting.swift
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation


struct Key {
    struct Settings {
        
        // pranayama
        static let kapalbhatiCounts    = "kapalbhati_counts"
        static let kapalbhatiRounds     = "kapalbhati_rounds"
        static let doKunbhaka           = "exercise_kunbhaka"
        static let kunbhakaSeconds      = "kunbhaka_seconds"
        static let anulomvilomSeconds   = "anulomvilom_seconds"
        static let anulomvilomRounds    = "anulomvilom_rounds"
        static let suryabhedanaSeconds  = "suryabhedana_seconds"
        static let suryabhedanaRounds   = "suryabhedana_rounds"
        static let chandrabhedanaSeconds    = "chandrabhedana_seconds"
        static let chandrabhedanaRounds     = "chandrabhedana_rounds"
        
        // Etc
        static let callInEnglish        = "call_in_english"
        static let volume               = "call_volume"
        static let speed                = "call_speed"
        static let memoIndicator        = "memo_indicator"

        // export
        static let exportHealth         = "export_health"
        static let exportcalender       = "export_calender"
        static let calenderTitle        = "calender_title"
        
        // From Settings.bundle
        static let ShowBadge            = "show_badge"
        static let ShowStatus           = "show_status"
        
        static let AppClosedDate        = "applicationClosedDate"
    }
}

class UserSettings: NSObject {
  
    // MARK: - Pranayama settings
    
    static var kapalbhatiCounts: Int {
        get {
            return UserDefaults.standard.integer(forKey: Key.Settings.kapalbhatiCounts)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.kapalbhatiCounts)
        }
    }
    
    static var kapalbhatiRounds: Int {
        get {
            return UserDefaults.standard.integer(forKey: Key.Settings.kapalbhatiRounds)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.kapalbhatiRounds)
        }
    }
    
    static var doKunbhaka: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Key.Settings.doKunbhaka)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.doKunbhaka)
        }
    }

    static var kunbhakaSeconds: Int {
        get {
            return UserDefaults.standard.integer(forKey: Key.Settings.kunbhakaSeconds)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.kunbhakaSeconds)
        }
    }
    
    static var anulomvilomSeconds: Int {
        get {
            return UserDefaults.standard.integer(forKey: Key.Settings.anulomvilomSeconds)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.anulomvilomSeconds)
        }
    }
    
    static var anulomvilomRounds: Int {
        get {
            return UserDefaults.standard.integer(forKey: Key.Settings.anulomvilomRounds)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.anulomvilomRounds)
        }
    }
    
    static var suryabhedanaSeconds: Int {
        get {
            return UserDefaults.standard.integer(forKey: Key.Settings.suryabhedanaSeconds)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.suryabhedanaSeconds)
        }
    }
    
    static var suryabhedanaRounds: Int {
        get {
            return UserDefaults.standard.integer(forKey: Key.Settings.suryabhedanaRounds)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.suryabhedanaRounds)
        }
    }
    
    static var chandrabhedanaSeconds: Int {
        get {
            return UserDefaults.standard.integer(forKey: Key.Settings.chandrabhedanaSeconds)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.chandrabhedanaSeconds)
        }
    }
    
    static var chandrabhedanaRounds: Int {
        get {
            return UserDefaults.standard.integer(forKey: Key.Settings.chandrabhedanaRounds)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.chandrabhedanaRounds)
        }
    }
    
    // MARK: - calender health export

    static var exportHealth: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Key.Settings.exportHealth)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.exportHealth)
        }
    }
    
    static var exportCalender: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Key.Settings.exportcalender)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.exportcalender)
        }
    }

    static var calenderTitle: String {
        get {
            return UserDefaults.standard.string(forKey: Key.Settings.calenderTitle)!
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.calenderTitle)
        }
    }


    // MARK: - call
    
    static var callInEnglish: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Key.Settings.callInEnglish)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.callInEnglish)
        }
    }
    
    static var volume: Float {
        get {
            return UserDefaults.standard.float(forKey: Key.Settings.volume)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.volume)
        }
    }
    
    static var speed: Float {
        get {
            return UserDefaults.standard.float(forKey: Key.Settings.speed)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.speed)
        }
    }

    // MARK: - etc

    static var memoIndicator: String {
        get {
            return UserDefaults.standard.string(forKey: Key.Settings.memoIndicator)!
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.memoIndicator)
        }
    }
    
    // MARK: - Settings.bundle
    
    static var ShowBadge: Bool {
        get {
            return UserDefaults.standard.bool(forKey: Key.Settings.ShowBadge)
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.ShowBadge)
        }
    }
    
    static var applicationClosedDate: Date {
        get {
            return UserDefaults.standard.object(forKey: Key.Settings.AppClosedDate) as! Date
        }
        set { UserDefaults.standard.set(newValue, forKey: Key.Settings.AppClosedDate)
        }
    }
    
    /*
     static var CountUpBadge: Bool {
     get {
     return UserDefaults.standard.bool(forKey: Key.Settings.CountUpBadge)
     }
     set { UserDefaults.standard.set(newValue, forKey: Key.Settings.CountUpBadge)
     }
     }
     
     static var CountDownBadge: Bool {
     get {
     return UserDefaults.standard.bool(forKey: Key.Settings.CountDownBadge)
     }
     set { UserDefaults.standard.set(newValue, forKey: Key.Settings.CountDownBadge)
     }
     }
     
     static var CountDownNumber: Int {
     get {
     return UserDefaults.standard.integer(forKey: Key.Settings.CountDownNumber)
     }
     set { UserDefaults.standard.set(newValue, forKey: Key.Settings.CountDownNumber)
     }
     }
     */

}
