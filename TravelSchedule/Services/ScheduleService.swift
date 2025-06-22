//
//  ScheduleService.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 21.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias ScheduleInfo = Components.Schemas.ScheduleInfo

protocol ScheduleServiceProtocol {
    func getSchedule(station name: String) async throws -> ScheduleInfo
}

final class ScheduleService: ScheduleServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getSchedule(station name: String) async throws -> ScheduleInfo {
        let response = try await client.getSchedule(
            query: .init(
                apikey: apiKey,
                station: name
            )
        )
        
        return try response.ok.body.json
    }
}
