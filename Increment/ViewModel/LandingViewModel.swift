//
//  LandingViewModel.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

final class LandingViewModel: ObservableObject {
    
    // MARK: - Properties
    
    @Published var loginSignupPushed = false
    @Published var createPushed = false
    
    let title = "Increments"
    let createButtonTitle = "Create a challenge"
    let createButtonImage = "plus.circle"
    let loginButtonTitle = "I already have an account"
    let backgroundImageName = "sixpack"
}
