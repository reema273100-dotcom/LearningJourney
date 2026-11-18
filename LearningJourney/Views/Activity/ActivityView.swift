//
//  ActivityView.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//
import SwiftUI

struct ActivityView: View {
    let viewModel:ActivityViewModel
    @State private var showGoalEditor = false

    var body: some View {
        VStack(spacing: 24) {
            // header, week strip
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Activity")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    NavigationLink {
                        CalendarView(viewModel: CalendarViewModel(goal: viewModel.goal))
                    } label: {
                        Image(systemName: "calendar")
                            .foregroundStyle(Color.white)
                            .frame(width: 44, height: 44)
                            .glassEffect(.regular.interactive(), in: Circle())
                    }
                    
                    Button {
                        showGoalEditor = true

                    } label: {
                        Image(systemName: "pencil.and.outline").foregroundStyle(Color.white)
                            .frame(width: 44, height: 44)
                            .glassEffect(.regular.interactive(), in: Circle())
                    }
                    
                }
                
                Text(viewModel.dateText)
                    .foregroundStyle(.secondary)
            }
            HStack {
                ForEach(viewModel.weekDays) { day in
                    VStack(spacing: 8) {
                        Text(day.letter)
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Text("\(day.number)")
                            .font(.title3)
                            .frame(width: 44, height: 44)
                            .background(day.state.circleColor, in: Circle())
                            .foregroundStyle(day.state.numberColor)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            
            HStack(spacing: 16) {
                CounterCardView(icon: "flame.fill", color: .orange,  value: viewModel.learnedText, label: "Learned")
                CounterCardView(icon: "snowflake", color: .cyan,  value: viewModel.frozenText, label: "Frozen")
            }
            
            if viewModel.goalState == .active {
                actionArea
            } else {
                
                endState
                    .padding(.top, 60)
            }
            Spacer()
            
        }
        .padding(.horizontal, 20)
        .navigationDestination(isPresented: $showGoalEditor) {
            GoalEditView(goal: viewModel.goal, needsConfirmation: viewModel.goalState == .active) { newGoal in
                viewModel.replaceGoal(with: newGoal)
            }
        }
        .toolbar(.hidden, for: .navigationBar)
    }
    
    private var actionArea: some View {
        VStack(spacing: 40) {
            Button {
                viewModel.logLearned()
            } label: {
                Color.clear
                    .aspectRatio(1, contentMode: .fit)
                    .overlay {
                        Text(viewModel.logButtonTitle)
                            .font(.headline)
                            .foregroundStyle(viewModel.canLog ? Color.white : Color.gray)
                    }
                    .glassEffect(logGlass, in: Circle())
            }
            .disabled(!viewModel.canLog)
            VStack(spacing: 12) {
                Button {
                    viewModel.freezeToday()
                } label: {
                    Text(viewModel.freezeButtonTitle)
                        .font(.headline)
                        .foregroundStyle(viewModel.canFreeze ? Color.white : Color.gray)
                        .frame(maxWidth: .infinity)
                        .padding(.vertical, 15)
                        .glassEffect(freezeGlass, in: Capsule())
                }
                .disabled(!viewModel.canFreeze)
                Text(viewModel.freezeCaption)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.horizontal, 40)
        
    }
    private var logGlass: Glass {
        if viewModel.canLog {
            return Glass.regular.tint(.orange).interactive()
        } else {
            return Glass.regular
        }
    }

    private var freezeGlass: Glass {
        if viewModel.canFreeze {
            return Glass.regular.tint(.cyan).interactive()
        } else {
            return Glass.regular
        }
    }
    private var endState: some View {
        VStack(spacing: 16) {
            Image(systemName: viewModel.goalState == .completed ? "hands.clap.fill" : "xmark.seal.fill")
                .font(.system(size: 48))
                .foregroundStyle(Color.orange) // TEMP: color
            Text(viewModel.endTitle).font(.headline)
            Text(viewModel.endSubtitle).font(.subheadline).foregroundStyle(.secondary)
            Button {
                showGoalEditor = true
            } label: {
                Label(viewModel.setGoalTitle, systemImage: "pencil.and.outline")
                    .font(.headline)
                    .foregroundStyle(Color.white)
                    .padding(.horizontal, 24)
                    .padding(.vertical, 14)
                    .glassEffect(.regular.tint(.orange).interactive(), in: Capsule())

            }
        }
    }
}

private func scenarioViewModel(
    duration: Duration = .week,
    startedDaysAgo: Int,
    entries: [(hoursAgo: Double, status: DayStatus)]
) -> ActivityViewModel {
    let calendar = Calendar.current
    let start = calendar.date(
        byAdding: .day,
        value: -startedDaysAgo,
        to: calendar.startOfDay(for: .now)
    )!
    
    let logs = entries.map { entry in
        DayLog(date: Date.now.addingTimeInterval(-entry.hoursAgo * 3600), status: entry.status)
    }
    
    let goal = Goal(subject: "Swift", duration: duration, startDate: start, logs: logs)
    return ActivityViewModel(goal: goal)
}

private func previewViewModel(today: DayStatus?, earlierFrozen: Int = 0) -> ActivityViewModel {
    let calendar = Calendar.current
    let start = calendar.startOfDay(for: .now)
    var logs: [DayLog] = []
    
    // today's entry, if any
    if let today {
        logs.append(DayLog(date: .now, status: today))
    }
    
    // four earlier days: the first `earlierFrozen` of them are frozen, the rest learned
    for offset in 1...4 {
        let date = calendar.date(byAdding: .day, value: -offset, to: start)!
        let status: DayStatus = offset <= earlierFrozen ? .frozen : .learned
        logs.append(DayLog(date: date, status: status))
    }
    
    let goalStart = calendar.date(byAdding: .day, value: -4, to: start)!
    let goal = Goal(subject: "Swift", duration: .week, startDate: goalStart, logs: logs)
    return ActivityViewModel(goal: goal)
}
#Preview("1 No entry today") {
    ActivityView(viewModel: previewViewModel(today: nil))
        .preferredColorScheme(.dark)
}

