//
//  SettingsViewController.swift
//  pranatice
//
//  Copyright © 2016 Jin
//
//  This software is released under the MIT License.
//  http://opensource.org/licenses/mit-license.php
//


import UIKit
import CoreData

class SettingsViewController: UITableViewController {
    
    
    @IBOutlet weak var kapalbhatiCountSlider: UISlider!
    @IBOutlet weak var kapalbhatiRoundSlider: UISlider!
    @IBOutlet weak var kunbhakaSecondSlider: UISlider!
    @IBOutlet weak var kunbhakaButton: UIButton!
    
    @IBOutlet weak var anulomVilomSecondsSlider: UISlider!
    @IBOutlet weak var anulomVilomRoundSlider: UISlider!
    @IBOutlet weak var suryaBhedanaSecondSlider: UISlider!
    @IBOutlet weak var suryaBhedanaRoundSlider: UISlider!
    @IBOutlet weak var chandraBhedanaSecondSlider: UISlider!
    @IBOutlet weak var chandraBhedanaRoundSlider: UISlider!
    
    @IBOutlet weak var switchCallInEnglish: UISwitch!
    @IBOutlet weak var volumeSlider: UISlider!
    @IBOutlet weak var speedSlider: UISlider!

    @IBOutlet weak var exportHealthSwitch: UISwitch!
    @IBOutlet weak var exportCalenderSwitch: UISwitch!
    
    var doKunbhaka: Bool = false {
        didSet {
            //  switch on off image
            let image = doKunbhaka ? UIImage(named: "CheckboxChecked") : UIImage(named: "CheckboxUnchecked")
            kunbhakaButton.setImage(image, for: .normal)
        }
    }
    
    
    // MARK: - IBActions
    
    @IBAction func sliderSettings(_ sender: UISlider) {
        let sliderValue = Int(sender.value)

        guard let identifier = sender.accessibilityIdentifier else { return }
        switch identifier {
        case Identifier.kapalbhati:
            if sender.tag == 0 {
                // counts
                UserSettings.kapalbhatiCounts =  Int(sliderValue)
            } else if sender.tag == 1 {
                // round
                UserSettings.kapalbhatiRounds = Int(sliderValue)
            } else {
                // tag = 2, Kunbhaka seconds
                UserSettings.kunbhakaSeconds = Int(sliderValue)
            }
        case Identifier.anulomvilom:
            if sender.tag == 0 {
                // counts
                UserSettings.anulomvilomSeconds = Int(sliderValue)
            } else {
                // round
                UserSettings.anulomvilomRounds = Int(sliderValue)
            }
        case Identifier.suryabhedana:
            if sender.tag == 0 {
                // counts
                UserSettings.suryabhedanaSeconds = Int(sliderValue)
            } else {
                // round
                UserSettings.suryabhedanaRounds = Int(sliderValue)
            }
        case Identifier.chandrabhedana:
            if sender.tag == 0 {
                // counts
                UserSettings.chandrabhedanaSeconds = Int(sliderValue)
            } else {
                // round
                UserSettings.chandrabhedanaRounds = Int(sliderValue)
            }
        default:
            break
        }
        
        // reWrite Section Header
        reWriteSctionHeader(with: identifier)
    }
    
    @IBAction func toggleHold(_ sender: UIButton) {
        doKunbhaka = !doKunbhaka
        UserSettings.doKunbhaka = doKunbhaka
        if doKunbhaka {
            UserSettings.kunbhakaSeconds = Int(kunbhakaSecondSlider.value)
        }
    }
    
    @IBAction func swithSettings(_ sender: UISwitch) {
        switch sender.tag {
        case 0:
            // Call in Enclish
            UserSettings.callInEnglish = sender.isOn
        case 1:
            // Export Calender
            UserSettings.exportCalender = sender.isOn
        case 2:
            // Export Health
            UserSettings.exportHealth = sender.isOn
        default: break
        }
        
    }
    
    @IBAction func callSettings(_ sender: UISlider) {
        switch sender.tag {
        case 0:
            // volume
            UserSettings.volume = sender.value
        case 1:
            // speed
            UserSettings.speed = sender.value
        default:
            break
        }
    }

    // MARK: - Section Headers
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60.0
    }

    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return String.reWriteLabel(with: Identifier.title(from: section))
    }
    
    func reWriteSctionHeader(with identifier: String) {
        tableView.headerView(forSection: Identifier.section(from: identifier))?.textLabel?.text = String.reWriteLabel(with: identifier)
    }
    
    // MARK: - View Lifecycles
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = NSLocalizedString("settings.title", comment: "")
    }

    override func viewWillAppear(_ animated: Bool) {
        // set sliders
        kapalbhatiCountSlider.setValue(Float(UserSettings.kapalbhatiCounts), animated: false)
        kapalbhatiRoundSlider.setValue(Float(UserSettings.kapalbhatiRounds), animated: false)
        doKunbhaka = UserSettings.doKunbhaka
        kunbhakaSecondSlider.setValue(Float(UserSettings.kunbhakaSeconds), animated: false)
        anulomVilomSecondsSlider.setValue(Float(UserSettings.anulomvilomSeconds), animated: false)
        anulomVilomRoundSlider.setValue(Float(UserSettings.anulomvilomRounds), animated: false)
        suryaBhedanaSecondSlider.setValue(Float(UserSettings.suryabhedanaSeconds), animated: false)
        suryaBhedanaRoundSlider.setValue(Float(UserSettings.suryabhedanaRounds), animated: false)
        chandraBhedanaSecondSlider.setValue(Float(UserSettings.chandrabhedanaSeconds), animated: false)
        chandraBhedanaRoundSlider.setValue(Float(UserSettings.chandrabhedanaRounds), animated: false)

        // Call
        switchCallInEnglish.isOn = UserSettings.callInEnglish
        volumeSlider.setValue(UserSettings.volume, animated: false)
        speedSlider.setValue(UserSettings.speed, animated: false)

        // set switches
        exportCalenderSwitch.isOn = UserSettings.exportCalender
        exportHealthSwitch.isOn = UserSettings.exportHealth
    }
    
}
