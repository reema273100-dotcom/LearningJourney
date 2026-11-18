//
//  ActivityViewModel.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//

import Foundation
import Observation

@Observable // SwiftUI redraws any view that READ a property when it changes
final class ActivityViewModel {
    private let storage = StorageService()
    var goal: Goal
    
    init(goal: Goal) {
        self.goal = goal
    }
    
    //Counters
    var learnedCount: Int {
        goal.logs.filter { $0.status == .learned }.count
    }
    var frozenCount: Int {
        goal.logs.filter { $0.status == .frozen }.count
    }
    var freezesUsed: Int {
        frozenCount
    }
    var freezeLimit: Int {
        goal.duration.freezeLimit
    }
    
    var freezeCaption: String {
        "\(freezesUsed) out of \(freezeLimit) Freezes used"
    }
    
    //Today
    var todayLog: DayLog? {
        goal.logs.first { Calendar.current.isDate($0.date, inSameDayAs: .now) }
    }
    var logButtonTitle: String {
        todayLog?.status == .learned ? "Logged as Learned" : "Log as Learned"
    }
    var freezeButtonTitle: String {
        todayLog?.status == .frozen ? "Frozen for a day" : "Freeze for a day"
    }
    var canLog: Bool {
        goalState == .active && todayLog?.status != .learned
    }

    var canFreeze: Bool {
        goalState == .active && todayLog?.status != .frozen && freezesUsed < freezeLimit
    }
    
    // Actions
    func logLearned() {
        guard canLog else { return }
        setToday(.learned)
    }
    func freezeToday() {
        guard canFreeze else {return}
        setToday(.frozen)
    }
    private func setToday(_ status: DayStatus) {
        goal.logs.removeAll{ Calendar.current.isDate($0.date, inSameDayAs: .now)}
        // 1) delete any entry from today. This is the REPLACE rule (a day can't be both).

        goal.logs.append(DayLog(date: .now, status: status))
        // 2) add a fresh entry with the current time. The new time is when the user made the final choice.

        storage.save(goal)

    }
    //Week strip
    var weekDays: [WeekDay] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: .now)
        let weekday = calendar.component(.weekday, from: today) // 1 = Sunday
        let sunday = calendar.date(byAdding: .day, value: -(weekday - 1), to: today) ?? today
        
        return (0..<7).map { offset in
            let date = calendar.date(byAdding: .day, value: offset, to: sunday) ?? sunday
            let log = goal.logs.first { calendar.isDate($0.date, inSameDayAs: date) }
            
            let state: DayState
            if log?.status == .learned{
                state = .learned
            }
            else if log?.status == .frozen{
                state = .frozen
            }
            else if calendar.isDate(date, inSameDayAs: today){
                state = .today
            }
            else {
                state = .none
            }
            
            return WeekDay(
                id: date,
                letter: calendar.veryShortWeekdaySymbols[calendar.component(.weekday, from: date) - 1],
                number: calendar.component(.day, from: date),
                state: state
            )
            
        }
    }
            // Texts
            var dateText: String {
                let formatter = DateFormatter()// turns a Date into text
                formatter.dateFormat = "EEEE, d MMMM"
                return formatter.string(from: .now)
            }
            private func daysText(_ count: Int) -> String {
                // "1 day" when count is 1, otherwise "<count> days"
                count == 1 ? "1 day" : "\(count) days"
            }
            var learnedText: String {
                daysText(learnedCount)
            }
            var frozenText: String {
                daysText(frozenCount)
            }
    
    // Goal State
    private var totalDays: Int {
        guard let end = goal.endDate else { return 0 }
        return Calendar.current.dateComponents([.day], from: goal.startDate, to: end).day ?? 0
    }
    private var firstDayEnd: Date {
        Calendar.current.date(byAdding: .day, value: 1, to: goal.startDate) ?? goal.startDate
    }

    var goalState: GoalState {
        if totalDays > 0 && goal.logs.count >= totalDays {
            return .completed
        }

        if let end = goal.endDate, Date.now >= end {
            return .failed
        }

        let lastEntry = goal.logs.map(\.date).max() ?? firstDayEnd
        if Date.now.timeIntervalSince(lastEntry) > 32 * 60 * 60 {
            return .failed
        }

        return .active
    }
    
   // End screen wording and goal replacement
    var endTitle: String {
        goalState == .completed ? "Well done!" : "You didn't reach your goal this time."
    }

    var endSubtitle: String {
        goalState == .completed ? "Ready for your next goal?" : "Want to set another goal?"
    }

    var setGoalTitle: String { "Set a goal" }

    func replaceGoal(with newGoal: Goal) {
        var updated = newGoal
        updated.pastLogs = goal.pastLogs + goal.logs
        goal = updated
        storage.save(goal)
    }
}
        
