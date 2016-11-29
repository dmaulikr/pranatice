//
//  Mood.swift
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import UIKit


struct Mood {
    static let Excellent    = 1
    static let Good         = 2
    static let Fair         = 3
    static let Bad          = 4
        
    static func image(with mood: Int) -> UIImage {
        let moodIconImageString: String!
        switch mood {
        case Mood.Excellent:
            moodIconImageString = "MoodIconExcellent"
        case Mood.Good:
            moodIconImageString = "MoodIconGood"
        case Mood.Fair:
            moodIconImageString = "MoodIconFair"
        case Mood.Bad:
            moodIconImageString = "MoodIconBad"
        default:
            moodIconImageString = "MoodIconExcellent"
        }
        return UIImage(named: moodIconImageString)!
    }
    
    static func color(of mood: Int16) -> UIColor {
        switch mood {
        case 1:
            // execelent
            return UIColor(red: 236.0/255.0, green: 109.0/255.0, blue: 113.0/255.0, alpha:1.0)
        case 2:
            return UIColor(red: 199.0/255.0, green: 220.0/255.0, blue: 104.0/255.0, alpha:1.0)
        case 3:
            return UIColor(red: 162.0/255.0, green: 215.0/255.0, blue: 221.0/255.0, alpha:1.0)
        case 4:
            return UIColor(red: 192.0/255.0, green: 162.0/255.0, blue: 199.0/255.0, alpha:1.0)
        default:
            return UIColor.gray
        }
    }
    
}
