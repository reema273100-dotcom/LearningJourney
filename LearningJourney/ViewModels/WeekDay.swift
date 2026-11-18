//
//  WeekDay.swift
//  LearningJourney
//
//  Created by Reema on 05/06/1448 AH.
//
import Foundation

// How one day circle in the week strip looks.
enum DayState {
    case learned
    case frozen
    case today      // today, nothing logged yet
    case none       // future days, or past days with no entry
}
// Everything the View needs to draw one column of the week strip.
struct WeekDay: Identifiable {
    let id: Date
    let letter: String
    let number: Int
    let state: DayState
}
