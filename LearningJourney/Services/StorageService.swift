//
//  StorageService.swift
//  LearningJourney
//
//  Created by Reema on 06/06/1448 AH.
//

import Foundation

struct StorageService {
    private let key = "savedGoal"

    func load() -> Goal? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            print("STORAGE: nothing saved")
            return nil
        }
        do {
            let goal = try JSONDecoder().decode(Goal.self, from: data)
            print("STORAGE: loaded \(goal.subject), \(goal.logs.count) logs")
            return goal
        } catch {
            print("STORAGE: load failed: \(error)")
            return nil
        }
    }

    func save(_ goal: Goal) {
        do {
            let data = try JSONEncoder().encode(goal)
            UserDefaults.standard.set(data, forKey: key)
            print("STORAGE: saved \(goal.subject), \(goal.logs.count) logs")
        } catch {
            print("STORAGE: save failed: \(error)")
        }
    }
}
