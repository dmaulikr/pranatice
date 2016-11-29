//
//  String+Localized.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation

extension String {
    
    static func inEnglish(key: String) -> String {
        // return English localized string
        let bundlePath: NSString = Bundle.main.path(forResource: "Localizable", ofType: "strings", inDirectory: nil, forLocalization: "en")! as NSString
        let currentLangBundlePath = Bundle(path: bundlePath.deletingLastPathComponent)
        
        return NSLocalizedString(key, tableName: nil, bundle: currentLangBundlePath!, value: "", comment: "")
     }
    
}
