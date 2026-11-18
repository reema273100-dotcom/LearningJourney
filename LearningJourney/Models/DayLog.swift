//
//  DayLog.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//

import Foundation
// One entry: "at this date and time, the day was learned / frozen".
//Equatable: to compare logs with ==
struct DayLog: Codable, Equatable {
    let date: Date
    let status: DayStatus
}