#Preview("2 Learned today") {
    NavigationStack {
        ActivityView(viewModel: previewViewModel(today: .learned))
    }
        .preferredColorScheme(.dark)
}

#Preview("3 Frozen today") {
    NavigationStack {
        ActivityView(viewModel: previewViewModel(today: .frozen))
    }
        .preferredColorScheme(.dark)
}

#Preview("4 Learned today, limit reached") {
    NavigationStack {
        ActivityView(viewModel: previewViewModel(today: .learned, earlierFrozen: 2))
    }
        .preferredColorScheme(.dark)
}

#Preview("5 Frozen today, limit reached") {
    NavigationStack {
        ActivityView(viewModel: previewViewModel(today: .frozen, earlierFrozen: 1))
    }
        .preferredColorScheme(.dark)
}
#Preview("A active: started today, no entries") {
    NavigationStack {
        ActivityView(viewModel: scenarioViewModel(startedDaysAgo: 0, entries: []))
    }
        .preferredColorScheme(.dark)
}

#Preview("B active: started yesterday, no entries") {
    NavigationStack {
        ActivityView(viewModel: scenarioViewModel(startedDaysAgo: 1, entries: []))
    }
        .preferredColorScheme(.dark)
}

#Preview("C failed: started 3 days ago, no entries") {
    NavigationStack {
        ActivityView(viewModel: scenarioViewModel(startedDaysAgo: 3, entries: []))
    }
        .preferredColorScheme(.dark)
}

#Preview("D active: last entry 31h ago") {
    NavigationStack {
        ActivityView(viewModel: scenarioViewModel(startedDaysAgo: 4, entries: [(31, .learned)]))
    }
        .preferredColorScheme(.dark)
}

#Preview("E failed: last entry 33h ago") {
    NavigationStack {
        ActivityView(viewModel: scenarioViewModel(startedDaysAgo: 4, entries: [(33, .learned)]))
    }
        .preferredColorScheme(.dark)
}

#Preview("F failed: end date passed") {
    NavigationStack {
        ActivityView(viewModel: scenarioViewModel(startedDaysAgo: 8, entries: [(1, .learned)]))
    }
        .preferredColorScheme(.dark)
}

#Preview("G completed: all 7 days covered") {
    NavigationStack {
        ActivityView(viewModel: scenarioViewModel(startedDaysAgo: 6, entries: [
            (1, .learned), (2, .frozen), (3, .learned), (4, .learned),
            (5, .learned), (6, .learned), (7, .learned)
        ]))
    }
    .preferredColorScheme(.dark)
}

#Preview("H completed beats failed") {
    NavigationStack {
        ActivityView(viewModel: scenarioViewModel(startedDaysAgo: 10, entries: [
            (100, .learned), (101, .learned), (102, .learned), (103, .learned),
            (104, .learned), (105, .learned), (106, .learned)
        ]))
    }
    .preferredColorScheme(.dark)
}

#Preview("I active: month goal, 10 days in") {
    NavigationStack {
        ActivityView(viewModel: scenarioViewModel(duration: .month, startedDaysAgo: 10, entries: [(5, .learned)]))
    }
        .preferredColorScheme(.dark)
}
