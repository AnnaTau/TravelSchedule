//
//  SettingsViewModel.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 25.07.2025.
//

import Foundation

@Observable
@MainActor
final class SettingsViewModel {
    var isDarkModeOn: Bool = false {
        didSet {
            UserDefaults.standard.set(isDarkModeOn, forKey: GlobalParams.theme)
        }
    }
    
    init() {
        isDarkModeOn = UserDefaults.standard.bool(forKey: GlobalParams.theme)
    }
    
    func toggleAppTheme() {
        isDarkModeOn.toggle()
    }
}
