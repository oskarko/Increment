//
//  ChallengeItemViewModel.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

struct ChallengeItemViewModel: Identifiable {
    
    // MARK: - Properties
    
    private let challenge: Challenge
    
    var id: String {
        challenge.id!
    }
    
    var title: String {
        challenge.exercise.capitalized
    }
    
    var progressCircleViewModel: ProgressCircleViewModel {
        let dayNumber = daysFromStart + 1
        let message = isCompleted ? "Done" : "\(dayNumber) of \(challenge.length)"
        
        return .init(
            title: "Day",
            message: message,
            percentageComplete: Double(dayNumber) / Double(challenge.length)
        )
    }
    
    private var daysFromStart: Int {
        let startDate = Calendar.current.startOfDay(for: challenge.startDate)
        let toDate = Calendar.current.startOfDay(for: Date())
        guard let daysFromStart = Calendar.current.dateComponents([.day], from: startDate, to: toDate).day else {
            return 0
        }
        
        return abs(daysFromStart)
    }
    
    var isCompleted: Bool {
        daysFromStart - challenge.length >= 0
    }
    
    var statusText: String {
        guard !isCompleted  else { return "Done" }
        
        let dayNumber = daysFromStart + 1
        return "Day \(dayNumber) of \(challenge.length)"
    }
    
    var dailyIncreaseText: String {
        "+\(challenge.increase) daily"
    }
    
    let todayTitle = "Today"
    
    var todayRepTitle: String {
        let repNumber = challenge.startAmount + (daysFromStart * challenge.increase)
        let exercise: String
        if repNumber == 1 {
            var challengeExercise = challenge.exercise
            challengeExercise.removeLast()
            exercise = challengeExercise
        } else {
            exercise = challenge.exercise
        }
        
        return isCompleted ? "Completed!" : "\(repNumber) " + exercise
    }
    
    var isDayComplete: Bool {
        let today = Calendar.current.startOfDay(for: Date())
        return challenge.activities.first(where: { $0.date == today })?.isCompleted == true
    }
    
    var markDoneButtonTitle: String {
        isDayComplete || isCompleted ? "Completed!" : "Mark Done"
    }
    
    private let onDelete: (String) -> Void
    private let onToggleComplete: (String, [Activity]) -> Void
    
    // MARK: - Lifecycle
    
    init(
        _ challenge: Challenge,
        onDelete: @escaping (String) -> Void,
        onToggleComplete: @escaping (String, [Activity]) -> Void
    ) {
        self.challenge = challenge
        self.onDelete = onDelete
        self.onToggleComplete = onToggleComplete
    }
    
    func send(action: Action) {
        guard let id = challenge.id else { return }
        switch action {
            case .delete:
                onDelete(id)
            case .toggleComplete:
                let today = Calendar.current.startOfDay(for: Date())
                let activities = challenge.activities.map { activity -> Activity in
                    if today == activity.date {
                        return .init(date: today, isCompleted: !activity.isCompleted)
                    } else {
                        return activity
                    }
                }
                onToggleComplete(id, activities)
        }
    }
}

extension ChallengeItemViewModel {
    enum Action {
        case delete
        case toggleComplete
    }
}
