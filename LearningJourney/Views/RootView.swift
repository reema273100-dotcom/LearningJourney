//
//  RootView.swift
//  LearningJourney
//
//  Created by Reema on 06/06/1448 AH.
//

import SwiftUI

struct RootView: View {
    @State private var appViewModel = AppViewModel()

    var body: some View {
        if let activityViewModel = appViewModel.activityViewModel {
            NavigationStack {
                ActivityView(viewModel: activityViewModel)
            }
        } else {
            OnboardingView { goal in
                appViewModel.start(with: goal)
            }
        }
    }
}

#Preview {
    RootView()
        .preferredColorScheme(.dark)
}
