//
//  DemoData.swift
//  LearningJourney
//
//  Created by Reema on 07/06/1448 AH.
//
import Foundation

enum DemoScenario: String, CaseIterable, Identifiable {
    case freshGoal = "Fresh goal"
    case learnedToday = "Learned today"
    case frozenToday = "Frozen today"
    case freezesUsedUp = "All freezes used"
    case goalFailed = "Goal failed"
    case goalCompleted = "Goal completed"
    case monthWithHistory = "Month goal with history"
    case yearWithHistory = "Year goal with past months"

    var id: String { rawValue }

    func makeGoal() -> Goal {
        switch self {
        case .freshGoal:
            return makeDemoGoal(.week, startedDaysAgo: 0, entries: [])
        case .learnedToday:
            return makeDemoGoal(.week, startedDaysAgo: 3, entries: [
                (3, .learned), (2, .learned), (1, .learned), (0, .learned)
            ])
        case .frozenToday:
            return makeDemoGoal(.week, startedDaysAgo: 2, entries: [
                (2, .learned), (1, .learned), (0, .frozen)
            ])
        case .freezesUsedUp:
            return makeDemoGoal(.week, startedDaysAgo: 4, entries: [
                (4, .learned), (3, .frozen), (2, .frozen), (1, .learned)
            ])
        case .goalFailed:
            return makeDemoGoal(.week, startedDaysAgo: 5, entries: [
                (5, .learned), (4, .learned)
            ])
        case .goalCompleted:
            return makeDemoGoal(.week, startedDaysAgo: 6, entries: [
                (6, .learned), (5, .learned), (4, .frozen), (3, .learned),
                (2, .learned), (1, .learned), (0, .learned)
            ])
        case .monthWithHistory:
            let current = (0...12).map { day in
                (daysAgo: day, status: day == 4 ? DayStatus.frozen : DayStatus.learned)
            }
            let history = (Array(30...38) + Array(45...52)).map { day in
                (daysAgo: day, status: DayStatus.learned)
            }
            return makeDemoGoal(.month, startedDaysAgo: 12, entries: current, history: history)
        case .yearWithHistory:
            let current = (0...100).map { day in
                (daysAgo: day, status: day % 13 == 6 ? DayStatus.frozen : DayStatus.learned)
            }
            let history = (Array(110...125) + Array(140...160)).map { day in
                (daysAgo: day, status: DayStatus.learned)
            }
            return makeDemoGoal(.year, startedDaysAgo: 100, entries: current, history: history)
        }
    }
}

private func makeDemoGoal(
    _ duration: Duration,
    startedDaysAgo: Int,
    entries: [(daysAgo: Int, status: DayStatus)],
    history: [(daysAgo: Int, status: DayStatus)] = []
) -> Goal {
    let calendar = Calendar.current
    let start = calendar.date(byAdding: .day, value: -startedDaysAgo, to: calendar.startOfDay(for: .now)) ?? .now

    func log(_ entry: (daysAgo: Int, status: DayStatus)) -> DayLog {
        DayLog(date: calendar.date(byAdding: .day, value: -entry.daysAgo, to: .now) ?? .now, status: entry.status)
    }

    var goal = Goal(subject: "Swift", duration: duration, startDate: start, logs: entries.map(log))
    goal.pastLogs = history.map(log)
    return goal
}
