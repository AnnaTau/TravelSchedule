//
//  StoryPreview.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 19.07.2025.
//

import SwiftUI

struct StoryPreview: View {
    let story: StoryModel
    
    var body: some View {
        ZStack(alignment: .bottomLeading) {
            Image(story.imageName)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
            Text(story.title)
                .lineLimit(3)
                .font(.system(size: 12, weight: .regular))
                .foregroundColor(.ypWhiteUniversal)
                .padding(.horizontal, 8)
                .padding(.bottom, 26)
        }
        .frame(width: 92, height: 140)
        .overlay {
            RoundedRectangle(cornerRadius: 15).strokeBorder(Color.ypBlueUniversal, lineWidth: story.wasShown ? 0 : 4)
        }
        .cornerRadius(16)
        .opacity(story.wasShown ? 0.5 : 1)
        .padding(.vertical, 24)
    }
}

#Preview {
    StoryPreview(story: StoryModel.storiesData[0])
}
