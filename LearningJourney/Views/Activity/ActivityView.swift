//
//  ActivityView.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//
import SwiftUI

struct ActivityView: View {
    let viewModel:ActivityViewModel
    var body: some View {
        VStack(spacing: 24) {
            // header, week strip
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Activity")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "calendar")
                            .foregroundStyle(Color.white)
                            .frame(width: 44, height: 44)
                            .background(Color.gray.opacity(0.3), in: Circle())
                    }
                    
                    Button {
                        
                    } label: {
                        Image(systemName: "pencil.and.outline").foregroundStyle(Color.white)
                            .frame(width: 44, height: 44)
                            .background(Color.gray.opacity(0.3), in: Circle())
                    }
                }
                
                Text(viewModel.dateText)
                    .foregroundStyle(.secondary)
            }
            
            HStack {
                //repeats the column seven times
                HStack {
                    ForEach(viewModel.weekDays) { day in
                        VStack(spacing: 8) {
                            Text(day.letter)
                                .font(.subheadline)
                                .fontWeight(.semibold)

                            Text("\(day.number)")
                                .font(.title3)
                                .frame(width: 44, height: 44)
                                .background(circleColor(for: day.state), in: Circle())
                                .foregroundStyle(numberColor(for: day.state))
                        }
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            HStack(spacing: 16) {
                CounterCardView(icon: "flame.fill", color: .orange,  value: viewModel.learnedText, label: "Learned")
                CounterCardView(icon: "snowflake", color: .cyan,  value: viewModel.frozenText, label: "Frozen")
            }
            
            VStack(spacing: 40) {
                Button {
                    viewModel.logLearned()
                } label: {
                    Circle()
                        .fill(Color.orange) // TEMP: color
                        .aspectRatio(1, contentMode: .fit)
                        .overlay {
                            Text(viewModel.logButtonTitle)
                                .font(.headline)
                                .foregroundStyle(Color.white)
                        }
                }
                .disabled(!viewModel.canLog)
                VStack(spacing: 12) {
                    Button {
                        viewModel.freezeToday()
                    } label: {
                        Text(viewModel.freezeButtonTitle)
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color.cyan, in: Capsule())
                    }
                    .disabled(!viewModel.canFreeze)
                    Text(viewModel.freezeCaption)
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 40)
            Spacer()
        }
        .padding(.horizontal, 20)
    }
}
private func circleColor(for state: DayState) -> Color {
    switch state {
    case .learned: return Color.orange.opacity(0.2) // TEMP: color
    case .frozen:  return Color.cyan.opacity(0.2)   // TEMP: color
    case .today:   return Color.orange              // TEMP: color
    case .none:    return Color.clear
    }
}

private func numberColor(for state: DayState) -> Color {
    switch state {
    case .learned: return Color.orange // TEMP: color
    case .frozen:  return Color.cyan   // TEMP: color
    case .today:   return Color.white
    case .none:    return Color.primary
    }
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
    ActivityView(viewModel: previewViewModel(today: .learned))
        .preferredColorScheme(.dark)
}

#Preview("3 Frozen today") {
    ActivityView(viewModel: previewViewModel(today: .frozen))
        .preferredColorScheme(.dark)
}

#Preview("4 Learned today, limit reached") {
    ActivityView(viewModel: previewViewModel(today: .learned, earlierFrozen: 2))
        .preferredColorScheme(.dark)
}

#Preview("5 Frozen today, limit reached") {
    ActivityView(viewModel: previewViewModel(today: .frozen, earlierFrozen: 1))
        .preferredColorScheme(.dark)
}
