//
//  NearestStationsService.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 18.06.2025.
//

import OpenAPIRuntime
import OpenAPIURLSession

// 2. Улучшаем читаемость кода — необязательный шаг
// Создаём псевдоним (typealias) для сгенерированного типа Stations.
// Полное имя Components.Schemas.Stations соответствует пути в openapi.yaml:
// components → schemas → Stations
typealias NearestStations = Components.Schemas.Stations

// Определяем протокол для нашего сервиса (хорошая практика для тестирования и гибкости)
protocol NearestStationsServiceProtocol {
    // Функция для получения станций, асинхронная и может выбросить ошибку
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations
}

// Конкретная реализация сервиса
final class NearestStationsService: NearestStationsServiceProtocol {
    // Хранит экземпляр сгенерированного клиента
    private let client: Client
    // Хранит API-ключ (лучше передавать его извне, чем хранить прямо в сервисе)
    private let apikey: String
    
    init(client: Client, apikey: String) {
        self.client = client
        self.apikey = apikey
    }
    
    func getNearestStations(lat: Double, lng: Double, distance: Int) async throws -> NearestStations {
        // Вызываем функцию getNearestStations на ЭКЗЕМПЛЯРЕ сгенерированного клиента.
        // Имя функции и параметры 'query' напрямую соответствуют операции
        // 'getNearestStations' и её параметрам в openapi.yaml
        let response = try await client.getNearestStations(query: .init(
            apikey: apikey,     // Передаём API-ключ
            lat: lat,           // Передаём широту
            lng: lng,           // Передаём долготу
            distance: distance  // Передаём дистанцию
        ))
        // response.ok: Доступ к успешному ответу
        // .body: Получаем тело ответа
        // .json: Получаем объект из JSON в ожидаемом типе NearestStations
        return try response.ok.body.json
    }
}
