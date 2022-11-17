//
//  LocationService.swift
//  SunUpTests
//
//  Created by Jakub Łaszczewski on 05/03/2022.
//

import Foundation
@testable import SunUp

final class LocationServiceMock: LocationService {
    var mockedLocationCoordinates: LocationCoordinates!
    var currentLocationCoordinatesCount = 0
    
    var currentLocationCoordinates: LocationCoordinates {
        currentLocationCoordinatesCount += 1
        return mockedLocationCoordinates
    }
}
