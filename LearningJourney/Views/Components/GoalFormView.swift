//
//  GoalFormView.swift
//  LearningJourney
//
//  Created by Reema on 01/06/1448 AH.
//
import SwiftUI

struct GoalFormView: View {
    @State private var subject = "" // TEMP: owned by the ViewModel later
    @State private var duration: Duration = .week // TEMP: owned by the ViewModel later

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            VStack(alignment: .leading, spacing: 8) {
                Text("I want to learn") // TEMP: wording
                TextField("Swift", text: $subject) // TEMP: wording
                Divider()
            }

            VStack(alignment: .leading, spacing: 12) {
                Text("I want to learn it in a") // TEMP: wording

                HStack(spacing: 12) {
                    ForEach(Duration.allCases, id: \.self) { option in
                        Button {
                            duration = option
                        } label: {
                            Text(option.rawValue.capitalized) // TEMP: title moves to the ViewModel
                                .padding(.horizontal, 20)
                                .padding(.vertical, 12)
                                .foregroundStyle(textColor(for: option))
                                .background(pillColor(for: option), in: Capsule())
                        }
                    }
                }
            }
        }
    }
    private func pillColor(for option: Duration) -> Color {
        if option == duration{
            return Color.orange
        } else {
            return Color.gray.opacity(0.3)
        }
    }

    private func textColor(for option: Duration) -> Color {
        if option == duration{
            return Color.white
        } else {
            return Color.gray
        }
    }
    
}

#Preview {
    GoalFormView()
        .preferredColorScheme(.dark)
        .padding(.horizontal, 20)
}
