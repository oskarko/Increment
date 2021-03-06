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
    
    var dropdownList: some View {
        Group {
            DropdownView(viewModel: $viewModel.exerciseDropdown)
            DropdownView(viewModel: $viewModel.startAmountDropdown)
            DropdownView(viewModel: $viewModel.increaseDropdown)
            DropdownView(viewModel: $viewModel.lengthDropdown)
        }
    }
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                dropdownList
                Spacer()
                
                    Button(action: {
                        viewModel.send(action: .createChallenge)
                    }) {
                        Text("Next")
                            .font(.system(size: 24, weight: .medium))
                            .foregroundColor(.primary)
                    }

            } // VStack
        } // ScrollView
    }
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else {
                mainContentView
            }
        }.alert(isPresented: Binding<Bool>.constant($viewModel.error.wrappedValue != nil)) {
            Alert(
                title: Text("Error!"),
                message: Text($viewModel.error.wrappedValue?.localizedDescription ?? ""),
                dismissButton: .default(Text("OK"), action: {
                    viewModel.error = nil
                })
            )
        }
        .navigationBarTitle("Create")
        .navigationBarBackButtonHidden(true)
        .padding(.bottom, 15)
    }
}

// MARK: - Preview

struct CreateView_Previews: PreviewProvider {
    static var previews: some View {
        CreateView()
            .previewDevice("iPhone 11 Pro")
    }
}
