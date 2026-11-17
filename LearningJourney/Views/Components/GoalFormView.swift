//
//  GoalFormView.swift
//  LearningJourney
//
//  Created by Reema on 01/06/1448 AH.
//
import SwiftUI

struct GoalFormView: View {
    @Binding var subject: String
    @Binding var duration: Duration

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
                                .glassEffect(pillGlass(for: option), in: Capsule())
                        }
                    }
                }
            }
        }
    }
    

    private func textColor(for option: Duration) -> Color {
        if option == duration{
            return Color.white
        } else {
            return Color.gray
        }
    }
    private func pillGlass(for option: Duration) -> Glass {
        if option == duration {
            return .regular.tint(.orange)
        } else {
            return .regular
        }
    }
}


#Preview {
    GoalFormView(subject: .constant(""), duration: .constant(.week))
        .preferredColorScheme(.dark)
        .padding(.horizontal, 20)
}

