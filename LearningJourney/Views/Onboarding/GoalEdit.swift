//
//  GoalEdit.swift
//  LearningJourney
//
//  Created by Reema on 07/06/1448 AH.
//

import SwiftUI

struct GoalEditView: View {
    @State private var viewModel: OnboardingViewModel
    @State private var showAlert = false
    @Environment(\.dismiss) private var dismiss
    private let needsConfirmation: Bool
    private let onSave: (Goal) -> Void

    init(goal: Goal, needsConfirmation: Bool, onSave: @escaping (Goal) -> Void) {
        _viewModel = State(initialValue: OnboardingViewModel(subject: goal.subject, duration: goal.duration))
        self.needsConfirmation = needsConfirmation
        self.onSave = onSave
    }

    var body: some View {
        VStack {
            GoalFormView(subject: $viewModel.subject, duration: $viewModel.duration)
            Spacer()
        }
        .padding(.horizontal, 20)
        .tint(.orange)
        .navigationTitle("Learning Goal") // TEMP: wording
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    if needsConfirmation { showAlert = true } else { save() }
                } label: {
                    Image(systemName: "checkmark")
                }
            }
        }

        .alert("Update goal", isPresented: $showAlert) { // TEMP: wording
            Button("Dismiss", role: .cancel) { }
            Button("Update") { save() }
        } message: {
            Text("If you update now, your streak will start over.") // TEMP: wording
        }
    }
        
    private func save() {
        onSave(viewModel.makeGoal())
        dismiss()
    }
}
