//
//  MasterViewController+Export.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//


import UIKit
import EventKit
import HealthKit

extension MasterViewController {

    // MARK: - For Health
    
    func writeOutToHealth(with pranayama: Exercise){
        if HKHealthStore.isHealthDataAvailable() {
            let healthStore = HKHealthStore()
            let categoryType = HKObjectType.categoryType(forIdentifier: .mindfulSession)
            let authStatus = healthStore.authorizationStatus(for: categoryType!)
            switch authStatus {
            case .sharingDenied: break
            case .sharingAuthorized:
                saveHealthData(with: pranayama)
            case .notDetermined:
                let writeDataTypes: Set<HKSampleType> = Set([ categoryType! ])
                healthStore.requestAuthorization(toShare: writeDataTypes, read: nil, completion: {
                    (success, error) in
                    if success {
                        // wantToWriteOutToHelathKit = YES
                        self.saveHealthData(with: pranayama)
                    }
                }
                )
            }
        }
    }
    
    func saveHealthData(with pranayama: Exercise) {
        let healthStore = HKHealthStore()
        let categoryType = HKObjectType.categoryType(forIdentifier: .mindfulSession)
        let exerciseData = HKCategorySample(type: categoryType!,
                                            value: HKCategoryValue.notApplicable.rawValue,
                                            start: pranayama.timeStamp! as Date,
                                            end: pranayama.timeStamp!.addingTimeInterval(pranayama.practiceFor) as Date)
        healthStore.save(exerciseData, withCompletion: {
            (success, error) in
            if success {
                pranayama.isExportedHealth = true
                do {
                    try pranayama.managedObjectContext?.save()
                } catch let error as NSError {
                    print("Unresolved error \(error), \(error.userInfo)")
                }
            } else {
                print("An error occured. The error was: \(error?.localizedDescription)")
            }
        })
    }

    // MARK: - For Calender
    
    func writeOutToCalender(with pranayama: Exercise){
            let eventStore = EKEventStore()
            let authStatus = EKEventStore.authorizationStatus(for: .event)
            switch authStatus {
            case .authorized:
                createEvent(with: pranayama)
            case .notDetermined:
                eventStore.requestAccess(to: .event,
                                         completion: {
                                            finished in
                                            self.createEvent(with: pranayama)
                                            }
                                        )
            case .denied, .restricted:
                break
            }
    }
    
    func createEvent(with pranayama: Exercise){
        let eventStore = EKEventStore()
        let event = EKEvent(eventStore: eventStore)
        var calendar:EKCalendar?
        let cals = eventStore.calendars(for: .event)
        for cal in cals {
            if (cal.title == UserSettings.calenderTitle) {
                calendar = cal
            }
        }
        if (calendar == nil) {
            let newList = EKCalendar(for: .event, eventStore: eventStore)
            // Find the proper source type value.
            for  i in 0 ..< eventStore.sources.count {
                let source = eventStore.sources[i]
                let currentSourceType = source.sourceType
                
                switch currentSourceType {
                case .calDAV, .local:
                    newList.source = source
                default: break
                }
            }
            newList.title = UserSettings.calenderTitle
            do {
                try eventStore.saveCalendar(newList, commit: true)
            } catch let error as NSError {
                print("Unresolved error \(error), \(error.userInfo)")
            }
            calendar = newList
        }
        
        // make title strings        
        event.calendar = calendar!
        event.title = pranayama.title()
        //    event.location = "Tokyo, Japan."  // NSTimeZone
        event.timeZone = NSTimeZone.default
        event.startDate = pranayama.timeStamp! as Date
        event.endDate = pranayama.timeStamp!.addingTimeInterval(pranayama.practiceFor) as Date
        //    event.notes = ""
        do {
            try eventStore.save(event, span: .thisEvent)
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }
    
    
}


