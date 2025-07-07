//
//  CopyrightService.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 21.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias Copyright = Components.Schemas.CopyrightInfo

protocol CopyrightServiceProtocol {
    func getCopyright() async throws -> Copyright
}

final class CopyrightService: CopyrightServiceProtocol {
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getCopyright() async throws -> Copyright {
        let response = try await client.getCopyright(
            query: .init(
                apikey: apiKey,
                format: "json"
            )
        )
        
        return try response.ok.body.json
    }
    
}
