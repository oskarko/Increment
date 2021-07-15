//
//  CreateView.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import SwiftUI

struct CreateView: View {
    // MARK: - Properties
    
    @StateObject var viewModel = CreateChallengeViewModel()
    @State private var isActive: Bool = false
    
    var dropdownList: some View {
        ForEach(viewModel.dropdowns.indices, id: \.self) { index in
            DropdownView(viewModel: $viewModel.dropdowns[index])
        }
    }
    
    // MARK: - Body
    
    var body: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                NavigationLink(
                    destination: RemindView(),
                    isActive: $isActive
                ) {
                    Button(action: {}) {
                        Text("Next")
                            .font(.system(size: 24, weight: .medium))
                    }
                }
            } // VStack
            .navigationBarTitle("Create")
            .navigationBarBackButtonHidden(true)
            .padding(.bottom, 15)
        }
    }
}

// MARK: - Preview

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
            .previewDevice("iPhone 11 Pro")
    }
}
