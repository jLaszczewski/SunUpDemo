//
//  SunUpApp.swift
//  SunUp
//
//  Created by Jakub Łaszczewski on 03/03/2022.
//

import SwiftUI

@main
struct SunUpApp: App {
    @StateObject var alarmRepository = AlarmRepositoryImpl()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(alarmRepository)
        }
    }
}
