//
//  SettingsView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 07.07.2025.
//

import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @AppStorage(GlobalParams.theme) private var isDarkModeOn = false
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            
            VStack {
                Toggle("Темная тема", isOn: $isDarkModeOn)
                    .toggleStyle(SwitchToggleStyle(tint: .ypBlue))
                    .frame(height: 60)
                HStack() {
                    Text("Пользовательское соглашение")
                    Spacer()
                    Image(systemName: "chevron.right")
                }
                .foregroundStyle(.ypBlack)
                .background(.ypWhite)
                .frame(height: 60)
                .onTapGesture {
                    viewModel.addPath(with: Route.userAgreementView)
                }
                Spacer()
                VStack(spacing: 12) {
                    Text("Приложение использует API «Яндекс.Расписания»")
                    Text("Версия 1.0 (beta)")
                }
                .foregroundStyle(.ypBlack)
                .font(.system(size: 12, weight: .regular))
            }
            .foregroundStyle(.ypBlack)
            .padding(16)
        }
    }
}

#Preview {
    SettingsView().environmentObject(ScheduleViewModel())
}
