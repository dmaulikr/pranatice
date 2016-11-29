//
//  UIColor+DayColor.swift
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import UIKit

extension UIColor {
    
    // MARK: -  Base Colors
    
    class func gray10Color() -> UIColor { return UIColor(red:(229.0/255.0), green:(228.0/255.0), blue:(230.0/255.0), alpha:1.0) }
    class func gray25Color() -> UIColor { return UIColor(red:(192.0/255.0), green:(198.0/255.0), blue:(201.0/255.0), alpha:1.0) }
    class func gray50Color() -> UIColor { return UIColor(red:(158.0/255.0), green:(161.0/255.0), blue:(163.0/255.0), alpha:1.0) }
    class func gray75Color() -> UIColor { return UIColor(red: (89.0/255.0), green: (88.0/255.0), blue: (87.0/255.0), alpha:1.0) }
    class func gray85Color() -> UIColor { return UIColor(red:0.163, green:0.179, blue:0.179, alpha:1.0) }
    class func gray80Color() -> UIColor { return UIColor(red:0.195, green:0.204, blue:0.213, alpha:1.0) }
    class func gray90Color() -> UIColor { return UIColor(red: (43.0/255.0), green: (43.0/255.0), blue: (43.0/255.0), alpha:1.0) }
    
    @nonobjc static let kRedColor           = UIColor(red:(215.0/255.0), green:  (0.0/255.0), blue: (58.0/255.0), alpha:1.0)
    @nonobjc static let kOrangeColor        = UIColor(red:(234.0/255.0), green: (85.0/255.0), blue:  (6.0/255.0), alpha:1.0)
    @nonobjc static let kYellowColor        = UIColor(red:(250.0/255.0), green:(191.0/255.0), blue: (20.0/255.0), alpha:1.0)
    @nonobjc static let kLightGreenColor    = UIColor(red:(184.0/255.0), green:(210.0/255.0), blue:  (0.0/255.0), alpha:1.0)
    @nonobjc static let kGreenColor         = UIColor(red:  (0.0/255.0), green:(163.0/255.0), blue:(129.0/255.0), alpha:1.0)
    @nonobjc static let kBlueColor          = UIColor(red: (22.0/255.0), green: (94.0/255.0), blue:(131.0/255.0), alpha:1.0)
    @nonobjc static let kLightBlueColor     = UIColor(red: (44.0/255.0), green:(169.0/255.0), blue:(225.0/255.0), alpha:1.0)
    @nonobjc static let kPurpleColor        = UIColor(red:(112.0/255.0), green: (88.0/255.0), blue:(163.0/255.0), alpha:1.0)
    @nonobjc static let kPinkColor          = UIColor(red:(233.0/255.0), green: (82.0/255.0), blue:(149.0/255.0), alpha:1.0)

    // MARK: - Thai Weekday colors

    struct ThaiColor {
        static let  Monday      = kYellowColor
        static let  Tuesday     = kPinkColor
        static let  Wednesday   = kGreenColor
        static let  Thursday    = kOrangeColor
        static let  Fryday      = kLightBlueColor
        static let  Saturday    = kPurpleColor
        static let  Sunday      = kRedColor
    }
    
    // Weekend Color
    @nonobjc static let SaturdayColor    = UIColor(red:0.400, green:0.549, blue:0.851, alpha:1.0) // Bluegray
    @nonobjc static let SundayColor      = UIColor(red:0.739, green:0.152, blue:0.204, alpha:1.0) // CherryRed
  
    // MARK: -
    
    class func todayColor() -> UIColor {
        return self.dayColor(date: Date())
    }
    
    class func dayColor(date: Date) -> UIColor {
        // is NSDate.color() better than UIColor.dayColor() ??
        // NSDate().color() or now.color() = UIColor.todayColor() or UIColor.dayColor(now) ??
        let calender = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let comps = calender.components([ .hour, .weekday ], from: date) as NSDateComponents
        var day = comps.weekday
        // Before am3:00 count as day before.
        let hour = comps.hour
        if (hour <= 3 && hour >= 0) {
            day = (day == 1) ? 7 : day  - 1
        }
        return weekdayColor(weekday: day)
    }
    
    class func weekdayColor(weekday: Int) -> UIColor {
        let weekdayColor: UIColor
        switch weekday {
        case 1: // Sunday
            weekdayColor = ThaiColor.Sunday
        case 2:
            weekdayColor = ThaiColor.Monday
        case 3:
            weekdayColor = ThaiColor.Tuesday
        case 4:
            weekdayColor = ThaiColor.Wednesday
        case 5:
            weekdayColor = ThaiColor.Thursday
        case 6:
            weekdayColor = ThaiColor.Fryday
        case 7:
            weekdayColor = ThaiColor.Saturday
        default:
            weekdayColor = ThaiColor.Sunday
        }
        return weekdayColor
    }
    
    class func saturdayColor() -> UIColor {
        return SaturdayColor
    }
    
    class func sundayColor() -> UIColor {
        return SundayColor
    }


}
