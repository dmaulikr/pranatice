//
//  Exercise+CoreDataClass.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation
import UIKit
import CoreData

@objc(Exercise)
public class Exercise: NSManagedObject {
    
    var hasMemo: Bool {
        guard let str = memo else { return false }
        return str.utf16.count > 0
    }
    
    var isAM: Bool {
        let calender = NSCalendar(calendarIdentifier: .gregorian)!
        calender.timeZone = timeStampAt!
        let comps: DateComponents = calender.components( [ .hour ], from: timeStamp as! Date)
        let hour = comps.hour! as Int
        return hour < 12
    }
    
    
    // MARK: - Colors
    
//    func moodColor() -> UIColor {
//        switch self.mood {
//        case 1:
//            // execelent
//            return UIColor(red: 236.0/255.0, green: 109.0/255.0, blue: 113.0/255.0, alpha:1.0)
//        case 2:
//            return UIColor(red: 199.0/255.0, green: 220.0/255.0, blue: 104.0/255.0, alpha:1.0)
//        case 3:
//            return UIColor(red: 162.0/255.0, green: 215.0/255.0, blue: 221.0/255.0, alpha:1.0)
//        case 4:
//            return UIColor(red: 192.0/255.0, green: 162.0/255.0, blue: 199.0/255.0, alpha:1.0)
//        default:
//            return UIColor.gray
//        }
//    }
    
//    func dayColor() -> UIColor {
//        guard let date = self.timeStamp else {
//            return UIColor.gray
//        }
//        return UIColor.dayColor(date: date as Date)
//    }
    
    // MARK: - Strings
    
    func date() -> String {
        
        let calender = NSCalendar(calendarIdentifier: .gregorian)!
        calender.timeZone = timeStampAt!
        let comps: DateComponents = calender.components( [ .year, .month, .day, .hour, .minute ], from: timeStamp as! Date)
        let month = comps.month! as Int
        let day = comps.day! as Int
        var hour = comps.hour! as Int
        let isAM: Bool = hour < 12
        hour = (!isAM && hour != 12) ? hour - 12 : hour
        let monthString = month < 10 ? String(format: " \(month)") : "\(month)"
        let dayString = day < 10 ? String(format: "\(day) ") : "\(day)"
        let timeString = String(format: "%02d:%02d", hour, comps.minute!)
        let dateString = isExportedHealth ?
        String(format: "%@♥%@@%@", monthString, dayString, timeString) : String(format: "%@●%@@%@", monthString, dayString, timeString)
        
        
        return dateString
    }
    
    func title() -> String {
        let titleString: String!
        
        switch pranayamaType {
        case 0:
            // kapalbhati
            let label = NSLocalizedString("kapalbhati", comment: "")
     
            var labelString = String(format: "%@ (%d", label, pranayamaBaseCounts)
            if practiceKumbhaka {
                labelString = labelString.appendingFormat("+%d", pranayamaHold)
            }
            labelString = labelString.appendingFormat(")x%d", pranayamaRounds)
            titleString = labelString
        default:
            // anulomvilom and bhedanas
            let label = NSLocalizedString(Identifier.title(from: Int(pranayamaType)), comment: "") // error
            let inhale = pranayamaBaseCounts, hold = inhale * 4, exhale = inhale * 2
            titleString = String(format: "%@ (%d-%d-%d)x%d",
                                 label,
                                 inhale,hold,exhale,
                                 pranayamaRounds)
        }
        return titleString
    }
    
    func detail() -> String {
        return title()
    }
}
