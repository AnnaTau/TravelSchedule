//
//  StoriesViewModel.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 19.07.2025.
//

import Foundation

@MainActor
final class StoriesViewModel: ObservableObject {
    @Published var stories = StoryModel.storiesData
    @Published var selectStoryIndex: Int = 0
    
    func showStory(at id: UUID) {
        if let index = stories.firstIndex(where: { $0.id == id }) {
            selectStoryIndex = index
        }
    }
    
    func setStoryAsViewed(at index: Int) {
        if stories.indices.contains(index) {
            stories[index].wasShown = true
        }
    }
    
    func orderedStories()  {
        let viewedStories = stories.filter{$0.wasShown == true}.sorted(by: {$0.imageName < $1.imageName})
        let notViewedStories = stories.filter{$0.wasShown == false}.sorted(by: {$0.imageName < $1.imageName})
        stories = notViewedStories + viewedStories
    }
}
