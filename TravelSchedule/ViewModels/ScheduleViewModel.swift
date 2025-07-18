//
//  ScheduleViewModel.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 07.07.2025.
//

import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

final class ScheduleViewModel: ObservableObject {
    @Published var allSettlements: [Settlements] = []
    @Published var stations: [Stations] = []
    @Published var fromSettlement: Settlements?
    @Published var toSettlement: Settlements?
    @Published var fromStation: Stations?
    @Published var toStation: Stations?
    @Published var carriersList: [Segments] = []
    @Published var carrier: Carrier?
    @Published var isLoading: Bool = true
    @Published var isFilter: Bool = false
    @Published var filteredCarriersList: [Segments] = []
    @Published var departureTimeIntervals: [DepartureTimeInterval] = []
    @Published var hasTransfers: Bool = true
    private let navigationService = Router.shared
    private let dataProvider: DataProviderProtocol
    
    init() {
        dataProvider = DataProvider()
        Task { await getAllSettlements() }
    }
    
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
    
    @MainActor
    func search() async {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.string(from: Date())
        
        guard let fromCode = fromStation?.codes?.yandex_code,
              let toCode = toStation?.codes?.yandex_code else { return }
        
        do {
            let searchResult = try await dataProvider.getSearchResult(fromCode: fromCode, toCode: toCode, on: date, transportType: "train", hasTransfers: hasTransfers)
            carriersList = searchResult.segments ?? []
            filteredCarriersList = carriersList
        } catch ErrorsType.internetConnectError {
            addPath(with: Route.noInternetView)
        } catch ErrorsType.serverError {
            addPath(with: Route.serverErrorView)
        } catch {
            print(String(describing: error))
        }
        
        isLoading = false
    }
    
    func setFilters() {
        var filteredCarriers = carriersList
        if !departureTimeIntervals.isEmpty {
            filteredCarriers = filteredCarriers.filter { segment in
                let time = departureTime(departure: segment.departure ?? "")
                switch time {
                case 6...12:
                    return departureTimeIntervals.contains(.morning)
                case 12...18:
                    return departureTimeIntervals.contains(.afternoon)
                case 18...23:
                    return departureTimeIntervals.contains(.evening)
                case 0...6:
                    return departureTimeIntervals.contains(.night)
                default:
                    return false
                }
            }
        }
        if !hasTransfers {
            filteredCarriers = filteredCarriers.filter {$0.has_transfers == false }
        }
        filteredCarriersList = filteredCarriers
    }
    
    func dateFormatter(date: String, with format: String, local: String) -> String {
        let generalFormatter = DateFormatter()
        generalFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: local)
        formatter.dateFormat = format
        
        return formatter.string(from: generalFormatter.date(from: date) ?? Date())
    }
    
    func setSearchButtonEnable() -> Bool {
        fromStation != nil && toStation != nil
    }
    
    func addPath(with route: Route) {
        navigationService.push(route: route)
    }
    
    func backToRoot() {
        navigationService.popRoot()
    }
    
    func popLast() {
        navigationService.popLast()
    }
    
    // MARK: - Private Methods
    @MainActor
    private func getAllSettlements() async {
        var stationList: [Settlements] = []
        let testSettlements = ["Москва", "Санкт-Петербург", "Сочи", "Уфа", "Волгоград", "Воронеж", "Владивосток"]
        do {
            let allStationsList = try await dataProvider.getStationsList()
            stationList = allStationsList.countries?
                .flatMap { $0.regions ?? [] }
                .flatMap { $0.settlements ?? [] }
                .filter { testSettlements.contains($0.title ?? "") } ?? []
        } catch ErrorsType.internetConnectError {
            addPath(with: Route.noInternetView)
        } catch ErrorsType.serverError {
            addPath(with: Route.serverErrorView)
        } catch {
            print(String(describing: error))
        }
        allSettlements = stationList.filter { $0.title != ""}
        isLoading = allSettlements.isEmpty
        allSettlements.sort {$0.title ?? "" < $1.title ?? "" }
    }
    
    private func departureTime(departure: String) -> Int {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        let hour = Calendar.current.component(.hour, from: dateFormatter.date(from: departure) ?? Date())
        return hour
    }
}
