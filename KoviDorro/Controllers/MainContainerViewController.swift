//
//  MainContainerViewController.swift
//  KoviDorro
//
//  Created by Влад Мади on 15.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//

import UIKit

class MainContainerViewController: UIViewController, ViewControllerDelegate, MenuViewControllerDelegate, SettingsViewControllerDelegate {
    
//Создание экземпляров контроллеров, добавляемых в контейнер
    var controller: UIViewController!
    var menuController: UIViewController!
    var settingsController: UIViewController!
    
    //Переменные, хранящие статус контроллеров - открыт или закрыт
    var isMove: Bool = false
    var isSettingsMove: Bool = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Установка конфигураций главного контроллера и свайп-наблюдателя в Контейнер
        configureMainVC()
        swipeObserver()

        
    }
    
    //конфигурация главного контроллера
    func configureMainVC() {
        let mainVC = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! ViewController
        mainVC.delegate = self
        controller = mainVC
        view.addSubview(controller.view)
        addChild(controller)
    }
    
    
//конфигурация Меню-контроллера
    func configureMenuVC() {
        
        if menuController == nil {
            let menuVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "MenuVC") as! MenuViewController
            menuVC.delegate = self
            menuController = menuVC
            view.insertSubview(menuController.view, at: 0)
            addChild(menuController)
            print("MenuViewController has been added!")
            
        }
        
    }
    
    //конфигурация контроллера с настройками
    func configureSettingsVC() {
        
        if settingsController == nil {
            let setVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsVC") as! SettingsViewController
            setVC.delegate = self
            settingsController = setVC
            view.insertSubview(settingsController.view, at: 1)
            addChild(settingsController)
            print("SettingsViewController has been added!")
            
            
        }
        
        
        
    }
    
    //настройка анимации отображения и скрытия меню-контроллера
    func showMenuVC(shouldMove: Bool) {
        
        if shouldMove {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 0.6,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = self.controller.view.frame.width * 0.7
            }) { (finished) in
                print("Animation is Completed!")
            }
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.x = 0
            }) { (finished) in
                print("Animation is Completed!")
            }
        }
    }
    
    //настройка анимации отображения и скрытия контроллера с настройками
    func showSettingsVC(shouldMove: Bool) {
        
        if shouldMove {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.y = self.controller.view.frame.height * -0.7
            }) { (finished) in
                print("Animation is Completed!")
            }
        } else {
            UIView.animate(withDuration: 0.5,
                           delay: 0,
                           usingSpringWithDamping: 1,
                           initialSpringVelocity: 0,
                           options: .curveEaseInOut,
                           animations: {
                            self.controller.view.frame.origin.y = 0
            }) { (finished) in
                print("Animation is Completed!")
            }
        }
    }
    
    //метод отображения меню-контроллера
    func toggleMenu() {
        configureMenuVC()
        isMove = !isMove
        showMenuVC(shouldMove: isMove)
    }
    
    //метод отображения контроллера с настройками
    func toggleSettings() {
        configureSettingsVC()
        isSettingsMove = !isSettingsMove
        
        toggleMenu()
        
        //Задержка исполнения кода, указанного внутри блока
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.settingsController.view.isHidden = false
            self.showSettingsVC(shouldMove: self.isSettingsMove)
            
        }
        
    }

    //Наблюдатель за свайпами
    func swipeObserver() {
        let swipeDown = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipe))
        swipeDown.direction = .down
        self.view.addGestureRecognizer(swipeDown)
    }
    
    // Действие по свайпу
    @objc
    func handleSwipe(gesture: UISwipeGestureRecognizer) {
        guard let _ =  self.settingsController else {return}
        
        switch gesture.direction {
        case .down:
                UIView.animate(withDuration: 0.5,
                               delay: 0,
                               usingSpringWithDamping: 1,
                               initialSpringVelocity: 0,
                               options: .curveEaseInOut,
                               animations: {
                                self.controller.view.frame.origin.y = 0
                }) { (finished) in
                    print("Animation is Completed!")
                    self.settingsController.view.isHidden = true
                }
        
                isSettingsMove = !isSettingsMove
            
        default:
            break
        }
        
    }
    
    func hideSetting() {
                        UIView.animate(withDuration: 0.5,
                               delay: 0,
                               usingSpringWithDamping: 1,
                               initialSpringVelocity: 0,
                               options: .curveEaseInOut,
                               animations: {
                                self.controller.view.frame.origin.y = 0
                }) { (finished) in
                    print("Animation is Completed!")
                    self.settingsController.view.isHidden = true
                }
        
                isSettingsMove = false
    }
    
}
