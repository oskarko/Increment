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
        
        return "Day \(daysFromStart + 1) of \(challenge.length)"
    }
    
    var dailyIncreaseText: String {
        "+\(challenge.increase) daily"
    }
    
    
    // MARK: - Lifecycle
    
    init(_ challenge: Challenge) {
        self.challenge = challenge
    }
}
