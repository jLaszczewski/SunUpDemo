//
//  LocationService.swift
//  SunUp
//
//  Created by Jakub Łaszczewski on 05/03/2022.
//

import Foundation
import CoreLocation

struct LocationCoordinates: Equatable {
    let latitude: Float
    let longitude: Float
    
    #if DEBUG
    static var example: LocationCoordinates {
        LocationCoordinates(latitude: .random(in: -90...90), longitude: .random(in: -180...180))
    }
    #endif
}

protocol LocationService {
    var currentLocationCoordinates: LocationCoordinates { get }
}

struct LocationServiceImpl: LocationService {
    var currentLocationCoordinates: LocationCoordinates {
        LocationCoordinates(latitude: 52.4082663, longitude: 16.9335199)
    }
}
