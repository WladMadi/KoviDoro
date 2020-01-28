//
//  HistoryTVC.swift
//  KoviDorro
//
//  Created by Влад Мади on 28.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//

import UIKit
import RealmSwift

class HistoryTVC: UITableViewController {

    var tasks: Results<Task>!
    var taskList = [Task]()
    let manager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tasks = realm.objects(Task.self)
        for task in tasks {
            if task.isEnjoy == true {
                taskList.append(task)
            }
        }
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return taskList.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HistoryCell")
        cell?.textLabel?.text = taskList[indexPath.row].name
        
        return cell!
    }


}
