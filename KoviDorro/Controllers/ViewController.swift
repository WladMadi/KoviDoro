//
//  ViewController.swift
//  KoviDorro
//
//  Created by Влад Мади on 30.12.2019.
//  Copyright © 2019 Влад Мади. All rights reserved.
//

import UIKit
import RealmSwift

protocol ViewControllerDelegate {
    func toggleMenu()
}

class ViewController: UIViewController {

    @IBOutlet weak var timeView: UIImageView!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var newTaskButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    var importantTasks = [Task]()
    
    var tasks: Results<Task>!
    
    let realmManager = RealmManager()
   
    var delegate: ViewControllerDelegate?  //Экземпляр делегата для общения с MainContainerVC
    
    //MARK: Методы жизненного цикла
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tasks = realm.objects(Task.self)
        //Конфигурирование КоллекшнВью
        collectionView.delegate = self
        collectionView.dataSource = self
        newTaskButton.layer.cornerRadius = 15
        newTaskButton.clipsToBounds = true
        setupGestures() //Установка жестов в контроллер
        tableViewConfig() //Установка конфигурации таблицы в контроллер
        
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        setSettings()
        print("LongTime = \(userSettings.longTime)")
        tableConfigure()
    
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableConfigure()
        tableView.reloadData()
    }
    
    //MARK: Методы Контроллера
    //Конфигурация таблицы
    func tableViewConfig() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.tableFooterView = UIView()
        self.tableView.backgroundColor = .clear
        self.tableView.register(UINib(nibName: "TaskSmallCell", bundle: nil), forCellReuseIdentifier: "TaskSmallCell")
    }
    
    //Кнопка Меню
    @IBAction func menuAction(_ sender: Any) {
        delegate?.toggleMenu()
    }
    
    //Конфигурация жестов
    private func setupGestures() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapped))
        tapGesture.numberOfTapsRequired = 1
        newTaskButton.addGestureRecognizer(tapGesture)
    }
    
    //Конфигурация селектора на жест tapGesture
    @objc
    private func tapped() {
        //Конфигурирование popoverVC
        guard let popVC = storyboard!.instantiateViewController(identifier: "popVC") as? NewTaskPopoverViewController else { return }
        popVC.delegate = self
        popVC.modalPresentationStyle = .popover
        let popoverVC = popVC.popoverPresentationController
        popoverVC?.delegate = self
        popoverVC?.sourceView = self.newTaskButton
        popoverVC?.sourceRect = CGRect(x: self.newTaskButton.bounds.midX, y: self.newTaskButton.bounds.minY, width: 0, height: 0)
        popVC.preferredContentSize = CGSize(width: 400, height: 450)
        self.present(popVC, animated: true, completion: nil)
    }
    
    func setSettings() {
        if let pomSet = realm.objects(SettingsPomodoro.self).last {
            userSettings = pomSet
        } else {
            userSettings = SettingsPomodoro()
            realmManager.addToDB(object: userSettings)
        }
    }
    
    //MARK: Конфигурация отображения данных в таблице
    
    func tableConfigure() {
        importantTasks = [Task]()
        for task in tasks {
            if task.type == "YesYes"{
                self.importantTasks.append(task)
            }
        }
        for task in tasks {
            if task.type == "YesNo" {
                self.importantTasks.append(task)
            }
        }
    }
    
    
    //Подготовка переходов
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "ToTaskListViewController" {
            let indexPath = collectionView.indexPathsForSelectedItems
            let destVC = segue.destination as! TaskListViewController
            
            switch (indexPath?[0].item)! {
            case 0:
                 destVC.listType = .yesYes
            case 1:
                 destVC.listType = .yesNo
            case 2:
                 destVC.listType = .noYes
            case 3:
                 destVC.listType = .noNo
            default:
                print("Fatal error")
            }
        }
        
        if segue.identifier == "FromMainToTaskVC" {
            let indexPath = tableView.indexPathForSelectedRow
            let destVC = segue.destination as! TaskViewController
            destVC.currentTask = importantTasks[indexPath!.row]
        }
    }
}


//MARK: Методы протоколов CollectionView
extension ViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "MainCell", for: indexPath) as! MainCell
        
        switch indexPath.item {
        case 0:
            cell.imageView.image = UIImage(named: "YesYes")
        case 1:
                cell.imageView.image = UIImage(named: "YesNo")
        case 2:
                cell.imageView.image = UIImage(named: "NoYes")
        case 3:
                cell.imageView.image = UIImage(named: "NoNo")
        default:
            print("Fatal Error!")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.size.width / 2 - 10, height: collectionView.frame.size.height / 2 - 10)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "ToTaskListViewController", sender: nil)
    }
    
}

//MARK: Методы протоколов PopoverVC
extension ViewController: UIPopoverPresentationControllerDelegate {
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}


//MARK: Методы протоколов TableView
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return importantTasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TaskSmallCell") as! TaskSmallCell
        cell.label.text = importantTasks[indexPath.row].name
        if importantTasks[indexPath.row].type == "YesYes" {
            cell.taskImageView.image = #imageLiteral(resourceName: "YesYes")
        } else {
            cell.taskImageView.image = #imageLiteral(resourceName: "YesNo")
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "FromMainToTaskVC", sender: nil)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        
        //Кнопка, которая удаляет ячейку и данные из базы
        let deleteAction = UIContextualAction(style: .destructive, title: "Удалить") { (_, _, completion) in
            
            
            self.realmManager.removeFromDB(object: self.importantTasks[indexPath.row])
            self.importantTasks.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            
            completion(true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
        
    }
    
    func tableView(_ tableView: UITableView, leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let enjoyAction = UIContextualAction(style: .normal, title: "Выполнена") { (_, _, completion) in
            try! realm.write {
                self.importantTasks[indexPath.row].isEnjoy = true
            }
            completion(true)
        }
        return UISwipeActionsConfiguration(actions: [enjoyAction])
    }
    
}


extension ViewController: NewTaskPopoverViewControllerDelegate {
    
    func updateTableView()  {
        self.tableConfigure()
        self.tableView.reloadData()
        print("TableView data reloaded!")
    }

}


