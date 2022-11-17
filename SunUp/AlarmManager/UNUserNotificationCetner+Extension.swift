//
//  UserNotificationCetner.swift
//  SunUp
//
//  Created by Jakub Łaszczewski on 04/03/2022.
//

import Foundation
import UserNotifications

protocol UNUserNotificationCenterProtocol {
    func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void)
    func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Void)?)
    func removePendingNotificationRequests(withIdentifiers identifiers: [String])
    func removeAllPendingNotificationRequests()
    func getDeliveredNotifications(completionHandler: @escaping ([UNNotification]) -> Void)
    func removeDeliveredNotifications(withIdentifiers identifiers: [String])
    func removeAllDeliveredNotifications()
}

extension UNUserNotificationCenter: UNUserNotificationCenterProtocol {}
