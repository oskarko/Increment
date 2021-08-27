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
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                Text(viewModel.title)
                    .font(.system(size: 24, weight: .bold))
                Text(viewModel.statusText)
                Text(viewModel.dailyIncreaseText)
            }
            .padding()
            Spacer()
        }
        .background(
            Rectangle()
                .fill(Color.darkPrimary)
                .cornerRadius(5)
        ).padding()
    }
}

//struct ChallengeItemView_Previews: PreviewProvider {
//    static var previews: some View {
//        ChallengeItemView()
//    }
//}
