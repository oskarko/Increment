//
//  RemindView.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import SwiftUI

struct RemindView: View {
    // MARK: - Properties
    
    // MARK: - Body
    
    var body: some View {
        VStack {
            Spacer()
            DropdownView()
            Spacer()
            Button(action: {}) {
                Text("Create")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }
            .padding(.bottom, 15)
            Button(action: {}) {
                Text("Skip")
                    .font(.system(size: 24, weight: .medium))
                    .foregroundColor(.primary)
            }
        } // VStack
        .navigationTitle("Remind")
        .padding(.bottom, 15)
    }
}

// MARK: - Preview

struct RemindView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            RemindView()
        }
    }
}
