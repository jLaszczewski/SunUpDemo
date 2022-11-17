//
//  Alarm.swift
//  SunUp
//
//  Created by Jakub Łaszczewski on 04/03/2022.
//

import Foundation

struct Alarm {
    var date: Date
    var preferredDelay: Int
    var type: DayTime
    
    init(date: Date, preferredDelay: Int, type: DayTime) {
        self.date = date
        self.preferredDelay = preferredDelay
        self.type = type
    }
}

extension Alarm {
    init?(dto: AlarmDTO?) {
        guard let dto = dto else { return nil }
        
        let dayTime: DayTime?
        switch dto.type {
        case "sunrise": dayTime = .sunrise
        case "sunset": dayTime = .sunset
        default: dayTime = nil
        }
        
        guard let date = dto.date, let type = dayTime else { return nil }
        
        self.init(
            date: date,
            preferredDelay: Int(dto.preferredDelay),
            type: type)
    }
}

#if DEBUG
extension Alarm {
    static var example: Alarm {
        Alarm(
            date: Date(),
            preferredDelay: .random(in: -15...15),
            type: .allCases.randomElement()!)
    }
}
#endif
