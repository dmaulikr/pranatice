//
//  HistoryBarView.swift
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//

import UIKit
import CoreData

class HistoryBarView: UIView {

    let BLOCK_HEIGHT_MOOD: CGFloat  = 10
    let BLOCK_HEIGHT_DAY: CGFloat   = 2
    let BLOCK_WIDTH: CGFloat = {
        //  IPHONE6_WIDTH = 375
        return (Int(Device.Screen.Width) <= 375) ? 5 : 6
    }()
    var dataSource: [Exercise?] = [nil]
    
    
    func countFetchLimit() -> Int {
        return Int(Device.Screen.Width / BLOCK_WIDTH)
    }
    
    func update() {
        let app = UIApplication.shared.delegate as! AppDelegate
        let managedObjectContext = app.persistentContainer.viewContext

        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Exercise")
//        let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()

        let sortDescriptor = NSSortDescriptor(key: "timeStamp", ascending: false)
        let sortDescriptors = [sortDescriptor]
        fetchRequest.sortDescriptors = sortDescriptors
        fetchRequest.fetchLimit = countFetchLimit()
        
        let result = try? managedObjectContext.fetch(fetchRequest) as! [Exercise]
        self.dataSource = result!
        self.setNeedsDisplay()
    }
    
    // MARK: - Draw

    override func draw(_ rect: CGRect) {
        var i  = CGFloat(self.bounds.size.width - ((self.bounds.size.width - Device.Screen.Width) / 2))
        for practice in dataSource {
            if let exercise = practice {
                // Draw Lines
                let context = UIGraphicsGetCurrentContext()
                
                // Meditation
                context!.setStrokeColor(Mood.color(of: exercise.mood).cgColor)
                context!.move(to: CGPoint(x: i, y: 6.0))
                context!.addLine(to: CGPoint(x: i - BLOCK_WIDTH, y: 6.0))
                context!.setLineWidth(BLOCK_HEIGHT_MOOD)
                context!.strokePath()
                
                // Date
                context!.setStrokeColor(UIColor.dayColor(date: exercise.timeStamp as! Date).cgColor)
                context!.move(to: CGPoint(x: i, y: 12.0))
                context!.addLine(to: CGPoint(x: i - BLOCK_WIDTH, y: 12.0))
                context!.setLineWidth(BLOCK_HEIGHT_DAY)
                context!.strokePath()
                
                i = i - BLOCK_WIDTH
            }
        }
    }
}
