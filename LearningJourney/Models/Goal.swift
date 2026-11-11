//
//  Goal.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//

import Foundation

//Changing any of them means creating a new goal
struct Goal: Codable, Equatable {
    let subject: String
    let duration: Duration
    let startDate: Date
//the only part that changes during a goal
    var logs: [DayLog] = []

    // the day after the last day of the goal (exclusive, see RULES.md)
    //a computed property that asks Duration for the end date
    var endDate: Date? {
        duration.endDate(from: startDate)
    }
}

