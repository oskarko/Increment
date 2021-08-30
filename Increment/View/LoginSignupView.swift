//
//  LoginSignupView.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import SwiftUI

struct LoginSignupView: View {
    
    // MARK: - Properties
    
    @ObservedObject var viewModel: LoginSignupViewModel
    
    var emailTextField: some View {
        TextField(viewModel.emailPlaceholder, text: $viewModel.emailText)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    var passwordTextField: some View {
        SecureField(viewModel.passwordPlaceholder, text: $viewModel.passwordText)
            .modifier(TextFieldCustomRoundedStyle())
    }
    
    var actionButton: some View {
        Button(viewModel.buttonTitle) {
            
        }
        .padding()
        .frame(maxWidth: .infinity)
        .foregroundColor(.white)
        .background(Color(.systemPink))
        .cornerRadius(16)
        .padding()
    }
    
    // MARK: - Body
    var body: some View {
        VStack {
            Text(viewModel.title)
                .font(.largeTitle)
                .fontWeight(.bold)
            Text(viewModel.subtitle)
                .font(.title2)
                .fontWeight(.semibold)
                .foregroundColor(Color(.systemGray2))
            Spacer()
                .frame(height: 50)
            emailTextField
            passwordTextField
            actionButton
            Spacer()
        }
        .padding()
    }
}

struct LoginSignupView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            LoginSignupView(viewModel: .init(mode: .login))
        }
    }
}
