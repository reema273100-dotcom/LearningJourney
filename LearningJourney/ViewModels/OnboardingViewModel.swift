//
//  OnboardingViewModel.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//

import Foundation
import Observation

@Observable
final class OnboardingViewModel {
    var subject = ""
    var duration: Duration = .week

    var finalSubject: String {
        let trimmed = subject.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? "My Goal" : trimmed
    }
    func makeGoal() -> Goal {
        Goal(
            subject: finalSubject,
            duration: duration,
            startDate: Calendar.current.startOfDay(for: .now)
        )
    }
    init(subject: String = "", duration: Duration = .week) {
        self.subject = subject
        self.duration = duration
    }
}
