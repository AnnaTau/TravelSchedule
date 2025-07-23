//
//  StoriesView.swift
//  TravelSchedule
//
//  Created by Анна Рыкунова on 19.07.2025.
//

import SwiftUI
import Combine

struct StoriesView: View {
    @ObservedObject private var storiesViewModel: StoriesViewModel
    @State private var timer: Timer.TimerPublisher
    @State private var cancellable: Cancellable?
    @State private var progress: CGFloat
    @Environment(\.dismiss) var dismiss
    
    private var currentStory: StoryModel { storiesViewModel.stories[currentStoryIndex] }
    private var currentStoryIndex: Int { Int(progress * CGFloat(storiesViewModel.stories.count)) }
    private var timerConfiguration: TimerConfiguration
    
    init(storiesViewModel: StoriesViewModel) {
        self.storiesViewModel = storiesViewModel
        self.timerConfiguration = TimerConfiguration(storiesCount: storiesViewModel.stories.count, secondsPerStory: 10)
        self.timer = Self.createTimer(configuration: timerConfiguration)
        progress = timerConfiguration.progress(for: storiesViewModel.selectStoryIndex)
    }
    
    var body: some View {
        ZStack(alignment: .topTrailing) {
            StoryView(story: currentStory)
            ProgressBar(numberOfSections: storiesViewModel.stories.count, progress: progress)
                .padding(.init(top: 28, leading: 12, bottom: 12, trailing: 12))
            CloseButton {
                dismissAndOrderStories()
            }
            .padding(.trailing, 12)
            .padding(.top, 50)
        }
        .onAppear {
            timer = Self.createTimer(configuration: timerConfiguration)
            cancellable = timer.connect()
            storiesViewModel.setStoryAsViewed(at: currentStoryIndex)
        }
        .onDisappear {
            cancellable?.cancel()
        }
        .onReceive(timer) {_ in
            timerTick()
        }
        .onTapGesture { location in
            let screenWidth = UIScreen.main.bounds.width
            if location.x < screenWidth / 2 {
                previewStory()
            } else {
                nextStory()
            }
            resetTimer()
        }
        .gesture(DragGesture(minimumDistance: 3.0, coordinateSpace: .local)
            .onEnded { value in
                switch(value.translation.width, value.translation.height) {
                case (...0, -30...30): nextStory()
                case (0..., -30...30): previewStory()
                case (-100...100, 0...): dismissAndOrderStories()
                default: print("unknown gesture")
                }
            }
        )
    }
    
    private func nextStory() {
        let nextStoryIndex = currentStoryIndex + 1
        if nextStoryIndex == storiesViewModel.stories.count {
            dismissAndOrderStories()
        } else {
            withAnimation {
                progress = CGFloat(nextStoryIndex)/CGFloat(storiesViewModel.stories.count)
                storiesViewModel.setStoryAsViewed(at: nextStoryIndex)
            }
        }
    }
    
    private func previewStory() {
        let prevStoryIndex = max(currentStoryIndex - 1, 0)
        withAnimation {
            progress = CGFloat(prevStoryIndex)/CGFloat(storiesViewModel.stories.count)
            storiesViewModel.setStoryAsViewed(at: prevStoryIndex)
        }
    }
    
    private func resetTimer() {
        cancellable?.cancel()
        timer = Self.createTimer(configuration: timerConfiguration)
        cancellable = timer.connect()
    }
    
    
    private func timerTick() {
        var nextProgress = progress + timerConfiguration.progressPerTick
        if nextProgress >= 1 {
            nextProgress = 0
        }
        withAnimation {
            progress = nextProgress
        }
    }
    
    private static func createTimer(configuration: TimerConfiguration) -> Timer.TimerPublisher {
        Timer.publish(every: configuration.timerInterval, on: .main, in: .common)
    }
    
    private func dismissAndOrderStories() {
        dismiss()
        storiesViewModel.orderedStories()
    }
}

#Preview {
    StoriesView(storiesViewModel: StoriesViewModel())
}
