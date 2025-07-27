//
//  ScheduleViewModel.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 07.07.2025.
//

import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

@MainActor
final class ScheduleViewModel: ObservableObject {
    @Published var allSettlements: [Settlements] = []
    @Published var stations: [Stations] = []
    @Published var fromSettlement: Settlements?
    @Published var toSettlement: Settlements?
    @Published var fromStation: Stations?
    @Published var toStation: Stations?
    @Published var isLoading: Bool = true
    
    private var hasTransfers: Bool = true
    private let dataProvider: DataProviderProtocol = DataProvider()
    
    func setSettlementsStations(on settlement: Settlements, direction: Direction) {
        let allStations = settlement.stations ?? []
        stations = allStations.filter { $0.station_type == "train_station" || $0.transport_type == "train" }
        stations.sort {$0.title ?? "" < $1.title ?? "" }
        
        switch direction {
        case .from:
            fromSettlement = settlement
        case .to:
            toSettlement = settlement
        }
    }
    
    func setStation(station: Stations, direction: Direction) {
        switch direction {
        case .from:
            fromStation = station
        case .to:
            toStation = station
        }
    }
    
    func changeDirection() {
        swap(&fromSettlement, &toSettlement)
        swap(&fromStation, &toStation)
    }
    
    func search() async throws -> SearchResult? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        guard let fromCode = fromStation?.codes?.yandex_code,
              let toCode = toStation?.codes?.yandex_code else { return nil }
        
        let searchResult = try await dataProvider.getSearchResult(fromCode: fromCode, toCode: toCode, on: date, transportType: "train", hasTransfers: hasTransfers)
        isLoading = false
        return searchResult
    }
    
    func setSearchButtonEnable() -> Bool {
        fromStation != nil && toStation != nil
    }
    
    func getAllSettlements() async throws {
        var stationList: [Settlements] = []
        let testSettlements = ["Москва", "Санкт-Петербург", "Сочи", "Уфа", "Волгоград", "Воронеж", "Владивосток"]
        let allStationsList = try await dataProvider.getStationsList()
        stationList = allStationsList.countries?
            .flatMap { $0.regions ?? [] }
            .flatMap { $0.settlements ?? [] }
            .filter { testSettlements.contains($0.title ?? "") } ?? []
        
        allSettlements = stationList.filter { $0.title != ""}
        isLoading = allSettlements.isEmpty
        allSettlements.sort {$0.title ?? "" < $1.title ?? "" }
    }
    
}
