//
//  TaskViewController.swift
//  KoviDorro
//
//  Created by Влад Мади on 21.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//

import UIKit
import RealmSwift

let timesArray: [NotificationType] = [ .workTime, .shortTime, .workTime, .shortTime, .workTime, .shortTime, .workTime, .longTime]
var currentTimeType = 0

class TaskViewController: UIViewController {
    
    var currentTask: Task?

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var timerLabel: UILabel!
    var time = 10
    var timer: Timer?
    var notifications = Notifications()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()

    }
    
    func configVC() {
        
        switch timesArray[currentTimeType] {
        case .longTime:
            time = userSettings.longTime
        case .workTime:
            time = userSettings.workTime
        case .shortTime:
            time = userSettings.shortTime
        }
        time *= 60
        timerLabel.text = "\(time / 60) : \(time % 60)"
        
        taskNameLabel.text = currentTask?.name
        switch currentTask?.type {
        case "YesYes":
            iconImageView.image = #imageLiteral(resourceName: "YesYes")
        case "YesNo":
            iconImageView.image = #imageLiteral(resourceName: "YesNo")
        case "NoYes":
            iconImageView.image = #imageLiteral(resourceName: "NoYes")
        case "NoNo":
            iconImageView.image = #imageLiteral(resourceName: "NoNo")
        default:
            print ("Error")
        }
        
        descriptionTextView.text = currentTask?.descript
        
    }
    
    
    
    @IBAction func quitAction(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func startAction(_ sender: UIButton) {
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(timerFunc), userInfo: nil, repeats: true)
        
        
    }
    
    @objc func timerFunc(timer: Timer) {
        
        guard time > 0 else {
            timer.invalidate()
            self.notifications.scheduleNotification(type: timesArray[currentTimeType])
            if currentTimeType < 7 {
                currentTimeType += 1
            } else {
                currentTimeType = 0
            }
            configVC()
            return
        }
        
        time -= 1
        timerLabel.text = "\(time / 60) : \(time % 60)"
        
        var backgroungTask = UIApplication.shared.beginBackgroundTask()
        if backgroungTask != UIBackgroundTaskIdentifier.invalid {
            print("Time: \(time)")
            if UIApplication.shared.applicationState == .active {
                UIApplication.shared.endBackgroundTask(backgroungTask)
                backgroungTask = UIBackgroundTaskIdentifier.invalid
                print("IF-2")
            }
        } else {
            print("Time: \(time)")
            guard time > 0 else { return }
            timerLabel.text = "\(time / 60) : \(time % 60)"
        }
        
    }
    
    @IBAction func enjoyAction(_ sender: UIButton) {
        
        try! realm.write {
            currentTask?.isEnjoy = true
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
