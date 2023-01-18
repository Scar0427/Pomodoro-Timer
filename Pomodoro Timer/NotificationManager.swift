//
//  NotificationManager.swift
//  Pomodoro Timer
//
//  Created by Owen Daniel Fernandez Chacon on 18/01/23.
//

import Foundation
import UserNotifications

//Esta aplicacion solo puede agendar una notificacion a la vez, por tanto, un solo ID fijo es suficiente
let notificationFixedID = "pomoTimerNotification00"

class NotificationsManager{
    
    
    func requestAutorization(){
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]){_, _ in  }
    }
    
    func addNextTimerNotification(timeToNextNotificationInSeconds: Int, esDescanso: Bool){
        let notificationContent = UNMutableNotificationContent()
        notificationContent.title = "TIEMPO!!!"
        notificationContent.body = esDescanso ? "Tomate \(timeToNextNotificationInSeconds) libres" : "Vuelve a concentrarte en este momento"
        notificationContent.sound = .defaultCritical
        
        var timeTrigger = UNTimeIntervalNotificationTrigger(timeInterval: Double(timeToNextNotificationInSeconds * 60), repeats: false)
        
        let request = UNNotificationRequest(identifier: notificationFixedID, content: notificationContent, trigger: timeTrigger)
        
        let notificationCenter = UNUserNotificationCenter.current()
        notificationCenter.add(request){error in
            if error != nil{
                print("Error al agendar la notificacion")
            }
        }
    }
    
    func deleteNotification(){
        let center = UNUserNotificationCenter.current()
        center.removePendingNotificationRequests(withIdentifiers: [notificationFixedID])
    }
}
