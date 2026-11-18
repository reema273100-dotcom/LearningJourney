//
//  Duration.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//

import Foundation
// lists the only three vaild choices
//CaseIterable can loop over all cases
//Codeale for saving goals
enum Duration: String, CaseIterable, Codable {
    case week
    case month
    case year
    
    // How many freezes this length allows. Computed: nothing stored, the answer comes from self.
    var freezeLimit: Int {
        switch self {
        case .week:
            return 2
        case .month:
            return 8
        case .year:
            return 96
        }
    }
    
    
    //If a goal starts on this date, when does it end?
    func endDate(from start: Date) -> Date? {
        let component: Calendar.Component
        switch self {
        case .week:  component = .weekOfYear
        case .month: component = .month
        case .year:  component = .year
        }
        return Calendar.current.date(byAdding: component, value: 1, to: start)
    }
}
