//
//  LocalNotificationCenter.swift
//  SunUpTests
//
//  Created by Jakub Łaszczewski on 05/03/2022.
//

import Foundation
@testable import SunUp

final class LocalNotificationCenterMock: LocalNotificationCenter {
    var addResult: Bool!
    private(set) var addNotification: SingleTimeNotification?
    private(set) var addCount = 0
    
    var isNotificationActiveResult: Bool!
    private(set) var isNotificationActiveId: String?
    private(set) var isNotificationActiveCount = 0
    
    private(set) var deleteNotificationId: String?
    private(set) var deleteNotificationCount = 0
    
    func reset() {
        addResult = nil
        addNotification = nil
        addCount = 0
        
        isNotificationActiveResult = nil
        isNotificationActiveId = nil
        isNotificationActiveCount = 0
        
        deleteNotificationId = nil
        deleteNotificationCount = 0
    }
    
    func add(notification: SingleTimeNotification, completion: @escaping (Bool) -> Void) {
        addNotification = notification
        addCount += 1
        
        completion(addResult)
    }
    
    func deleteNotification(with id: String) {
        deleteNotificationId = id
        deleteNotificationCount += 1
    }
}
