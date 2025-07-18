//
//  DepartureTimeIntervalView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 08.07.2025.
//

import SwiftUI

struct DepartureTimeIntervalView: View {
    
    @Binding var departureTimeInterval: [DepartureTimeInterval]
    @State private var selectCheckBox: Bool = false
    var selectedTimeInterval: DepartureTimeInterval
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            HStack {
                Text(selectedTimeInterval.rawValue)
                Spacer()
                Image(systemName: selectCheckBox ? "checkmark.square.fill" : "square")
                    .frame(width: 20, height: 20)
                    .onTapGesture {
                        if !departureTimeInterval.contains(selectedTimeInterval) {
                            departureTimeInterval.append(selectedTimeInterval)
                            selectCheckBox = true
                        } else {
                            departureTimeInterval = departureTimeInterval.filter { $0 != selectedTimeInterval}
                            selectCheckBox = false
                        }
                    }
            }
            .foregroundStyle(.ypBlack)
        }
        .frame(height: 60)
    }
}

#Preview {
    DepartureTimeIntervalView(departureTimeInterval: .constant([.afternoon]), selectedTimeInterval: .afternoon)
}
