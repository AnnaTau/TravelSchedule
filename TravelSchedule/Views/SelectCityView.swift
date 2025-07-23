//
//  SelectCityView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 07.07.2025.
//

import SwiftUI

struct SelectCityView: View {
    @EnvironmentObject private var navigationService: Router
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @State private var searchString: String = ""
    private var direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    var searchResults: [Settlements] {
        if searchString.isEmpty {
            return viewModel.allSettlements
        } else {
            return viewModel.allSettlements.filter {
                $0.title?.contains(searchString.capitalized) ?? false
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack {
                SearchBar(searchText: $searchString)
                
                if viewModel.isLoading {
                    Spacer()
                    ProgressView()
                } else if !searchResults.isEmpty {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(searchResults, id: \.self) { settlement in
                                ListRowView(settlement: settlement.title ?? "")
                                    .background()
                                    .onTapGesture {
                                        switch direction {
                                        case .from:
                                            navigationService.push(route: Route.selectFromStationView)
                                        case .to:
                                            navigationService.push(route: Route.selectToStationView)
                                        }
                                        viewModel.setSettlementsStations(on: settlement, direction: direction)
                                    }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)
                } else {
                    Spacer()
                    NotFoundView(text: "Город не найден")
                }
                Spacer()
                    .navigationTitle("Выбор города")
                    .toolbarRole(.editor)
            }
        }
    }
}


#Preview {
    SelectCityView(direction: .from)
        .environmentObject(ScheduleViewModel())
}
