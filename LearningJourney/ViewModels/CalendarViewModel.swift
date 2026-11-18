//
//  CalendarViewModel.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//

import Foundation
import Observation

struct CalendarDay: Identifiable {
    let id: Int
    let number: Int?   // nil = empty cell before the 1st
    let state: DayState
}

struct MonthSection: Identifiable {
    let id: Date
    let title: String
    let days: [CalendarDay]
}

@Observable
final class CalendarViewModel {
    let goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    private var allLogs: [DayLog] {
        goal.logs + goal.pastLogs
    }

    var weekdayHeaders: [String] {
        Calendar.current.shortWeekdaySymbols.map { $0.uppercased() }
    }

    var months: [MonthSection] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        
        let earliest = ([goal.startDate] + goal.pastLogs.map(\.date)).min() ?? goal.startDate
        guard var monthStart = calendar.dateInterval(of: .month, for: earliest)?.start else { return [] }
        
        let lastMonthStart = calendar.dateInterval(of: .month, for: today)?.start ?? monthStart

        var result: [MonthSection] = []
        while monthStart <= lastMonthStart {
            result.append(section(for: monthStart))
            guard let next = calendar.date(byAdding: .month, value: 1, to: monthStart) else { break }
            monthStart = next
        }
        return result
    }

    private func section(for monthStart: Date) -> MonthSection {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let dayCount = calendar.range(of: .day, in: .month, for: monthStart)?.count ?? 30
        let offset = calendar.component(.weekday, from: monthStart) - 1   // Sunday-first

        let numbers: [Int?] = Array(repeating: nil, count: offset) + (1...dayCount).map { Optional($0) }
        let days = numbers.enumerated().map { index, number -> CalendarDay in
            guard let number,
                  let date = calendar.date(byAdding: .day, value: number - 1, to: monthStart) else {
                return CalendarDay(id: index, number: nil, state: .none)
            }
            return CalendarDay(id: index, number: number, state: state(on: date, today: today))
        }

        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return MonthSection(id: monthStart, title: formatter.string(from: monthStart), days: days)
    }

    private func state(on date: Date, today: Date) -> DayState {
        let calendar = Calendar.current
        let log = allLogs.first { calendar.isDate($0.date, inSameDayAs: date) }
        if log?.status == .learned { return .learned }
        if log?.status == .frozen { return .frozen }
        if calendar.isDate(date, inSameDayAs: today) { return .today }
        return .none
    }
}
