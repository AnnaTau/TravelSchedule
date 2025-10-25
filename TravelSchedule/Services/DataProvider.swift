//
//  DataProvider.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 07.07.2025.
//

import Foundation
import OpenAPIURLSession
import OpenAPIRuntime

typealias Settlements = Components.Schemas.SettlementsFromStationsList
typealias Stations = Components.Schemas.StationsFromStationsList
typealias Segments = Components.Schemas.Segments
typealias Carrier = Components.Schemas.Carrier

protocol DataProviderProtocol: Sendable {
    func getSearchResult(fromCode: String, toCode: String, on date: String?, transportType: String, hasTransfers: Bool) async throws -> SearchResult
    func getStationsList() async throws -> StationsList
}

actor DataProvider: DataProviderProtocol {
    
    func getSearchResult(fromCode: String, toCode: String, on date: String? = nil, transportType: String, hasTransfers: Bool) async throws -> SearchResult {
        let client = createClient()
        guard let client else { return SearchResult() }
        
        let service = SearchService(
            client: client,
            apiKey: GlobalParams.apiKey
        )
        
        return try await service.getSearchResult(from: fromCode, to: toCode, on: date, transportType: transportType, transfers: hasTransfers)
    }
    
    func getStationsList() async throws -> StationsList {
        let client = createClient()
        guard let client else { return StationsList() }
        
        let service = StationsListService(
            client: client,
            apiKey: GlobalParams.apiKey
        )
        let stationsList = try await service.getStationsList()
        return stationsList
    }
    
    private func createClient() -> Client? {
        var url: URL?
        
        do {
            url = try Servers.Server1.url()
        } catch {
            print(String(describing: error))
        }
        
        guard let url else {
            return nil
        }
        
        let client = Client(
            serverURL: url,
            transport: URLSessionTransport()
        )
        
        return client
    }
}
