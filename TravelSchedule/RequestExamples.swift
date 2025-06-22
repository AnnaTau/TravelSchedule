//
//  RequestExamples.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 21.06.2025.
//

import Foundation
import OpenAPIURLSession

final class RequestExamples {
    static func getNearestStations() {
        Task {
            do {
                let client = createClient()
                let service = NearestStationsService(
                    client: client,
                    apikey: GlobalParams.apiKey
                )
                print("Fetching stations...")
                let stations = try await service.getNearestStations(
                    lat: 59.864177,
                    lng: 30.319163,
                    distance: 50
                )
                print("Successfully fetched stations: \(stations)")
            } catch {
                print("Error fetching stations: \(error)")
            }
        }
    }
    
    static func getCarrierInfo() {
        Task {
            do {
                let client = createClient()
                let service = CarrierInfoService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching carriers...")
                let carriersInfo: CarrierInfo = try await service.getCarrierInfo(code: "680")
                print("Successfully fetched carriers: \(carriersInfo)")
            } catch {
                print("Error fetching carriers: \(error)")
            }
        }
    }
    
    static func getSettlements() {
        Task {
            do {
                let client = createClient()
                let service = NearestSettlementService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching settlements...")
                let settlements = try await service.getNearestSettlement(
                    lat: 54.513678,
                    lng: 36.261341
                )
                print("Successfully fetched settlements: \(settlements)")
            } catch {
                print("Error fetching settlements: \(error)")
            }
        }
    }
    
    static func getCopyright() {
        Task {
            do {
                let client = createClient()
                let service = CopyrightService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching copyright...")
                let copyright = try await service.getCopyright()
                print("Successfully fetched copyright: \(copyright)")
            } catch {
                print("Error fetching copyright: \(error)")
            }
        }
    }

    static func getThread() {
        Task {
            do {
                let client = createClient()
                let service = ThreadService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching thread...")
                let thread = try await service.getThread(uid: "2S-168_250623_c66067_12")
                print("Successfully fetched thread: \(thread)")
            } catch {
                print("Error fetching thread: \(error)")
            }
        }
    }
    
    static func getSchedule() {
        Task {
            do {
                let client = createClient()
                let service = ScheduleService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching schedule...")
                let schedule = try await service.getSchedule(station: "s9600213")
                print("Successfully fetched schedule: \(schedule)")
            } catch {
                print("Error fetching schedule: \(error)")
            }
        }
    }

    static func getSearch() {
        Task {
            do {
                let client = createClient()
                let service = SearchService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching search...")
                let search = try await service.getSearchResult(from: "c146", to: "c213", on: "2025-07-12")
                print("Successfully fetched search: \(search)")
            } catch {
                print("Error fetching search: \(error)")
            }
        }
    }
    
    static func getStationsList() {
        Task {
            do {
                let client = createClient()
                let service = StationsListService(
                    client: client,
                    apiKey: GlobalParams.apiKey
                )
                print("Fetching stationsList...")
                let stationsList = try await service.getStationsList()
                let countries = stationsList.countries?.map(\.title) ?? []
                print("Successfully fetched stationsList: \(countries)")
                let countriesCount = stationsList.countries?.count ?? 0
                print("Successfully fetched \(countriesCount) countries")
            } catch {
                print("Error fetching stationsList: \(error)")
            }
        }
    }
    
    private static func createClient() -> Client {
        do {
            return Client(
                serverURL: try Servers.Server1.url(),
                transport: URLSessionTransport()
            )
        } catch {
            print("Error creating client: \(error)")
            preconditionFailure()
        }
    }
}
