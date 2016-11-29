//
//  Exercise+CoreDataProperties.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//


import Foundation
import CoreData


extension Exercise {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Exercise> {
        return NSFetchRequest<Exercise>(entityName: "Exercise");
    }

    @NSManaged public var timeStamp: NSDate?
    @NSManaged public var timeStampAt: TimeZone?
    @NSManaged public var practiceFor: Double

    @NSManaged public var pranayamaType: Int16
    @NSManaged public var pranayamaBaseCounts: Int16
    @NSManaged public var pranayamaRounds: Int16
    @NSManaged public var practiceKumbhaka: Bool
    @NSManaged public var pranayamaHold: Int16


    @NSManaged public var mood: Int16
    @NSManaged public var memo: String?

    @NSManaged public var isExportedHealth: Bool
    @NSManaged public var isExportedCalender: Bool

}
