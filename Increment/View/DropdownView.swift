//
//  DropdownView.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import SwiftUI

struct DropdownView: View {
    // MARK: - Properties
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            HStack {
                Text("Excercise")
                    .font(.system(size: 22, weight: .semibold))
                Spacer()
            } // HStack
            Button(action: {}) {
                HStack {
                    Text("Pushups")
                        .font(.system(size: 28, weight: .semibold))
                    Spacer()
                    Image(systemName: "arrowtriangle.down.circle")
                        .font(.system(size: 24, weight: .medium))
                } // HStack
            }
            .buttonStyle(PrimaryButtonStyle(fillColor: .primaryButton))
        } // VStack
        .padding(15)
    }
}

// MARK: - Preview

struct DropdownView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DropdownView()
                .previewLayout(.sizeThatFits)
        }
        .environment(\.colorScheme, .light) // default
        
        NavigationView {
            DropdownView()
                .previewLayout(.sizeThatFits)
        }
        .environment(\.colorScheme, .dark)
    }
}
