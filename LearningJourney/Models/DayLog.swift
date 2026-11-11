//
//  DayLog.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//

import Foundation
//Codable: save and load logs later
//Equatable: to compare logs with ==
struct DayLog: Codable, Equatable {
    let date: Date
    let status: DayStatus
}
