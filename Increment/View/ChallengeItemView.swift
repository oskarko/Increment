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
                .onTapGesture {
                    viewModel.send(action: .delete)
                }
        }
    }
    
    var dailyIncreaseText: some View {
        HStack {
            Text(viewModel.dailyIncreaseText)
                .font(.system(size: 24, weight: .bold))
            Spacer()
        }
    }
    
    var todayView: some View {
        Group {
            Divider()
            Text(viewModel.todayTitle)
                .font(.title3)
                .fontWeight(.medium)
            Text(viewModel.todayRepTitle)
                .font(.system(size: 24, weight: .bold))
            Button(viewModel.markDoneButtonTitle) {
                viewModel.send(action: .toggleComplete)
            }
            .disabled(viewModel.isCompleted)
            .padding(.vertical, 10)
            .padding(.horizontal, 15)
            .font(Font.caption.weight(.semibold))
            .background(viewModel.isDayComplete ? Color.circleTrack : Color.primaryButton)
            .cornerRadius(8)
        }
    }
    
    var body: some View {
        HStack {
            Spacer()
            VStack(spacing: 25) {
                titleRow
                ProgressCircleView(
                    viewModel: viewModel.progressCircleViewModel
                )
                dailyIncreaseText
                todayView
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
