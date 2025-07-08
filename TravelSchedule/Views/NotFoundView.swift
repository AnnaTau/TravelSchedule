//
//  NotFoundView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 07.07.2025.
//

import SwiftUI

struct NotFoundView: View {
    let text: String
    
    var body: some View {
        ZStack {
            Color.ypWhite.ignoresSafeArea()
            Text(text)
                .font(.system(size: 24, weight: .bold))
                .foregroundStyle(.ypBlack)
        }
    }
}
