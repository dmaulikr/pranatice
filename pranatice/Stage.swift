//
//  Stage.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import Foundation

enum Stage {
    
    case prepare
    case inhale
    case retain
    case exhale
    case relese
    
    mutating func next() {
        switch self {
        case .prepare: self = .inhale
        case .inhale: self = .retain
        case .retain: self = .exhale
        case .exhale: self = .inhale
        case .relese: self = .prepare
        }
    }
    
}
