//
//  Date+Changed.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation
import UIKit


extension Date {
    
    static func hasChanged(since dateClosed: Date) -> Bool {
        return !isSameDay(with: dateClosed)
    }
    
    static func isSameDay(with storedDate: Date) -> Bool {
        let calender = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let closeDate = calender.components([ .year, .month, .day ], from: storedDate) as NSDateComponents
        let now = calender.components([ .year, .month, .day ], from: Date()) as NSDateComponents
        
        return closeDate.year == now.year && closeDate.month == now.month && closeDate.day == now.day
    }

}
