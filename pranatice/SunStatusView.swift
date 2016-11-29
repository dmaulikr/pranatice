//
//  SunStatus.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import UIKit
import CoreData

class SunStatusView: UIView {
    
    let ONE_DAY: TimeInterval = 60*60*24
    // var dataSource: [Exercise?] = [nil]
    var dataSource: NSArray = []
    
    func rad(deg: Double) -> CGFloat {
        return CGFloat((deg - 120.0 - 3.0) / 180.0 * M_PI)
    }
    
    func update() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = app.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()

        let now = Date()
        let calender = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let comps = calender.components([ .hour, .minute, .second ], from: now) as NSDateComponents
        let secondsTillNow = Double((comps.hour * 60 * 60 + comps.minute * 60 + comps.second) * -1)

        let endOfToday = Date(timeIntervalSinceNow: secondsTillNow) // today 0:00
        let startDay = endOfToday.addingTimeInterval(Double(ONE_DAY * -12))
        let predicate = NSPredicate(format: "(timeStamp >= %@) AND (timeStamp < %@)", startDay as CVarArg, now as CVarArg)
        fetchRequest.predicate = predicate
        
        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        
        let result = try? managedObjectContext.fetch(fetchRequest) as NSArray
        dataSource = result!
        self.setNeedsDisplay()
    }
    
    // MARK: - Draw
    
    override func draw(_ rect: CGRect) {
        let now = Date()
        let calender = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        let comps = calender.components([ .hour, .minute, .second ], from: now) as NSDateComponents
        let secondsTillNow = Double((comps.hour * 60 * 60 + comps.minute * 60 + comps.second) * -1)
        let endOfToday = Date(timeIntervalSinceNow: secondsTillNow) // today 0:00
        var startDay = endOfToday.addingTimeInterval(Double(ONE_DAY * 12 * -1))
        var maxPracticeSecondsForDay = 0
        
        // to get MaxPracticeSeconds
        for _ in 0 ..< 13 {
            let predicate = NSPredicate(format: "(timeStamp >= %@) AND (timeStamp < %@)", startDay as CVarArg, startDay.addingTimeInterval(ONE_DAY) as CVarArg)
            let filtered = dataSource.filtered(using: predicate) as NSArray
            let totalPrcticeTime = filtered.value(forKeyPath: "@sum.practiceFor") as! NSNumber

            if totalPrcticeTime.intValue > maxPracticeSecondsForDay {
                maxPracticeSecondsForDay = totalPrcticeTime.intValue
            }
            startDay = startDay.addingTimeInterval(ONE_DAY)
        }
        
        // reset StartDay
        startDay = endOfToday.addingTimeInterval((ONE_DAY * 12 * -1))

        // size of frame = 30,30
        for i in 0 ..< 13 {
            let predicate = NSPredicate(format: "(timeStamp >= %@) AND (timeStamp < %@)", startDay as CVarArg, startDay.addingTimeInterval(ONE_DAY) as CVarArg)
            let filtered = dataSource.filtered(using: predicate) as NSArray
            let timesPractice = filtered.count
            let totalPrcticeTime = filtered.value(forKeyPath: "@sum.practiceFor") as! Double
            // UserSelection for alpha by 時間　か　回数
            let alphaValue = maxPracticeSecondsForDay == 0 ? 0.20 : CGFloat((totalPrcticeTime / Double(maxPracticeSecondsForDay)) + 0.20)
            // let alphaValue = CGFloat(0.3 * Double(timesPractice) + 0.20)
            // 15,15: 中心 15, 10.5:半径
            // 6 degree:　外周
            // +/- 6 6 degree:　内周
            if i == 12 {
                // Today
                // For Today Center Circle
                let context = UIGraphicsGetCurrentContext()
                context!.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: alphaValue)
                // 6 = 30 - 15:外枠の半径 - 9:中心円半径, 18 = 9:中心円半径 *2
                context!.fillEllipse(in: CGRect(x: 6, y: 6, width: 18, height: 18))
            } else {
                // draw line outside
                let context = UIGraphicsGetCurrentContext()
                context!.setFillColor(red: 1.0, green: 1.0, blue: 1.0, alpha: alphaValue)
                context!.addArc(center: CGPoint(x: 15.0, y: 15.0), radius: 15.0,
                                startAngle: rad(deg: Double(360-i*30)), endAngle: rad(deg: Double(360-i*30+6)),
                                clockwise: false)
                context!.addArc(center: CGPoint(x: 15.0, y: 15.0), radius: 10.5,
                                startAngle: rad(deg: Double(360 - i * 30 + 12)), endAngle: rad(deg: Double(360-i*30-6)),
                                clockwise: true)
                context!.fillPath()
            }
            startDay = startDay.addingTimeInterval(ONE_DAY)
        }
    }
    
}
