//
//  Challenge.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import Foundation

struct Challenge: Codable {
    let exercise: String
    let startAmount: Int
    let increase: Int
    let length: Int
    let userId: String
    let startDate: Date
}
