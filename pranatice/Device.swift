//
//  Device.swift
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import UIKit

struct Device {
    struct Screen {
        static let Width    = UIScreen.main.bounds.size.width
        static let Height   = UIScreen.main.bounds.size.height
        static let Midx     = Device.Screen.Width / 2
    }
    
    static func iOSDecive() -> NSString {
        let height = self.Screen.Height
        if (height < 500) {
            return "iPhone4"
        } else if (height < 570) { // 568
            return "iPhone5"
        } else if (height < 670) { // 667
            return "iPhone6"
        } else if (height < 750) { // 736
            return "iPhone6plus"
        }
        return "other"
    }
    
    static func isiPhone4() -> Bool {
        return self.iOSDecive() == "iPhone4"
    }
    
    static func isiPhone5() -> Bool {
        return self.iOSDecive() == "iPhone5"
    }
    
    static func isiPhone6() -> Bool {
        return self.iOSDecive() == "iPhone6"
    }
    
    static func isiPhone6plus() -> Bool {
        return self.iOSDecive() == "iPhone6plus"
    }
}

