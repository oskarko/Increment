//
//  PrimaryButtonStyle.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import SwiftUI

struct PrimaryButtonStyle: ButtonStyle {
    var fillColor: Color = .darkPrimary
    
    func makeBody(configuration: Configuration) -> some View {
        return PrimaryButton(configuration: configuration, fillColor: fillColor)
    }
    
    struct PrimaryButton: View {
        let configuration: Configuration
        let fillColor: Color
        
        var body: some View {
            return configuration.label
                .padding(20)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(fillColor)
                )
        }
    }
}

struct PrimaryButtonStyle_Previews: PreviewProvider {
    static var previews: some View {
        Button(action: {}) {
            Text("Create a challenge")
        }
        .buttonStyle(PrimaryButtonStyle())
    }
}
