//
//  DayTime.swift
//  SunUp
//
//  Created by Jakub Łaszczewski on 04/03/2022.
//

import Foundation

/// The struct which specify expected time of the day
/// based on the position of the sun.
enum DayTime: Equatable, CaseIterable {
    case sunset
    case sunrise
}
