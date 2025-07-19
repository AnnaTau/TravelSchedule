//
//  MaskView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 19.07.2025.
//
import SwiftUI

struct MaskView: View {
    let numberOfSections: Int
    
    var body: some View {
        HStack {
            ForEach(0..<numberOfSections, id: \.self) { _ in
                MaskFragmentView()
                    .clipShape(RoundedRectangle(cornerRadius: .progressBarCornerRadius))
            }
        }
    }
}
