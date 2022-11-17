//
//  UserNotificationCenterMock.swift
//  SunUpTests
//
//  Created by Jakub Łaszczewski on 04/03/2022.
//

import Foundation
import UserNotifications
@testable import SunUp

class UNUserNotificationCenterMock: UNUserNotificationCenterProtocol {
    var requestAuthorizationResponse: Bool!
    var requestAuthorizationError: Error?
    private(set) var requestAuthorizationOptions: UNAuthorizationOptions?
    private(set) var requestAuthorizationCount = 0
    
    var addError: Error?
    private(set) var addRequest: UNNotificationRequest?
    private(set) var addCount = 0
    
    private(set) var removePendingNotificationRequestsIdentifiers: [String]?
    private(set) var removePendingNotificationRequestsCount = 0
    
    private(set) var removeAllPendingNotificationRequestsCount = 0
    
    var getDeliveredNotificationsResult: [UNNotification] = []
    private(set) var getDeliveredNotificationsCount = 0
    
    private(set) var removeDeliveredNotificationsIdentifiers: [String]?
    private(set) var removeDeliveredNotificationsCount = 0
    
    private(set) var removeAllDeliveredNotificationsCount = 0
    
    func reset() {
        requestAuthorizationResponse = nil
        requestAuthorizationError = nil
        requestAuthorizationOptions = nil
        requestAuthorizationCount = 0
        
        addError = nil
        addRequest = nil
        addCount = 0
        
        removePendingNotificationRequestsIdentifiers = nil
        removePendingNotificationRequestsCount = 0
        
        removeAllPendingNotificationRequestsCount = 0
        
        getDeliveredNotificationsResult = []
        getDeliveredNotificationsCount = 0
        
        removeDeliveredNotificationsIdentifiers = nil
        removeDeliveredNotificationsCount = 0
        
        removeAllDeliveredNotificationsCount = 0
    }
    
    func requestAuthorization(options: UNAuthorizationOptions, completionHandler: @escaping (Bool, Error?) -> Void) {
        requestAuthorizationOptions = options
        requestAuthorizationCount += 1
        
        completionHandler(requestAuthorizationResponse, requestAuthorizationError)
    }
    
    func add(_ request: UNNotificationRequest, withCompletionHandler completionHandler: ((Error?) -> Void)?) {
        addRequest = request
        addCount += 1
        
        completionHandler?(addError)
    }
    
    func removePendingNotificationRequests(withIdentifiers identifiers: [String]) {
        removePendingNotificationRequestsIdentifiers = identifiers
        removePendingNotificationRequestsCount += 1
    }
    
    func removeAllPendingNotificationRequests() {
        removeAllPendingNotificationRequestsCount += 1
    }
    
    func getDeliveredNotifications(completionHandler: @escaping ([UNNotification]) -> Void) {
        getDeliveredNotificationsCount += 1
        
        completionHandler(getDeliveredNotificationsResult)
    }
    
    func removeDeliveredNotifications(withIdentifiers identifiers: [String]) {
        removeDeliveredNotificationsIdentifiers = identifiers
        removeDeliveredNotificationsCount += 1
    }
    
    func removeAllDeliveredNotifications() {
        removeAllDeliveredNotificationsCount += 1
    }
}
