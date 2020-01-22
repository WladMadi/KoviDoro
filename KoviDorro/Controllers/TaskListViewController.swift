//
//  TaskListViewController.swift
//  KoviDorro
//
//  Created by Влад Мади on 21.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//
import RealmSwift
import UIKit

class TaskListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var listType: TaskList = .yesYes
    var tasks: Results<Task>!
    var taskList = [Task]()
    var typeImage = UIImage()
    @IBOutlet weak var tasksTypeLabel: UILabel!
    let manager = RealmManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        tasks = realm.objects(Task.self)
        configureVC()
    }
    
    func configureVC() {
        
        switch listType {
        case .yesYes:
            tasksTypeLabel.text = "Важно Срочно"
            typeImage = #imageLiteral(resourceName: "YesYes")
            for task in tasks {
                if task.type == "YesYes"{
                    taskList.append(task)
                }
            }
        case .noNo:
            typeImage = #imageLiteral(resourceName: "NoNo")
            tasksTypeLabel.text = "Неважно Несрочно"
            for task in tasks {
                if task.type == "NoNo"{
                    taskList.append(task)
                }
            }
        case .noYes:
            typeImage = #imageLiteral(resourceName: "YesNo")
            tasksTypeLabel.text = "Неважно Срочно"
            for task in tasks {
                if task.type == "NoYes"{
                    taskList.append(task)
                }
            }
        case .yesNo:
            typeImage = #imageLiteral(resourceName: "NoYes")
            tasksTypeLabel.text = "Важно Несрочно"
            for task in tasks {
                if task.type == "YesNo"{
                    taskList.append(task)
                }
            }
        }
    }
    
    @IBAction func toMainVC(_ sender: Any) {
        
        self.dismiss(animated: true, completion: nil)
//        let vc = MainContainerViewController()
//        vc.modalPresentationStyle = .fullScreen
//        self.present(vc, animated: true, completion: nil)

    }
    

    

}


extension TaskListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskBigCell") as! TaskBigCell
        cell.taskNameLabel.text = taskList[indexPath.row].name
        cell.typeImageView.image = typeImage
        cell.descriptionTextView.text = taskList[indexPath.row].descript
        cell.frame.size.height = 203
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 203
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //Кнопка, которая удаляет ячейку и данные из базы
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, completion) in
            
            
            self.manager.removeFromDB(object: self.taskList[indexPath.row])
            self.taskList.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
}
