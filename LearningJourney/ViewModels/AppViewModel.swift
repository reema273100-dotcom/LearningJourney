//
//  AppViewModel.swift
//  LearningJourney
//
//  Created by Reema on 06/06/1448 AH.
//

import Foundation
import Observation

@Observable
final class AppViewModel {
    var activityViewModel: ActivityViewModel?
    private let storage = StorageService()

    init() {
        if let goal = storage.load() { // yes: go straight to Activity
            activityViewModel = ActivityViewModel(goal: goal) // no: stays nil, Onboarding shows
        }
    }
    // Called when the user taps Start Learning.
    func start(with goal: Goal) {
        activityViewModel = ActivityViewModel(goal: goal)
    }
    // Debug menu: show a demo scenario WITHOUT saving it.
    func load(_ scenario: DemoScenario) {
        activityViewModel = ActivityViewModel(goal: scenario.makeGoal())
    }
    // Debug menu: forget the saved goal and show Onboarding again.
    func resetToOnboarding() {
        storage.clear()
        activityViewModel = nil
    }
}
