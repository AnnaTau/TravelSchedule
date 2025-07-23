//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 18.06.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var navigationService: Router
    
    init() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .ypWhite
        appearance.shadowColor = .tabBarDivider
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
    var body: some View {
        
        NavigationStack(path: $navigationService.path) {
            ZStack {
                Color.ypWhite.ignoresSafeArea()
                TabView {
                    ScheduleView()
                        .tabItem {
                            Image("arrowUp")
                                .renderingMode(.template)
                        }
                    
                    SettingsView()
                        .tabItem {
                            Image("SettingsIcon")
                                .renderingMode(.template)
                        }
                }
                .navigationDestination(for: Route.self) { route in
                    switch route {
                    case Route.userAgreementView:
                        UserAgreementView()
                    case Route.selectFromCityView:
                        SelectCityView(direction: .from)
                    case Route.selectFromStationView:
                        SelectStationView(direction: .from)
                    case Route.selectToCityView:
                        SelectCityView(direction: .to)
                    case Route.selectToStationView:
                        SelectStationView(direction: .to)
                    case Route.carriersView:
                        CarriersView()
                    case Route.noInternetView:
                        ErrorsView(error: .internetConnectError)
                    case Route.serverErrorView:
                        ErrorsView(error: .serverError)
                    case .selectCarrierInfoView:
                        CarrierInfoView()
                    case .filtersView:
                        FiltersView()
                    }
                }
            }
        }
        .tint(.ypBlack)
    }
}

#Preview {
    ContentView()
        .environmentObject(ScheduleViewModel())
}
