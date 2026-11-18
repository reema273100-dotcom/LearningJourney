//
//  Goal.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//

import Foundation

// The user's current learning goal plus its entries.
struct Goal: Codable, Equatable {
    let subject: String
    let duration: Duration
    let startDate: Date
//the only part that changes during a goal
    var logs: [DayLog] = []
    var pastLogs: [DayLog] = []   // days from earlier goals, only shown on the calendar

    // the day after the last day of the goal 
    //a computed property that asks Duration for the end date
    var endDate: Date? {
        duration.endDate(from: startDate)
    }
}

