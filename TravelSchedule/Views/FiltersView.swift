//
//  FiltersView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 08.07.2025.
//

import SwiftUI

struct FiltersView: View {
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @EnvironmentObject private var navigationService: Router
    @ObservedObject var filtersViewModel: FiltersViewModel
    @ObservedObject var carriersVM: CarriersViewModel
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {
                Text("Время отправления")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(alignment: .leading, spacing: 0) {
                    DepartureTimeIntervalView(departureTimeInterval: $filtersViewModel.departureTimeIntervals, selectedTimeInterval: .morning)
                    DepartureTimeIntervalView(departureTimeInterval: $filtersViewModel.departureTimeIntervals, selectedTimeInterval: .afternoon)
                    DepartureTimeIntervalView(departureTimeInterval: $filtersViewModel.departureTimeIntervals, selectedTimeInterval: .evening)
                    DepartureTimeIntervalView(departureTimeInterval: $filtersViewModel.departureTimeIntervals, selectedTimeInterval: .night)
                    
                }
                
                Text("Показывать варианты с пересадками")
                    .font(.system(size: 24, weight: .bold))
                
                VStack(alignment: .leading, spacing: 0) {
                    CircleButtonRowView(selectTransfer: $filtersViewModel.hasTransfers, hasTransfer: true)
                    CircleButtonRowView(selectTransfer: $filtersViewModel.hasTransfers, hasTransfer: false)
                }
                
                Spacer()
                
                Button {
                    carriersVM.filteredCarriersList = filtersViewModel.setFilters(for: carriersVM.carriersList)
                    filtersViewModel.isFilter = !filtersViewModel.departureTimeIntervals.isEmpty || !filtersViewModel.hasTransfers ? true : false
                    navigationService.popLast()
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
                .background(.ypBlueUniversal)
                .clipShape(.rect(cornerRadius: 16))
                .padding(.bottom, 24)
                .toolbarRole(.editor)
                
            }
            .padding(16)
        }
    }
}

#Preview {
    FiltersView(filtersViewModel: FiltersViewModel(), carriersVM: CarriersViewModel())
        .environmentObject(ScheduleViewModel())
}
