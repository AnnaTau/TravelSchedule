//
//  ListRowView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 07.07.2025.
//

import SwiftUI

struct ListRowView: View {
    var settlement: String
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            HStack {
                Text(settlement)
                    .font(.system(size: 17, weight: .regular))
                    .padding([.top, .bottom], 19)
                Spacer()
                Image(systemName: "chevron.right")
                    .imageScale(.large)
            }
            .foregroundStyle(.ypBlack)
        }
    }
}
