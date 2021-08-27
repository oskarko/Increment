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
    
    // MARK: - Body
    
    var body: some View {
        Text("ChallengeListView")
    }
}

struct ChallengeListView_Previews: PreviewProvider {
    static var previews: some View {
        ChallengeListView()
    }
}
