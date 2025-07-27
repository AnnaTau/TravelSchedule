//
//  StationsListService.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 21.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession
import Foundation

typealias StationsList = Components.Schemas.StationsList

protocol StationsListServiceProtocol: Sendable {
    func getStationsList() async throws -> StationsList
}

actor StationsListService: StationsListServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getStationsList() async throws -> StationsList {
        let response = try await client.getStationsList(
            query: .init(
                apikey: apiKey
            )
        )
        let htmlResponse = try response.ok.body.html
        let data = try await Data(collecting: htmlResponse, upTo: .max)
        do {
            let stationsList = try JSONDecoder().decode(StationsList.self, from: data)
            return stationsList
        } catch {
            print(String(describing: error))
            return StationsList()
        }
    }
}
