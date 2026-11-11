//
//  Duration.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//

import Foundation
import SwiftUI
// lists the only three vaild choices
//CaseIterable adds Duration.allCases, which the Picker uses to build its Week / Month / Year options without writing them twice
//Codeale for saving goals
enum Duration: String, CaseIterable, Codable {
    case week
    case month
    case year
    
    //computed property, works out its answer each time from self
    // switch self: looks at which case this Duration is. and returns the number
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
    // text shown to the user, separate from rawValue (which is used for saving)
    var title: String {
        switch self {
        case .week:  return "Week"
        case .month: return "Month"
        case .year:  return "Year"
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
#Preview {
    let start = Calendar.current.startOfDay(for: .now)
    VStack {
        ForEach(Duration.allCases, id: \.self) { duration in
            let end = duration.endDate(from: start)
            Text("\(duration.title): \(duration.freezeLimit) freezes, ends \(end?.formatted(date: .abbreviated, time: .omitted) ?? "nil")")
        }
    }
}
