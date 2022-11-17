//
//  ContentView.swift
//  SunUp
//
//  Created by Jakub Łaszczewski on 03/03/2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var alarmRepository: AlarmRepositoryImpl
    
    var body: some View {
        MainView(alarmRepository: alarmRepository)
    }
}

#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var alarmRepository: AlarmRepositoryImpl = AlarmRepositoryImpl.example
    static var previews: some View {
        ContentView()
            .environmentObject(alarmRepository)
        
    }
}
#endif
