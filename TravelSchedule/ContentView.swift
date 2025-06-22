//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 18.06.2025.
//

import SwiftUI
import OpenAPIURLSession

struct ContentView: View {
    var body: some View {
        VStack {
            Image(systemName: "globe")
                .imageScale(.large)
                .foregroundStyle(.tint)
            Text("Hello, world!")
        }
        .padding()
        .onAppear {
            testFetchStations()
        }
    }
}

#Preview {
    ContentView()
}

// Функция для тестового вызова API
func testFetchStations() {
    RequestExamples.getNearestStations()
    RequestExamples.getCarrierInfo()
    RequestExamples.getSettlements()
    RequestExamples.getCopyright()
    RequestExamples.getThread()
    RequestExamples.getSchedule()
    RequestExamples.getSearch()
    RequestExamples.getStationsList()
}
