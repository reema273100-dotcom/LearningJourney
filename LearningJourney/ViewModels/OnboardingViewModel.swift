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
    var subject = "" // what the user typed, starts empty
    var duration: Duration = .week // the selected pill. Week is preselected, so one is always chosen

    // Lets the Learning Goal page pre-fill the form with the current goal's values.
    init(subject: String = "", duration: Duration = .week) {
        self.subject = subject
        self.duration = duration
    }
    
    var finalSubject: String {
        let trimmed = subject.trimmingCharacters(in: .whitespacesAndNewlines)
        return trimmed.isEmpty ? "Swift" : trimmed // blank (or only spaces) → default "Swift"
    }
    
    // Builds the real Goal.
    func makeGoal() -> Goal {
        Goal(
            subject: finalSubject,
            duration: duration,
            startDate: Calendar.current.startOfDay(for: .now)
        )
    }
    
}
