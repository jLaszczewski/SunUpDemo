//
//  MainView.swift
//  SunUp
//
//  Created by Jakub Łaszczewski on 06/03/2022.
//

import SwiftUI

struct MainView: View {
    @StateObject var viewModel: ViewModel
    
    init(
        locationService: LocationService = LocationServiceImpl(),
        dayTimeService: DayTimeService = DayTimeServiceImpl(),
        notificationCenter: LocalNotificationCenter = LocalNotificationCenterImpl(),
        alarmRepository: AlarmRepositoryImpl
    ) {
        let viewModel = ViewModel(
            locationService: locationService,
            dayTimeService: dayTimeService,
            notificationCenter: notificationCenter,
            alarmRepository: alarmRepository
        )
        
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack {
            Spacer()
            Text(viewModel.text)
                .font(.title)
                .lineLimit(2)
                .multilineTextAlignment(.center)
            Spacer()
            HStack {
                button(for: viewModel.sunriseAlarm)
                Spacer()
                button(for: viewModel.sunsetAlarm)
            }
            .padding()
        }
        .onAppear(perform: viewModel.refresh)
    }
    
    func button(for alarm: MainView.ViewModelAlarm) -> some View {
        Menu {
            Button("-15 min") {
                viewModel.set(alarm: alarm, preferredDelay: -15)
            }
            Button(viewModel.itemTitle(for: alarm.type)) {
                viewModel.set(alarm: alarm, preferredDelay: 0)
            }
            Button("+15") {
                viewModel.set(alarm: alarm, preferredDelay: 15)
            }
        } label: {
            VStack {
                ZStack {
                    Circle()
                        .frame(width: 64, height: 64)
                        .foregroundColor(.accentColor)
                    Circle()
                        .frame(width: 60, height: 60)
                        .foregroundColor(
                            alarm.isActive
                            ? .accentColor
                            : Color(uiColor: UIColor.systemBackground))
                    Image(systemName: alarm.image)
                        .imageScale(.large)
                        .foregroundColor(
                            alarm.isActive
                            ? .primary
                            : .accentColor)
                }
                if let text = alarm.text {
                    Text(text)
                        .foregroundColor(.primary)
                }
            }
            .frame(width: 125)
        }
    }
}

#if DEBUG
struct MainView_Preview: PreviewProvider {
    static var previews: some View {
        Group {
            MainView(alarmRepository: AlarmRepositoryImpl())
        }
    }
}
#endif

