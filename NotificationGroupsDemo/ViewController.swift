//
//  ViewController.swift
//  NotificationGroupsDemo
//
//  Created by Jesus Guerra on 8/26/18.
//  Copyright © 2018 Jesus Guerra. All rights reserved.
//

import UIKit
import UserNotifications

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Ask for Notification Permissions
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.sound, .alert, .badge]) { granted, _ in
            DispatchQueue.main.async {
                if granted {
                    UIApplication.shared.registerForRemoteNotifications()
                } else {
                    // Handle error or not granted scenario
                }
            }
        }
    }

    @IBAction func demoGroupedNotifications(_ sender: UIButton) {
        scheduleGroupedNotifications()
    }

    func scheduleGroupedNotifications() {
        for i in 1...6 {
            let notificationContent = UNMutableNotificationContent()
            notificationContent.title = "Hello!"
            notificationContent.body = "Do not forget the pizza!"
            notificationContent.sound = UNNotificationSound.default

            if i % 2 == 0 {
                notificationContent.threadIdentifier = "Guerrix-Wife"
                notificationContent.summaryArgument = "your wife"
            } else {
                notificationContent.threadIdentifier = "Guerrix-Son"
                notificationContent.summaryArgument = "your son"
            }

            // Deliver the notification in five seconds.
            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            // Schedule the notification.
            let request = UNNotificationRequest(identifier: "\(i)FiveSecond", content: notificationContent, trigger: trigger)
            let center = UNUserNotificationCenter.current()
            center.add(request) { (error: Error?) in
                if let theError = error {
                    print(theError)
                }
            }
        }
    }
}
