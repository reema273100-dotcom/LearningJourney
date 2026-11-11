//
//  DayStatus.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//

import Foundation

enum DayStatus: String, Codable {
    case learned
    case frozen

    var label: String {
        switch self {
        case .learned: return "Logged as Learnd"
        case .frozen: return "Frozen for a Day"
        }
    }
}
