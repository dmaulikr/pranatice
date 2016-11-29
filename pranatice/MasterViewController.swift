//
//  MasterViewController.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//


import UIKit
import CoreData
import AVFoundation

class MasterViewController: UIViewController {

    var managedObjectContext: NSManagedObjectContext? = nil
    var practice: Pranayama!

    @IBOutlet weak var backgroundView: UIView!
    @IBOutlet weak var practiceLabelView: UIView!
    @IBOutlet weak var menuView: UIView!
    @IBOutlet weak var moodView: UIView!
    
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var practiceLabel: UILabel!
    @IBOutlet weak var moodTitleLabel: UILabel!
    
    @IBOutlet weak var kapalbhatiButton: UIButton!
    @IBOutlet weak var anulomvilomButton: UIButton!
    @IBOutlet weak var suryabhedanaButton: UIButton!
    @IBOutlet weak var chandrabhedanaButton: UIButton!
    
    @IBOutlet weak var sunStatusView: SunStatusView!
    @IBOutlet weak var historyBarView: HistoryBarView!
    
    @IBOutlet weak var memoField: UITextField!
    
    
    // MARK: - refresh
    
    func refreshButtons(){
        kapalbhatiButton.setTitle(String.reWriteLabel(with: Identifier.kapalbhati), for: .normal)
        anulomvilomButton.setTitle(String.reWriteLabel(with: Identifier.anulomvilom), for: .normal)
        suryabhedanaButton.setTitle(String.reWriteLabel(with: Identifier.suryabhedana), for: .normal)
        chandrabhedanaButton.setTitle(String.reWriteLabel(with: Identifier.chandrabhedana), for: .normal)
    }
    
    func refreshForNewSession() {
        // views
        practiceLabelView.isHidden = true
        menuView.isHidden = false
        moodView.isHidden = true
        
        refreshButtons()
        refreshCounter()
        historyBarView.update()
        sunStatusView.update()
    }
    
    func refreshDate() {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.full
        dateLabel.text = formatter.string(from: Date())
        backgroundView.backgroundColor = UIColor.todayColor()
    }
    
    func refreshCounter() { // Need to rename
        let fetchRequest: NSFetchRequest<Exercise> = Exercise.fetchRequest()
        do {
            let count = try managedObjectContext!.count(for: fetchRequest)
            counterLabel.text = "\(count)"
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }
    }

    // MARK: - Alert View
    
    func alertToStart(with label: String) {
        // Set Up Start Alert
        let startMessage = String(format: NSLocalizedString("main.start-alert.message", comment: ""), NSLocalizedString(label, comment: ""))
        
        let startAlert = UIAlertController(title: startMessage,
                                           message: "",
                                           preferredStyle: .alert)
        
        let startAction = UIAlertAction(title: NSLocalizedString("main.start-alert.button.start", comment: ""),
                                        style: .default,
                                        handler: {
                                            alert in
                                            self.startPractice(with: label)
        })
        let cancelAction = UIAlertAction(title: NSLocalizedString("main.start-alert.button.cancel", comment: ""),
                                         style: .cancel,
                                         handler: nil)
        startAlert.addAction(startAction)
        startAlert.addAction(cancelAction)
        
        present(startAlert, animated: true, completion: nil)
    }
    
