//
//  SelectDestinationView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 07.07.2025.
//

import SwiftUI

struct SelectDestinationView: View {
    let text: String
    let placeholder: String
    
    init(settlement: String, station: String, placeholder: String) {
        if settlement == "".trimmingCharacters(in: .whitespacesAndNewlines) && station == "".trimmingCharacters(in: .whitespacesAndNewlines) {
            self.text = placeholder
        } else {
            self.text = settlement + " (\(station))"
        }
        self.placeholder = placeholder
    }
    
    var body: some View {
        ZStack(alignment: .leading) {
            Color.ypWhiteUniversal
            Text(text)
                .padding(.vertical, 14)
                .padding([.leading], 16)
                .lineLimit(1)
                .foregroundStyle(text != placeholder ? .ypBlackUniversal : .ypGrayUniversal)
        }
        .cornerRadius(20)
    }
}

#Preview {
    SelectDestinationView(settlement: "", station: "", placeholder: "Откуда")
}
