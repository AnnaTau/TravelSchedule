//
//  StoryModel.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 19.07.2025.
//

import Foundation

struct StoryModel: Identifiable, Hashable {
    let id: UUID
    let title: String
    let description: String
    let imageName: String
    var wasShown: Bool

    static let storiesData: [StoryModel] = [
        StoryModel(image: "story1"),
        StoryModel(image: "story2"),
        StoryModel(image: "story3"),
        StoryModel(image: "story4"),
        StoryModel(image: "story5"),
        StoryModel(image: "story6"),
        StoryModel(image: "story7")
    ]
    
    init(image: String,
         title: String = "Text Text Text Text Text Text Text Text Text Text Text Text",
         description: String = "Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text Text",
         wasShown: Bool = false
    ) {
        self.id = UUID()
        self.title = title
        self.description = description
        self.imageName = image
        self.wasShown = wasShown
    }
    
}
