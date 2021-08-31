//
//  CreateChallengeViewModel.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Combine
import SwiftUI

typealias UserId = String

final class CreateChallengeViewModel: ObservableObject {
    @Published var exerciseDropdown = ChallengePartViewModel(type: .exercise)
    @Published var startAmountDropdown = ChallengePartViewModel(type: .startAmount)
    @Published var increaseDropdown = ChallengePartViewModel(type: .increase)
    @Published var lengthDropdown = ChallengePartViewModel(type: .length)
    
    @Published var error: IncrementError?
    @Published var isLoading = false
    
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    enum Action {
        case createChallenge
    }
    
    init(userService: UserServiceProtocol = UserService(),
         challengeService: ChallengeService = ChallengeService()) {
        self.userService = userService
        self.challengeService = challengeService
    }
    
    func send(action: Action) {
        switch action {
            case .createChallenge:
                isLoading = true
                currentUserId().flatMap { userId -> AnyPublisher<Void, IncrementError> in
                    return self.createChallenge(userId: userId)
                }.sink { completion in
                    self.isLoading = false
                    switch completion {
                    case let .failure(error):
                        self.error = error
                    case .finished:
                        print("finished")
                    }
                } receiveValue: { _ in
                    print("success")
                }.store(in: &cancellables)
        }
    }
    
    private func createChallenge(userId: UserId) -> AnyPublisher<Void, IncrementError> {
        guard
            let exercise = exerciseDropdown.text,
            let startAmount = startAmountDropdown.number,
            let increase = increaseDropdown.number,
            let length = lengthDropdown.number
        else {
            return Fail(error: .default(description: "Parsing error")).eraseToAnyPublisher()
        }
        
        let challenge = Challenge(exercise: exercise,
                                  startAmount: startAmount,
                                  increase: increase,
                                  length: length,
                                  userId: userId,
                                  startDate: Date())
        
        return challengeService.create(challenge).eraseToAnyPublisher()
    }
    
    private func currentUserId() -> AnyPublisher<UserId, IncrementError> {
        print("getting user id")
        return userService.currentUserPublisher().flatMap { user -> AnyPublisher<UserId, IncrementError> in
            if let userId = user?.uid {
                print("User is logged in...")
                return Just(userId)
                    .setFailureType(to: IncrementError.self)
                    .eraseToAnyPublisher()
            } else {
                print("User is being logged in anonymously...")
                return self.userService
                    .signInAnonymously()
                    .map { $0.uid }
                    .eraseToAnyPublisher()
            }
        }.eraseToAnyPublisher()
    }
}

extension CreateChallengeViewModel {
    struct ChallengePartViewModel: DropdownItemProtocol {
        // MARK: - Properties
        
        var selectedOption: DropdownOption
        
        var options: [DropdownOption]
        
        var headerTitle: String {
            type.rawValue
        }
        
        var dropdownTitle: String {
            selectedOption.formatted
        }
        
        var isSelected: Bool = false
        
        private let type: ChallengePartType
        
        enum ChallengePartType: String, CaseIterable {
            case exercise = "Exercise"
            case startAmount = "Starting Amount"
            case increase = "Daily Increase"
            case length = "Challenge Length"
        }
        
        enum ExerciseOption: String, CaseIterable, DropdownOptionProtocol {
            case pullups
            case pushups
            case situps
            
            var toDropdownOption: DropdownOption {
                .init(type: .text(rawValue), formatted: rawValue.capitalized)
            }
        }
        
        enum StartOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1
            case two
            case three
            case four
            case five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue)")
            }
        }
        
        enum IncreaseOption: Int, CaseIterable, DropdownOptionProtocol {
            case one = 1
            case two
            case three
            case four
            case five
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "+\(rawValue)")
            }
        }
        
        enum LengthOption: Int, CaseIterable, DropdownOptionProtocol {
            case seven = 7
            case fourteen = 14
            case twentyOne = 21
            case twentyEight = 28
            
            var toDropdownOption: DropdownOption {
                .init(type: .number(rawValue), formatted: "\(rawValue) days")
            }
        }
        
        
        // MARK: - Lifecycle
        
        init(type: ChallengePartType) {
            switch type {
                case .exercise: self.options = ExerciseOption.allCases.map { $0.toDropdownOption }
                case .startAmount: self.options = StartOption.allCases.map { $0.toDropdownOption }
                case .increase: self.options = IncreaseOption.allCases.map { $0.toDropdownOption }
                case .length: self.options = LengthOption.allCases.map { $0.toDropdownOption }
            }
            self.type = type
            self.selectedOption = options.first!
        }
    }
}

extension CreateChallengeViewModel.ChallengePartViewModel {
    var text: String? {
        if case let .text(text) = selectedOption.type {
            return text
        }
        
        return nil
    }
    
    var number: Int? {
        if case let .number(number) = selectedOption.type {
            return number
        }
        
        return nil
    }
}
