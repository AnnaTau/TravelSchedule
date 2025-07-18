//
//  CircleButtonRowView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 08.07.2025.
//

import SwiftUI

struct CircleButtonRowView: View {
    @Binding var selectTransfer: Bool
    let hasTransfer: Bool
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            HStack {
                Text(hasTransfer ? "Да" : "Нет")
                Spacer()
                Image(systemName: selectTransfer == hasTransfer ? "largecircle.fill.circle" : "circle")
                    .onTapGesture {
                        selectTransfer = hasTransfer
                    }
            }
            .foregroundStyle(.ypBlack)
        }
        .frame(height: 60)
    }
}

#Preview {
    CircleButtonRowView(selectTransfer: .constant(true), hasTransfer: true)
}
