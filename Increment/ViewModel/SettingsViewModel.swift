//
//  SettingsViewModel.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Combine
import SwiftUI

final class SettingsViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @AppStorage("isDarkMode") private var isDarkMode = false
    @Published private(set) var itemsViewModel: [SettingsItemViewModel] = []
    @Published var loginSignupPushed = false
    let title = "Settings"
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    
    // MARK: - Lifecycle
    
    init(userService: UserServiceProtocol = UserService()) {
        self.userService = userService
    }
    
    // MARK: - Public Methods
    
    func item(at index: Int) -> SettingsItemViewModel {
        itemsViewModel[index]
    }
    
    func tappedItem(at index: Int) {
        switch itemsViewModel[index].type {
            case .account:
                guard userService.currentUser?.email == nil else { return }
                loginSignupPushed = true
            case .mode:
                isDarkMode.toggle()
                buildItems()
            case .logout:
                userService.logout().sink { completion in
                    switch completion {
                    case let .failure(error):
                        print(error.localizedDescription)
                    case .finished:
                        break
                    }
                } receiveValue: { _ in }
                .store(in: &cancellables)

            default:
                break
        }
    }
    
    func onAppear() {
        buildItems()
    }
    
    // MARK: - Helpers
    
    private func buildItems() {
        itemsViewModel = [
            .init(title: userService.currentUser?.email ?? "Create account", iconName: "person.circle", type: .account),
            .init(title: "Switch to \(isDarkMode ? "Light" : "Dark") Mode", iconName: "lightbulb", type: .mode),
            .init(title: "Privacy Policy", iconName: "shield", type: .privacy)
        ]
        
        if userService.currentUser?.email != nil {
            itemsViewModel += [.init(title: "Logout", iconName: "arrowshape.turn.up.left", type: .logout)]
        }
    }
}
