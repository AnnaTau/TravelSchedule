//
//  Route.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 07.07.2025.
//

import Foundation

enum Route: Hashable {
    case userAgreementView
    case selectFromCityView
    case selectFromStationView
    case selectToCityView
    case selectToStationView
    case selectCarrierInfoView
    case carriersView
    case noInternetView
    case serverErrorView
    case filtersView
}
