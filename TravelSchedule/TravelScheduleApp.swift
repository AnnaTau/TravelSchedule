//
//  TravelScheduleApp.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 18.06.2025.
//

import SwiftUI

@main
struct TravelScheduleApp: App {
    
    @StateObject private var viewModel = ScheduleViewModel()
    @AppStorage(GlobalParams.theme) private var isDarkModeOn = false
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(viewModel)
                .preferredColorScheme(isDarkModeOn ? .dark : .light)
        }
    }
}
