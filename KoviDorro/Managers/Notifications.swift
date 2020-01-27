//
//  Notifications.swift
//  KoviDorro
//
//  Created by Влад Мади on 27.01.2020.
//  Copyright © 2020 Влад Мади. All rights reserved.
//

import Foundation
import UserNotifications

class Notifications: NSObject, UNUserNotificationCenterDelegate {
    
    let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]) { (granted, error) in
            print("PermissionGranted: \(granted)")
            
            guard granted else { return }
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print("NotificationSettings: \(settings)")
        }
    }
    
    func scheduleNotification(type: NotificationType) {
        let content = UNMutableNotificationContent()
//        var timeInterval = 0
        let userAction = "CategoryID"
        
        switch type {
        case .longTime:
            content.title = "Пора поработать"
            content.body = "Поработайте \(userSettings.workTime) минут"
        case .shortTime:
            content.title = "Пора поработать"
            content.body = "Поработайте \(userSettings.workTime) минут"
        case .workTime:
            if currentTimeType == 6 {
                content.title = "Пора сделать длинный перерыв"
                content.body = "Отдохните \(userSettings.longTime) минут"
            } else {
                content.title = "Пора сделать короткий перерыв"
                content.body = "Отдохните \(userSettings.shortTime) минут"
            }
        }
        
        content.sound = UNNotificationSound.default
        content.badge = 1
        content.categoryIdentifier = userAction

        guard let path = Bundle.main.path(forResource: "favicon", ofType: "png") else { return }
        let url = URL(fileURLWithPath: path)
        
        do {
            let attachment = try UNNotificationAttachment(identifier: "favicon",
                                                          url: url,
                                                          options: nil)
            content.attachments = [attachment]
        } catch  {
            print("Нипалучилося привязать картинку(((((")
        }
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
        let identifier = "localNotify"
        
        let request  = UNNotificationRequest(identifier: identifier,
                                             content: content,
                                             trigger: trigger)
        
        notificationCenter.add(request) { (error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
            }
        }
        
        let cancelAction = UNNotificationAction(identifier: "Cancel", title: "ОК", options: .destructive)
        
        let category = UNNotificationCategory(identifier: userAction, actions: [cancelAction], intentIdentifiers: [], options: [])
        
        notificationCenter.setNotificationCategories([category])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        if response.notification.request.identifier == "localNotify" {
            print("Локальное уведомление получено")
        }
        
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss")
        case UNNotificationDefaultActionIdentifier:
            print("Default")
        case "Cancel":
            print("Нажата ОК")
        default:
            print("unknown action")
        }
        
        completionHandler()
        
    }
    
    
    
    
}
