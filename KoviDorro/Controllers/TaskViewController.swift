//
//  TaskViewController.swift
//  KoviDorro
//
//  Created by Влад Мади on 21.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//

import UIKit
import RealmSwift

class TaskViewController: UIViewController {
    
    var currentTask: Task?

    @IBOutlet weak var taskNameLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var descriptionTextView: UITextView!
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var roundLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configVC()

    }
    
    func configVC() {
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
    
    @IBAction func enjoyAction(_ sender: UIButton) {
        
        try! realm.write {
            currentTask?.isEnjoy = true
        }
        
        self.dismiss(animated: true, completion: nil)
        
    }
    

}
