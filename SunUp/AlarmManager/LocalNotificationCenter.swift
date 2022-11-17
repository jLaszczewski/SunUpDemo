//
//  NotificationCenter.swift
//  SunUp
//
//  Created by Jakub Łaszczewski on 04/03/2022.
//

import Foundation

struct SingleTimeNotification: Equatable {
    enum Sound {
        case `default`
    }
    
    let id: String
    let title: String
    private(set) var description: String?
    let time: Date
    let sound: Sound
}

enum LocalNotificationCenterPermission {
    case sound
    case alert
}

protocol LocalNotificationCenter {
    func add(notification: SingleTimeNotification, completion: @escaping (Bool) -> Void)
    func deleteNotification(with id: String)
}

struct LocalNotificationCenterImpl: LocalNotificationCenter {
    func add(notification: SingleTimeNotification, completion: @escaping (Bool) -> Void) {
        print(#function)
    }
    
    func deleteNotification(with id: String) {
        print(#function)
    }
}
