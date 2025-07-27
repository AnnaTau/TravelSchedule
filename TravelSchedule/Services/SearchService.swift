//
//  SearchService.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 21.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

typealias SearchResult = Components.Schemas.SearchResult

protocol SearchServiceProtocol: Sendable {
    func getSearchResult(from: String, to: String, on date: String?, transportType: String, transfers: Bool) async throws -> SearchResult
}

actor SearchService: SearchServiceProtocol {
    
    private let client: Client
    private let apiKey: String
    
    init(client: Client, apiKey: String) {
        self.client = client
        self.apiKey = apiKey
    }
    
    func getSearchResult(from: String, to: String, on date: String? = nil, transportType: String, transfers: Bool) async throws -> SearchResult {
        let response = try await client.getSearchResult(
            query: .init(
                apikey: apiKey,
                from: from,
                to: to,
                date: date ?? "",
                transport_types: transportType,
                transfers: String(transfers)
            )
        )

        return try response.ok.body.json
    }
}
