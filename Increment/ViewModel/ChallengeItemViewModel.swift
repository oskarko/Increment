//
//  ChallengeItemViewModel.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

struct ChallengeItemViewModel: Hashable {
    
    // MARK: - Properties
    
    private let challenge: Challenge
    
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
    
    private var isCompleted: Bool {
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
    
    
    // MARK: - Lifecycle
    
    init(_ challenge: Challenge) {
        self.challenge = challenge
    }
}
