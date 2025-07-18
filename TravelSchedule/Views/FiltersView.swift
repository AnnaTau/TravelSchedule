//
//  FiltersView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 08.07.2025.
//

import SwiftUI

struct FiltersView: View {
    @EnvironmentObject private var viewModel: ScheduleViewModel
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(alignment: .leading, spacing: 0) {
                    DepartureTimeIntervalView(departureTimeInterval: $viewModel.departureTimeIntervals, selectedTimeInterval: .morning)
                    DepartureTimeIntervalView(departureTimeInterval: $viewModel.departureTimeIntervals, selectedTimeInterval: .afternoon)
                    DepartureTimeIntervalView(departureTimeInterval: $viewModel.departureTimeIntervals, selectedTimeInterval: .evening)
                    DepartureTimeIntervalView(departureTimeInterval: $viewModel.departureTimeIntervals, selectedTimeInterval: .night)
                }
                
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(alignment: .leading, spacing: 0) {
                    CircleButtonRowView(selectTransfer: $viewModel.hasTransfers, hasTransfer: true)
                    CircleButtonRowView(selectTransfer: $viewModel.hasTransfers, hasTransfer: false)
                    
                }
                
                Spacer()
                
                Button {
                    viewModel.setFilters()
                    viewModel.isFilter = !viewModel.departureTimeIntervals.isEmpty || !viewModel.hasTransfers ? true : false
                    viewModel.popLast()
                } label: {
                    Label {
                        HStack {
                            Text("Применить")
                                .font(.system(size: 17, weight: .bold))
                                .foregroundStyle(.ypWhiteUniversal)
                        }
                    } icon: {}
                        .padding()
                    
                }
                .frame(idealWidth: 343, maxWidth: .infinity, maxHeight: 60)
                .background(.ypBlue)
                .clipShape(.rect(cornerRadius: 16))
                .padding(.bottom, 24)
                .toolbarRole(.editor)
                
            }
            .padding(16)
        }
    }
}

#Preview {
    FiltersView()
        .environmentObject(ScheduleViewModel())
}
