//
//  SelectStationView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 08.07.2025.
//

import SwiftUI

struct SelectStationView: View {
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @State private var searchString: String = ""
    private var direction: Direction
    
    init(direction: Direction) {
        self.direction = direction
    }
    
    var searchResults: [Stations] {
        if searchString.isEmpty {
            return viewModel.stations
        } else {
            return viewModel.stations.filter {
                $0.title?.contains(searchString.capitalized) ?? false
            }
        }
    }
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            VStack {
                SearchBar(searchText: $searchString)
                if !searchResults.isEmpty {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            ForEach(searchResults, id: \.self) { station in
                                ListRowView(settlement: station.title ?? "")
                                    .background()
                                    .onTapGesture {
                                        viewModel.setStation(station: station, direction: direction)
                                        viewModel.backToRoot()
                                    }
                            }
                        }
                        .padding(.horizontal, 16)
                    }
                    .scrollIndicators(.hidden)
                    .navigationTitle("Выбор станции")
                    .toolbarRole(.editor)
                } else if searchResults.isEmpty {
                    Spacer()
                    NotFoundView(text: "Станция не найдена")
                }
                Spacer()
            }
        }
    }
}

#Preview {
    SelectStationView(direction: .from)
        .environmentObject(ScheduleViewModel())
}
