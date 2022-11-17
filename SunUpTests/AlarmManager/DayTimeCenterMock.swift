//
//  DayTimeServiceMock.swift
//  SunUpTests
//
//  Created by Jakub Łaszczewski on 05/03/2022.
//

import Foundation
@testable import SunUp

final class DayTimeServiceMock: DayTimeService {
    var timeResult: Date!
    private(set) var timeDayTime: DayTime?
    private(set) var timeDay: Date?
    private(set) var timeLocationCoordinates: LocationCoordinates?
    private(set) var timeCount = 0
    
    func reset() {
        timeResult = nil
        timeDayTime = nil
        timeDay = nil
        timeLocationCoordinates = nil
        timeCount = 0
    }
    
    func time(for dayTime: DayTime, day: Date, locationCoordinates: LocationCoordinates) -> Date {
        timeDayTime = dayTime
        timeDay = day
        timeLocationCoordinates = locationCoordinates
        timeCount += 1
        
        return timeResult
    }
}
