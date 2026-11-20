//
//  StorageService.swift
//  LearningJourney
//
//  Created by Reema on 06/06/1448 AH.
//

import Foundation

struct StorageService { // a struct: it only holds a key name, no changing state
    private let key = "savedGoal"

    func load() -> Goal? {
        guard let data = UserDefaults.standard.data(forKey: key) else {
            return nil
        }
        do {
            let goal = try JSONDecoder().decode(Goal.self, from: data)
            return goal
        } catch {
            return nil
        }
    }

    func save(_ goal: Goal) {
        do {
            let data = try JSONEncoder().encode(goal)
            UserDefaults.standard.set(data, forKey: key)
            
        } catch {}
    }
    func clear() {
        UserDefaults.standard.removeObject(forKey: key)
    }
}
