//
//  String+Format.swift
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation
import UIKit


extension String {
        
    static func formatForDateCell(string: String, weekcolor: UIColor, isAm: Bool) -> NSMutableAttributedString {
        let DATE_FONT = UIFont(name: "HelveticaNeue-Light", size: 16.0)!
        let HOUR_FONT = UIFont(name: "HelveticaNeue-Light", size: 14.0)!
        let DOT_FONT = UIFont(name: "ArialMT", size: 12.0)!
        let ATMARK_FONT = UIFont(name: "ArialMT", size: 10.0)!
        let amColor = isAm ? UIColor.kLightBlueColor : UIColor.kOrangeColor

        let attributedDateString = NSMutableAttributedString(string: string)

        // Date (include dot)
        attributedDateString.addAttribute(NSFontAttributeName,
                                     value: DATE_FONT,
                                     range: NSRange(location: 0, length: 5))
        // dot
        attributedDateString.addAttribute(NSFontAttributeName,
                                          value: DOT_FONT,
                                          range: NSRange(location:2, length:1))
        attributedDateString.addAttribute(NSForegroundColorAttributeName,
                                          value: weekcolor,
                                          range: NSRange(location:2, length:1))
        
        attributedDateString.addAttribute(NSBaselineOffsetAttributeName,
                                          value: 1.5,
                                          range: NSRange(location:2, length:1))
        attributedDateString.addAttribute(NSKernAttributeName,
                                          value: 0.75,
                                          range: NSRange(location:1, length:1))
        attributedDateString.addAttribute(NSKernAttributeName,
                                          value: 1.5,
                                          range: NSRange(location:2, length:1))
        // @
        attributedDateString.addAttribute(NSFontAttributeName,
                                          value: ATMARK_FONT,
                                          range: NSRange(location: 5, length: 1))
        attributedDateString.addAttribute(NSForegroundColorAttributeName,
                                          value: amColor,
                                          range: NSRange(location: 5, length: 1))
        attributedDateString.addAttribute(NSBaselineOffsetAttributeName,
                                          value: 3.0,
                                          range: NSRange(location: 5, length: 1))
        attributedDateString.addAttribute(NSKernAttributeName,
                                          value: 0.20,
                                          range: NSRange(location: 4, length: 1))
        attributedDateString.addAttribute(NSKernAttributeName,
                                          value: 3.0,
                                          range: NSRange(location: 5, length: 1))
        // time
        attributedDateString.addAttribute(NSFontAttributeName,
                                          value: HOUR_FONT,
                                          range: NSRange(location: 6, length: 5))
        attributedDateString.addAttribute(NSBaselineOffsetAttributeName,
                                          value: 0.50,
                                          range: NSRange(location: 6, length: 5))
        return attributedDateString
    }
}
