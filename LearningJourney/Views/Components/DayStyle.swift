//
//  DayStyle.swift
//  LearningJourney
//
//  Created by Reema on 07/06/1448 AH.
//

 import SwiftUI

extension DayState {
    var circleColor: Color {
        switch self {
        case .learned: return Color.orange.opacity(0.2) // TEMP: color
        case .frozen:  return Color.cyan.opacity(0.2)   // TEMP: color
        case .today:   return Color.orange              // TEMP: color
        case .none:    return Color.clear
        }
    }

    var numberColor: Color {
        switch self {
        case .learned: return Color.orange // TEMP: color
        case .frozen:  return Color.cyan   // TEMP: color
        case .today:   return Color.white
        case .none:    return Color.primary
        }
    }
}
