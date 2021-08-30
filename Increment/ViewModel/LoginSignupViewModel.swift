//
//  LoginSignupViewModel.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

final class LoginSignupViewModel: ObservableObject {
    
    // MARK: - Properties
    
    private let mode: Mode
    @Published var emailText = ""
    @Published var passwordText = ""
    @Published var isValid = false
    
    
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
    
    var emailPlaceholder = "Email"
    var passwordPlaceholder = "Password"
    
    var buttonTitle: String {
        switch mode {
        case .login: return "Log in"
        case .signup: return "Sign up"
        }
    }
    
    // MARK: - Lifecycle
    
    init(mode: Mode) {
        self.mode = mode
    }
    
}

extension LoginSignupViewModel {
    enum Mode {
        case login
        case signup
    }
}
