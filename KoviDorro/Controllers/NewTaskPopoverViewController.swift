//
//  NewTaskPopoverViewController.swift
//  KoviDorro
//
//  Created by Влад Мади on 13.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//

import UIKit
import RealmSwift

protocol NewTaskPopoverViewControllerDelegate {
    func updateTableView() 
}

class NewTaskPopoverViewController: UIViewController {
    
    @IBOutlet weak var titleLabel: UITextField!
    @IBOutlet weak var descriptionTF: UITextView!
    @IBOutlet weak var importantSwitch: UISwitch!
    @IBOutlet weak var urgentlySwitсh: UISwitch!
    let manager = RealmManager()
    var tasks: Results<Task>!
    
    var delegate: NewTaskPopoverViewControllerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = #colorLiteral(red: 0.597692536, green: 0.6235294342, blue: 0.1621292097, alpha: 1)
        descriptionTF.backgroundColor = .white
        descriptionTF.textColor = .black
        

        tasks = realm.objects(Task.self)
    }
    
    @IBAction func cancelAction(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func saveAction(_ sender: Any) {
        let newTask = Task()
        guard let taskName = titleLabel.text, let descript = descriptionTF.text else {
            return
        }
        newTask.name = taskName
        newTask.descript = descript

        var taskType = ""
        
        if importantSwitch.isOn && urgentlySwitсh.isOn {
            taskType = "YesYes"
        } else if importantSwitch.isOn && !urgentlySwitсh.isOn {
            taskType = "YesNo"
        } else if !importantSwitch.isOn && urgentlySwitсh.isOn {
            taskType = "NoYes"
        } else {
            taskType = "NoNo"
        }

        newTask.type = taskType
        

        newTask.id = (tasks.last?.id ?? 0) + 1
        manager.addToDB(object: newTask)
        
        delegate?.updateTableView()
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func importantAction(_ sender: UISwitch) {
        
        if importantSwitch.isOn && urgentlySwitсh.isOn {
            self.view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else if importantSwitch.isOn && !urgentlySwitсh.isOn {
            self.view.backgroundColor = #colorLiteral(red: 0.597692536, green: 0.6235294342, blue: 0.1621292097, alpha: 1)
        } else if !importantSwitch.isOn && urgentlySwitсh.isOn {
            self.view.backgroundColor = #colorLiteral(red: 0.6235294342, green: 0.4811941591, blue: 0.2109272593, alpha: 1)
        } else {
            self.view.backgroundColor = #colorLiteral(red: 0.6235294342, green: 0.3295812328, blue: 0.2451222044, alpha: 1)
        }
        
    }
    
    @IBAction func urgentlyAction(_ sender: UISwitch) {
        
        if importantSwitch.isOn && urgentlySwitсh.isOn {
            self.view.backgroundColor = #colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1)
        } else if importantSwitch.isOn && !urgentlySwitсh.isOn {
            self.view.backgroundColor = #colorLiteral(red: 0.597692536, green: 0.6235294342, blue: 0.1621292097, alpha: 1)
        } else if !importantSwitch.isOn && urgentlySwitсh.isOn {
            self.view.backgroundColor = #colorLiteral(red: 0.6235294342, green: 0.4811941591, blue: 0.2109272593, alpha: 1)
        } else {
            self.view.backgroundColor = #colorLiteral(red: 0.6235294342, green: 0.3295812328, blue: 0.2451222044, alpha: 1)
        }
    }
    
}
