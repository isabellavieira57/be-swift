//
//  LocalNotificationCenter.swift
//
//  Created by Matheus Falcão on 14/07/16.
//  Copyright © 2017 Matheus Falcão.
//

import UIKit
import UserNotifications


class LocalNotificationCenter {
    
    
    // Create Local Notification
    static func localNotification(_ title : String, body : String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = body
        
        // Notificacao setada de 5 em 5 min
        let trigger = UNTimeIntervalNotificationTrigger.init(timeInterval: 15000.0, repeats: true)
        let request = UNNotificationRequest.init(identifier: "FiveSecond", content: content, trigger: trigger)
        
        // Schedule the notification.
        let center = UNUserNotificationCenter.current()
        center.add(request)
    }
    
    // Stop All Local Notifications
    static func stopAllLocalNotifications() {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests()
    }
}
