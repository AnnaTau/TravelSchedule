//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 18.06.2025.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject private var navigationService: Router
    @EnvironmentObject private var viewModel: ScheduleViewModel
    @StateObject private var carriersViewModel = CarriersViewModel()
    @StateObject private var filtersViewModel = FiltersViewModel()
    
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
                    ScheduleView(carriersVM: carriersViewModel)
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
                        CarriersView(carriersVM: carriersViewModel, filtersVM: filtersViewModel)
                    case Route.noInternetView:
                        ErrorsView(error: .internetConnectError)
                    case Route.serverErrorView:
                        ErrorsView(error: .serverError)
                    case .selectCarrierInfoView:
                        CarrierInfoView(carriersVM: carriersViewModel)
                    case .filtersView:
                        FiltersView(filtersViewModel: filtersViewModel, carriersVM: carriersViewModel)
                    }
                }
            }
        }
        .tint(.ypBlack)
        .task {
            do {
                try await viewModel.getAllSettlements()
            } catch ErrorsType.serverError {
                navigationService.push(route: Route.serverErrorView)
            } catch ErrorsType.internetConnectError {
                navigationService.push(route: Route.noInternetView)
            } catch {
                print(String(describing: error))
            }
        }

    }
}

#Preview {
    ContentView()
        .environmentObject(ScheduleViewModel())
}
