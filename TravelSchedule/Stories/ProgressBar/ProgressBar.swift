//
//  ProgressBar.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 19.07.2025.
//

import SwiftUI

struct ProgressBar: View {
    let numberOfSections: Int
    let progress: CGFloat
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Rectangle()
                    .frame(width: geometry.size.width, height: .progressBarHeight)
                    .foregroundStyle(.ypWhiteUniversal)
                Rectangle()
                    .frame(
                        width: min(
                            progress * geometry.size.width,
                            geometry.size.width
                        ),
                        height: .progressBarHeight
                    )
                    .foregroundStyle(.ypBlueUniversal)
            }
            .mask {
                MaskView(numberOfSections: numberOfSections)
            }
            
        }
    }
}

#Preview {
    Color.gray
        .ignoresSafeArea()
        .overlay(
            ProgressBar(numberOfSections: 5, progress: 0.5)
                .padding()
        )
}