    func alertToCancelPranayama() {
        let alert = UIAlertController(title: NSLocalizedString("main.cancel-alertview.title", comment: ""),
                                      message: NSLocalizedString("main.cancel-alertview.message", comment: ""),
                                      preferredStyle: UIAlertControllerStyle.alert)
        
        let continueAction = UIAlertAction(title: NSLocalizedString("main.cancel-alertview.button.no", comment: ""),
                                           style: .default,
                                           handler: { action in
                                            // Continue
        })
        let stopAction = UIAlertAction(title: NSLocalizedString("main.cancel-alertview.button.yes", comment: ""),
                                       style: .cancel,
                                       handler: { action in
                                        // cancel
                                        self.practice.cancel()
                                        self.refreshForNewSession()
        })
        alert.addAction(stopAction)
        alert.addAction(continueAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    // MARK: - Handle Taps and Touches

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if !practiceLabelView.isHidden {
            alertToCancelPranayama()
        }
    }


    @IBAction func call(_ sender: AnyObject) {
        let button = sender as! UIButton
        guard let label = button.accessibilityIdentifier else { return }
    
        switch label {
        case Identifier.kapalbhati:
            practice = Kapalbhati(UserSettings.kapalbhatiCounts,
                                  with: UserSettings.kapalbhatiRounds,
                                  doKumbhaka: UserSettings.doKunbhaka)
        case "anulomvilom":
            practice = Anulomvilom(UserSettings.anulomvilomSeconds,
                                   with: UserSettings.anulomvilomRounds)
        case "suryabhedana":
            practice = SuryaBhedana(UserSettings.suryabhedanaSeconds,
                                    with: UserSettings.suryabhedanaRounds)
        case "chandrabhedana":
            practice = ChandraBhedana(UserSettings.chandrabhedanaSeconds,
                                      with: UserSettings.chandrabhedanaRounds)
        default: break
        }
    
        alertToStart(with: label)
    }
    
    func startPractice(with label: String) {
        practice.delegate = self
        practice.startPractice()
        
        // views
        practiceLabel.text = label
        practiceLabelView.isHidden = false
        menuView.isHidden = true
        moodView.isHidden = true
    }
    
    @IBAction func moodButtonPressed(_ sender: AnyObject) {
        guard let mood = sender.tag else { return }
        saveSession(with: mood)
        memoField.resignFirstResponder()
        // refresh status
        refreshForNewSession()
    }
    
    // MARK: - Models
    
    func saveSession(with mood: Int) {
        let newExercise = Exercise(context: managedObjectContext!)
       
        newExercise.pranayamaType = Identifier.type(from: practice.type)
        newExercise.pranayamaBaseCounts = Int16(practice.settingSeconds)
        newExercise.pranayamaRounds = Int16(practice.settingRounds)
        
        // Kunbhaka
        if practice.type == Identifier.kapalbhati {
            if UserSettings.doKunbhaka {
                newExercise.practiceKumbhaka = UserSettings.doKunbhaka
                newExercise.pranayamaHold = Int16(UserSettings.kunbhakaSeconds)
            }
        }
        
        newExercise.timeStamp = practice.startTime as NSDate?
        newExercise.timeStampAt = TimeZone.current
        newExercise.practiceFor = practice.length
        newExercise.mood = Int16(mood)
        if let memo = memoField.text {
            newExercise.memo = memo
        }
      
        // Save the context.
        do {
            try managedObjectContext!.save()
        } catch let error as NSError {
            print("Unresolved error \(error), \(error.userInfo)")
        }

        // Export to calender or Health
        if UserSettings.exportCalender {
            writeOutToCalender(with: newExercise)
        }
        if UserSettings.exportHealth {
            writeOutToHealth(with: newExercise)
        }
    }
    
    // MARK: - View Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        self.managedObjectContext = appDelegate.persistentContainer.viewContext
        
        moodTitleLabel.text = NSLocalizedString("main.mood_view.message", comment: "")
        if Device.isiPhone5() {
            memoField.autocorrectionType = .no
        }
        // Notification
        let app = UIApplication.shared
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(applicationWillEnterForeground(_:)),
                                               name: NSNotification.Name.UIApplicationWillEnterForeground,
                                               object: app)
        refreshDate()
        refreshCounter()
        historyBarView.update()
        sunStatusView.update()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        refreshButtons()
    }

    func applicationWillEnterForeground(_ notification: NSNotification) {
        if Date.hasChanged(since: UserSettings.applicationClosedDate) {
            refreshDate()
        }
    }
    
    // MARK: - unWind from ViewControllers
    
    @IBAction func unwindFromHistory(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
    }
    
    @IBAction func unwindFromSettings(unwindSegue: UIStoryboardSegue, towardsViewController subsequentVC: UIViewController) {
        refreshButtons()
    }

}

extension MasterViewController: PranayamaDelegate {
    
    func pranayamaDidFinish(pranayama: Pranayama) {
        // show mood picker view
        practiceLabelView.isHidden = true
        menuView.isHidden = true
        moodView.isHidden = false
    }

}

