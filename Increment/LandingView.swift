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
    var body: some View {
        GeometryReader { proxy in
            VStack {
                Spacer()
                    .frame(height: proxy.size.height * 0.26)
                Text("Increment")
                    .font(.system(size: 64, weight: .medium))
                    .foregroundColor(.white)
                Spacer()
                Button(action: {}) {
                    HStack(spacing: 15) {
                        Spacer()
                        Image(systemName: "plus.circle")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        Text("Create a challenge")
                            .font(.system(size: 24, weight: .semibold))
                            .foregroundColor(.white)
                        Spacer()
                    }
                } // Button
                .padding(.horizontal, 15)
                .buttonStyle(PrimaryButtonStyle())
            } // VStack
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(
                Image("sixpack")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .overlay(
                        Color.black.opacity(0.4)
                    )
                    .frame(width: proxy.size.width)
                    .edgesIgnoringSafeArea(.all)
            )
        } // GeometryReader
    }
}

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
