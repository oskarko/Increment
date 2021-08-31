//
//  LoginSignupViewModel.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Combine
import SwiftUI

final class LoginSignupViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let mode: Mode
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var isValid = false
    @Binding var isPushed: Bool
    private let userService: UserServiceProtocol
    private var cancellables: [AnyCancellable] = []
    private(set) var emailPlaceholderText = "Email"
    private(set) var passwordPlaceholderText = "Password"
    
    
    var title: String {
        switch mode {
        case .login: return "Welcome back!"
        case .signup: return "Create an account"
        }
    }
    
    var subtitle: String {
        switch mode {
        case .login: return "Log in with your email"
        case .signup: return "Sign up via email"
        }
    }
    
    var buttonTitle: String {
        switch mode {
        case .login: return "Log in"
        case .signup: return "Sign up"
        }
    }
    
    // MARK: - Lifecycle
    
    init(
        mode: Mode,
        userService: UserServiceProtocol = UserService(),
        isPushed: Binding<Bool>
    ) {
        self.userService = userService
        self.mode = mode
        self._isPushed = isPushed
        Publishers.CombineLatest($emailText, $passwordText)
            .map { [weak self] email, password in
                return self?.isValidEmail(email) == true && self?.isValidPassword(password) == true
            }
            .assign(to: &$isValid)
    }
    
    func tappedActionButton() {
        switch mode {
            case .login:
                userService.login(email: emailText, password: passwordText).sink { completion in
                    switch completion {
                    case let .failure(error):
                        print(error.localizedDescription)
                    case .finished:
                        break
                    }
                } receiveValue: { _ in }
                .store(in: &cancellables)
            case .signup:
                userService.linkAccount(email: emailText, password: passwordText).sink { [weak self] completion in
                    switch completion {
                    case let .failure(error):
                        print(error.localizedDescription)
                    case .finished:
                        print("linkAccount finished")
                        self?.isPushed = false
                    }
                } receiveValue: { _ in }
                .store(in: &cancellables)
                
        }
    }
    
}

extension LoginSignupViewModel {
    func isValidEmail(_ email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]@[A-Z0-9a-z.-]+\\[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        
        return emailPred.evaluate(with: email) && email.count > 5
    }
    
    func isValidPassword(_ password: String) -> Bool {
        password.count > 5
    }
}

extension LoginSignupViewModel {
    enum Mode {
        case login
        case signup
    }
}
