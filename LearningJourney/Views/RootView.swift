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
            Group {
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
            #if DEBUG
            .overlay(alignment: .bottomTrailing) {
                demoMenu
            }
            #endif
        }

        #if DEBUG
        private var demoMenu: some View {
            Menu {
                ForEach(DemoScenario.allCases) { scenario in
                    Button(scenario.rawValue) {
                        appViewModel.load(scenario)
                    }
                }
                Divider()
                Button("Back to Onboarding", role: .destructive) {
                    appViewModel.resetToOnboarding()
                }
            } label: {
                Image(systemName: "ladybug") // check the symbol in SF Symbols
                    .foregroundStyle(Color.white)
                    .frame(width: 44, height: 44)
                    .glassEffect(.regular.interactive(), in: Circle())
            }
            .padding()
        }
        #endif
        
    }


#Preview {
    RootView()
        .preferredColorScheme(.dark)
}
