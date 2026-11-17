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
        if let goal = storage.load() {
            activityViewModel = ActivityViewModel(goal: goal)
        }
    }
    func start(with goal: Goal) {
        activityViewModel = ActivityViewModel(goal: goal)
    }
}
