//
//  OnboardingView.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//

import SwiftUI

struct OnboardingView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Image(systemName: "flame.fill") // TEMP: check symbol
                .font(.largeTitle)
                .foregroundStyle(Color.orange) // TEMP: color
                .frame(maxWidth: .infinity)
                .padding(.vertical, 60)

            VStack(alignment: .leading, spacing: 4) {
                HStack(spacing: 6) {
                    Text("Hello ").fontWeight(.light)
                    Text("Learner").fontWeight(.bold)
                }
                .font(.largeTitle)
                Text("This app will help you learn every day!") // TEMP: wording
                    .foregroundStyle(.secondary)
                    
            }
            GoalFormView()
                .padding(.top, 20)
            Spacer()

            VStack(spacing: 12) {
                Button {
                    // no action yet: starts the goal later
                } label: {
                    Text("Start Learning") // TEMP: wording
                        .font(.headline)
                        .foregroundStyle(Color.white)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .background(Color.orange, in: Capsule()) // TEMP: color
                }
                .padding(.horizontal, 80)

                Text("You can edit your goal later") // TEMP: wording
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 20)
    }
}

#Preview {
    OnboardingView()
        .preferredColorScheme(.dark)
}
