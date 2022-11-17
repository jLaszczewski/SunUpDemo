//
//  MainViewModel.swift
//  SunUp
//
//  Created by Jakub Łaszczewski on 06/03/2022.
//

import Foundation

extension MainView {
    struct ViewModelAlarm {
        let type: DayTime
        var image: String {
            switch type {
            case .sunset: return "sunset"
            case .sunrise: return "sunrise"
            }
        }
        var isActive: Bool = false
        var text: String?
    }
    
    final class ViewModel: ObservableObject {
        @Published var text: String = ""
        @Published var sunsetAlarm = MainView.ViewModelAlarm(type: .sunset)
        @Published var sunriseAlarm = MainView.ViewModelAlarm(type: .sunrise)
        
        private let timeFormatter: DateFormatter = {
            let dateFormatter = DateFormatter()
            dateFormatter.timeStyle = .short
            dateFormatter.dateFormat = .none
            dateFormatter.locale = .current
            
            return dateFormatter
        }()
        
        private let preferredDelayFormatter: NumberFormatter = {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            numberFormatter.positivePrefix = "+"
            
            return numberFormatter
        }()
        
        private var sunset = Date()
        private var sunrise = Date()
        
        private let locationService: LocationService
        private let dayTimeService: DayTimeService
        private let notificationCenter: LocalNotificationCenter
        private let alarmRepository: AlarmRepositoryImpl
        
        init(
            locationService: LocationService,
            dayTimeService: DayTimeService,
            notificationCenter: LocalNotificationCenter,
            alarmRepository: AlarmRepositoryImpl
        ) {
            self.locationService = locationService
            self.dayTimeService = dayTimeService
            self.notificationCenter = notificationCenter
            self.alarmRepository = alarmRepository
        }
        
        func refresh() {
            setDayTimes()
            setTitle()
            
            getAlarm(for: .sunset)
            getAlarm(for: .sunrise)
        }
        
        func set(alarm: MainView.ViewModelAlarm, preferredDelay: Int) {
            alarmRepository.deleteAlarm(with: date(for: alarm.type))
            
            let alarm = Alarm(
                date: date(for: alarm.type),
                preferredDelay: preferredDelay,
                type: alarm.type)
            
            alarmRepository.set(alarm: alarm)
            
            getAlarm(for: alarm.type)
        }
    }
}

// MARK: - Actions

extension MainView.ViewModel {
    func setTitle() {
        text = Date() > sunset
        ? NSLocalizedString(
            "Next sunrise:\n\(timeFormatter.string(from: sunrise))",
            comment: "")
        : NSLocalizedString(
            "Next sunset:\n\(timeFormatter.string(from: sunset))",
            comment: "")
    }
    
    func setDayTimes() {
        let currentLocationCoordinates = locationService.currentLocationCoordinates
        let currentDayDate = Date()
        sunset = dayTimeService.time(
            for: .sunset,
               day: currentDayDate,
               locationCoordinates: currentLocationCoordinates)
        sunrise = dayTimeService.time(
            for: .sunrise,
               day: currentDayDate,
               locationCoordinates: currentLocationCoordinates)
    }
    
    func itemTitle(for dayTime: DayTime) -> String {
        switch dayTime {
        case .sunset: return NSLocalizedString("Sunset (+0)", comment: "")
        case .sunrise: return NSLocalizedString("Sunrise (+0)", comment: "")
        }
    }
    
    func text(for date: Date, preferredDelay: Int) -> String {
        let newDate = Calendar.current.date(byAdding: .minute, value: preferredDelay, to: date)!
        let preferredDelayText = preferredDelayFormatter.string(for: preferredDelay) ?? "+0"
        return "\(timeFormatter.string(from: newDate)) (\(preferredDelayText))"
    }
    
    func getAlarm(for dayTime: DayTime) {
        guard let alarm = alarmRepository.getAlarm(with: date(for: dayTime)) else {
            switch dayTime {
            case .sunset: sunsetAlarm = MainView.ViewModelAlarm(type: .sunset)
            case .sunrise: sunriseAlarm = MainView.ViewModelAlarm(type: .sunrise)
            }
            return
        }
        
        let viewModelAlarm = MainView.ViewModelAlarm(
            type: dayTime,
            isActive: true,
            text: text(for: date(for: dayTime), preferredDelay: alarm.preferredDelay))
        
        switch dayTime {
        case .sunset: sunsetAlarm = viewModelAlarm
        case .sunrise: sunriseAlarm = viewModelAlarm
        }
    }
}

// MARK: - Helpers

extension MainView.ViewModel {
    func date(for dayTime: DayTime) -> Date {
        switch dayTime {
        case .sunset: return sunset
        case .sunrise: return sunrise
        }
    }
}
