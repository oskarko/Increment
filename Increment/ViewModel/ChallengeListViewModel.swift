//
//  ChallengeListViewModel.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Combine

final class ChallengeListViewModel: ObservableObject {
    
    // MARK: - Properties
    private let userService: UserServiceProtocol
    private let challengeService: ChallengeServiceProtocol
    private var cancellables: [AnyCancellable] = []
    @Published private(set) var itemViewModels: [ChallengeItemViewModel] = []
    @Published private(set) var error: IncrementError?
    @Published private(set) var isLoading = false
    @Published var showingCreateModal = false
    let title = "Challenges"
    
    enum Action {
        case create
        case retry
        case timeChange
    }
    
    // MARK: - Lifecycle
    
    init(
        userService: UserServiceProtocol = UserService(),
        challengeService: ChallengeServiceProtocol = ChallengeService()
    ) {
        self.userService = userService
        self.challengeService = challengeService
        observeChallenges()
    }
    
    // MARK: - Helpers
    
    func send(action: Action) {
        switch action {
        case .create:
            showingCreateModal = true
        case .retry:
            observeChallenges()
        case .timeChange:
            cancellables.removeAll()
            observeChallenges()
        }
    }
    
    private func observeChallenges() {
        isLoading = true
        userService.currentUserPublisher()
            .compactMap { $0?.uid }
            .flatMap { [weak self] userId -> AnyPublisher<[Challenge], IncrementError> in
                guard let self = self else { return Fail(error: .default()).eraseToAnyPublisher() }
                
                return self.challengeService.observeChallenges(userId: userId)
            }.sink { [weak self] completion in
                guard let self = self else { return }
                
                self.isLoading = false
                switch completion {
                case let .failure(error):
                    print(error.localizedDescription)
                    self.error = error
                case .finished:
                    print("Finished!")
                }
            } receiveValue: { [weak self] challenges in
                guard let self = self else { return }
                
                self.isLoading = false
                self.showingCreateModal = false
                self.error = nil
                self.itemViewModels = challenges.map { challenge in
                    .init(
                        challenge,
                        onDelete: { [weak self] id in
                            self?.deleteChallenge(id)
                        },
                        onToggleComplete: { [weak self] id, activities in
                            self?.updateChallenge(id: id, activities: activities)
                        }
                    )
                }
            }.store(in: &cancellables)
    }
    
    private func deleteChallenge(_ challengeId: String) {
        challengeService.delete(challengeId).sink { completion in
            switch completion {
            case let .failure(error):
                print(error.localizedDescription)
                self.error = error
            case .finished:
                break
            }
        } receiveValue: { _ in }
        .store(in: &cancellables)

    }
    
    private func updateChallenge(id: String, activities: [Activity]) {
        challengeService.updateChallenge(id, activities: activities).sink { completion in
            switch completion {
            case let .failure(error):
                print(error.localizedDescription)
                self.error = error
            case .finished:
                break
            }
        } receiveValue: { _ in }
        .store(in: &cancellables)

    }
}
