//
//  SettingsViewController.swift
//  KoviDorro
//
//  Created by Влад Мади on 15.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//

import UIKit
import RealmSwift

protocol SettingsViewControllerDelegate {
    func hideSetting()
}

class SettingsViewController: UIViewController {
    
    var realmManager = RealmManager()
    
    var cycleTime: Int = 135
    var workTime: Int = 25
    var shortTime: Int = 5
    var longTime: Int = 20
    
    var settingsPomodorro: Results<SettingsPomodoro>!
    var delegate: SettingsViewControllerDelegate?
    
    @IBOutlet weak var cycleLabel: UILabel!
    @IBOutlet weak var workTimeLabel: UILabel!
    @IBOutlet weak var shortTimeLabel: UILabel!
    @IBOutlet weak var longTimeLabel: UILabel!
    
    @IBOutlet weak var workSlider: UISlider!
    @IBOutlet weak var shortSlider: UISlider!
    @IBOutlet weak var longSlider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        settingsPomodorro = realm.objects(SettingsPomodoro.self)
        
        getTimes()
        
    }
    

    
    @IBAction func workSliderAction(_ sender: Any) {
        setTimes()
    }
    
    @IBAction func shortSliderAction(_ sender: Any) {
        setTimes()
    }
    
    @IBAction func longSliderAction(_ sender: Any) {
        setTimes()
    }
    
    @IBAction func saveAction(_ sender: Any) {
        
        try! realm.write {
            
            settingsPomodorro[0].longTime = longTime
            settingsPomodorro[0].workTime = workTime
            settingsPomodorro[0].shortTime = shortTime
        }
        
        delegate?.hideSetting()
        
    }
    
    
    //Арифметика времён в настройках и отображение данных в Label'ах
    func setTimes() {
        workTime = Int(workSlider.value)
        shortTime = Int(shortSlider.value)
        longTime = Int(longSlider.value)
        
        cycleTime = workTime * 4 + shortTime * 3 + longTime
        
        workTimeLabel.text = String(workTime)
        shortTimeLabel.text = String(shortTime)
        longTimeLabel.text = String(longTime)
        cycleLabel.text = String("\(cycleTime) минут")
    }
    
    func getTimes() {
        workTime = settingsPomodorro[0].workTime
        longTime = settingsPomodorro[0].longTime
        shortTime = settingsPomodorro[0].shortTime
        
        cycleTime = workTime * 4 + shortTime * 3 + longTime
        
        workTimeLabel.text = String(workTime)
        shortTimeLabel.text = String(shortTime)
        longTimeLabel.text = String(longTime)
        cycleLabel.text = String("\(cycleTime) минут")
    }
}
