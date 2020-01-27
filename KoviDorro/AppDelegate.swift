//
//  AppDelegate.swift
//  KoviDorro
//
//  Created by Влад Мади on 30.12.2019.
//  Copyright © 2019 Влад Мади. All rights reserved.
//

import UIKit
import RealmSwift

var userSettings = SettingsPomodoro()

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
                let schemaVersion: UInt64 = 4
        let config = Realm.Configuration(
            schemaVersion: schemaVersion,
            migrationBlock: { (migration, oldSchemaVersion) in
               if (oldSchemaVersion < schemaVersion) {
                }
        })
        Realm.Configuration.defaultConfiguration = config
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

/*
Импортируем Realm, создаём модели.
Создаём Realm-Менеджер
Заполняем таблицу на главном экране
Настраиваем кнопку "Сохранить" в Настройках и свайп вниз на КонтейнерВьюКонтроллере на запись настроек в Realm
 При старте приложения настройки должны подгружаться из Realm
 
Модель данных Settings:
    Короткое время
    Длинное время
    Время работы
 
Модель данных Задача:
    Тип задачи
    Заголовок
    Описание
    Выполнена или нет?
*/

