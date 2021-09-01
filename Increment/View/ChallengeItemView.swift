//
//  ChallengeItemView.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import SwiftUI

struct ChallengeItemView: View {
    
    // MARK: - Properties
    
    private let viewModel: ChallengeItemViewModel
    
    
    // MARK: - Lifecycle
    
    init(viewModel: ChallengeItemViewModel) {
        self.viewModel = viewModel
    }
    
    
    // MARK: - Body
    
    var titleRow: some View {
        HStack {
            Text(viewModel.title)
                .font(.system(size: 24, weight: .bold))
            Spacer()
            Image(systemName: "trash")
        }
    }
    
    var dailyIncreaseText: some View {
        HStack {
            Text(viewModel.dailyIncreaseText)
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                titleRow
                ProgressCircleView(
                    viewModel: viewModel.progressCircleViewModel
                )
                .padding(.vertical, 25)
                dailyIncreaseText
            }
            .padding(.vertical, 10)
            Spacer()
        }
        .background(
            Rectangle()
                .fill(Color.primaryButton)
                .cornerRadius(5)
        )
    }
}

//struct ChallengeItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeItemView()
//    }
//}
