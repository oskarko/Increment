//
//  ChallengeListView.swift
//  Increment
//
//  Created by Oscar R. Garrucho.
//  Linkedin: https://www.linkedin.com/in/oscar-garrucho/
//  Copyright © 2021 Oscar R. Garrucho. All rights reserved.
//

import SwiftUI

struct ChallengeListView: View {
    
    // MARK: - Properties
    @StateObject private var viewModel = ChallengeListViewModel()
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    // MARK: - Body
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
            } else if let error = viewModel.error {
                VStack {
                    Text(error.localizedDescription)
                    Button("Retry") {
                        viewModel.send(action: .retry)
                    }
                    .padding(10)
                    .background(
                        Rectangle()
                            .fill(Color.red)
                            .cornerRadius(5)
                    )
                } // VStack
            } else {
                mainContentView
                    .onReceive(
                        NotificationCenter
                            .default
                            .publisher(for: UIApplication.significantTimeChangeNotification)
                    ) { _ in
                        viewModel.send(action: .timeChange)
                    }
            }
        } // ZStack
    }
    
    var mainContentView: some View {
        ScrollView {
            VStack {
                LazyVGrid(columns: [.init(.flexible(), spacing: 20), .init(.flexible())], spacing: 20) {
                    ForEach(viewModel.itemViewModels, id: \.id) { viewModel in
                        ChallengeItemView(viewModel: viewModel)
                    }
                } // LazyVGrid
                Spacer()
            } // VStack
            .padding(10)
        } // ScrollView
        .sheet(isPresented: $viewModel.showingCreateModal) {
            NavigationView {
                CreateView()
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
        .navigationBarItems(trailing: Button {
            viewModel.send(action: .create)
        } label: {
            Image(systemName: "plus.circle")
                .imageScale(.large)
        })
        .navigationTitle(viewModel.title)
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}
