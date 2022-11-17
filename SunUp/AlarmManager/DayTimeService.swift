//
//  DayTimeService.swift
//  SunUp
//
//  Created by Jakub Łaszczewski on 04/03/2022.
//

import Foundation
import Solar
import CoreLocation

/// An struct responsible for counting date's time for day time.
/// The time of day depends on the location and date.
protocol DayTimeService {
    
    /// Get sunset date's time based on day date and coordinate.
    ///
    /// - Parameter dayTime: The time of the day.
    /// - Parameter day: The day of the expected sunset time.
    /// - Parameter location: The location coordinate for expected sunset time.
    ///
    /// - Returns: The date which specify time of day time.
    func time(for dayTime: DayTime, day: Date, locationCoordinates: LocationCoordinates) -> Date
}

struct DayTimeServiceImpl: DayTimeService {
    func time(for dayTime: DayTime, day: Date, locationCoordinates: LocationCoordinates) -> Date {
        let solar = Solar(for: day, coordinate: CLLocationCoordinate2D(
            latitude: CLLocationDegrees(locationCoordinates.latitude),
            longitude: CLLocationDegrees(locationCoordinates.longitude)))
        
        switch dayTime {
        case .sunset:
            return solar?.sunset ?? Date()
        case .sunrise:
            return solar?.sunrise ?? Date()
        }
    }
}
