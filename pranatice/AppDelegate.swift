//
//  AppDelegate.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//


import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // Load UserDefault InitialValues
        UserDefaults.standard.register(defaults: [
            Key.Settings.kapalbhatiCounts       : 60,
            Key.Settings.kapalbhatiRounds       : 5,
            Key.Settings.anulomvilomSeconds     : 4,
            Key.Settings.anulomvilomRounds      : 5,
            Key.Settings.suryabhedanaSeconds    : 4,
            Key.Settings.suryabhedanaRounds     : 6,
            Key.Settings.chandrabhedanaSeconds  : 4,
            Key.Settings.chandrabhedanaRounds   : 6,
            Key.Settings.ShowStatus     : true,
            Key.Settings.volume         : 0.85,
            Key.Settings.speed          : 0.54,
            Key.Settings.memoIndicator  : "✿",
            Key.Settings.calenderTitle  : NSLocalizedString("calender.title.string", comment: ""),
            Key.Settings.AppClosedDate  : Date()
            ])
        
        return true
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        UserSettings.applicationClosedDate = Date()
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
         let container = NSPersistentContainer(name: "pranatice")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                print("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                print("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

