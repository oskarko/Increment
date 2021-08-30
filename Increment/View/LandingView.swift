//
//  ContentView.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import SwiftUI

struct LandingView: View {
    // MARK: - Properties
    
    @StateObject private var viewModel = LandingViewModel()
    
    var title: some View {
        Text(viewModel.title)
            .font(.system(size: 64, weight: .medium))
            .foregroundColor(.white)
    }
    
    var createButton: some View {
        Button(action: {
            viewModel.createPushed = true
        }) {
            HStack(spacing: 15) {
                Spacer()
                Image(systemName: viewModel.createButtonImage)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                Text(viewModel.createButtonTitle)
                    .font(.system(size: 24, weight: .semibold))
                    .foregroundColor(.white)
                Spacer()
            }
        } // Button
        .padding(15)
        .buttonStyle(PrimaryButtonStyle())
    }
    
    var loginButton: some View {
        Button(viewModel.loginButtonTitle) {
            viewModel.loginSignupPushed = true
        }
        .foregroundColor(.white)
    }
    
    var backgroundImage: some View {
        Image(viewModel.backgroundImageName)
            .resizable()
            .aspectRatio(contentMode: .fill)
            .overlay(
                Color.black.opacity(0.4)
            )
    }
    
    // MARK: - Body
    
    var body: some View {
        NavigationView {
            GeometryReader { proxy in
                VStack {
                    Spacer()
                        .frame(height: proxy.size.height * 0.26)
                    title
                    Spacer()
                    NavigationLink(
                        destination: CreateView(),
                        isActive: $viewModel.createPushed) {}
                    createButton
                    NavigationLink(
                        destination: LoginSignupView(viewModel: .init(mode: .login)),
                        isActive: $viewModel.loginSignupPushed) {}
                    loginButton
                } // VStack
                .padding(.bottom, 15)
                .frame(maxWidth: .infinity, maxHeight: .infinity)
                .background(
                    backgroundImage
                        .frame(width: proxy.size.width)
                        .edgesIgnoringSafeArea(.all)
                )
            } // GeometryReader
        }
        .accentColor(.primary)
    }
}

// MARK: - Preview

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LandingView()
            .previewDevice("iPhone 8")
        LandingView()
            .previewDevice("iPhone 11 Pro")
        LandingView()
            .previewDevice("iPhone 11 Pro Max")
    }
}
