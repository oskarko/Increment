//
//  TextFieldCustomRoundedStyle.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import SwiftUI


struct TextFieldCustomRoundedStyle: ViewModifier {
    func body(content: Content) -> some View {
        return content
            .font(.system(size: 16, weight: .medium))
            .foregroundColor(.primary)
            .padding()
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.primary)
            )
            .padding(.horizontal, 15)
    }
}
