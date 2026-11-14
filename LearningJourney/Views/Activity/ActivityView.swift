//
//  ActivityView.swift
//  LearningJourney
//
//  Created by Reema on 30/05/1448 AH.
//
import SwiftUI

struct ActivityView: View {
    // TEMP: fake data, replaced by ActivityViewModel later
    private let weekdays = ["S", "M", "T", "W", "T", "F", "S"]
    private let dayNumbers = [20, 21, 22, 23, 24, 25, 26]
    private let todayIndex = 4
    private let learnedCount = 4
    private let frozenCount = 0
    private let freezesUsed = 0
    private let freezeLimit = 2
    
    
    var body: some View {
        VStack(spacing: 24) {
            // header, week strip, counters, buttons
            VStack(alignment: .leading, spacing: 4) {
                HStack {
                    Text("Activity")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                    
                    Spacer()
                    
                    Button {
                        // no action yet: opens the Calendar page later
                    } label: {
                        Image(systemName: "calendar")
                            .foregroundStyle(Color.white)
                            .frame(width: 44, height: 44)
                            .background(Color.gray.opacity(0.3), in: Circle())
                    }
                    
                    Button {
                        // no action yet: opens Change Goal later
                    } label: {
                        Image(systemName: "pencil.and.outline").foregroundStyle(Color.white)
                            .frame(width: 44, height: 44)
                            .background(Color.gray.opacity(0.3), in: Circle())
                    }
                }
                
                Text("Thursday, 24 October") // TEMP: real date comes from the ViewModel
                    .foregroundStyle(.secondary)
                
                
            }
            HStack {
                //repeats the column seven times
                ForEach(0..<7, id: \.self) { index in
                    VStack(spacing: 8) {
                        Text(weekdays[index])
                            .font(.subheadline)
                            .fontWeight(.semibold)
                        
                        Text("\(dayNumbers[index])")
                            .font(.title3)
                            .frame(width: 44, height: 44)
                            .background(
                                index < todayIndex ? Color.orange.opacity(0.2) : (index == todayIndex ? Color.orange : Color.clear),
                                in: Circle()
                            ) // TEMP: this decision moves to the ViewModel
                            .foregroundStyle(index == todayIndex ? .white : (index < todayIndex ? .orange : .white))
                    }
                    .frame(maxWidth: .infinity)
                }
            }
            HStack(spacing: 16) {
                CounterCardView(icon: "flame.fill", color: .orange, value: "\(learnedCount) days", label: "Learned")
                CounterCardView(icon: "snowflake", color: .cyan, value: "\(frozenCount) days", label: "Frozen")
            }
            
            VStack(spacing: 40) {
                Button {
                    // no action yet: logLearned() in the ViewModel later
                } label: {
                    Circle()
                        .fill(Color.orange) // TEMP: color
                        .aspectRatio(1, contentMode: .fit)
                        .overlay {
                            Text("Log as Learned") // TEMP: wording moves to the ViewModel
                                .font(.headline)
                                .foregroundStyle(Color.white)
                        }
                }
                VStack(spacing: 12) {
                    Button {
                        // no action yet: freezeToday() in the ViewModel later
                    } label: {
                        Text("Freeze for a day") // TEMP: wording moves to the ViewModel
                            .font(.headline)
                            .foregroundStyle(Color.white)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 15)
                            .background(Color.cyan, in: Capsule()) // TEMP: color
                    }
                    
                    Text("\(freezesUsed) out of \(freezeLimit) Freezes used") // TEMP: wording moves to the ViewModel
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
            }
            .padding(.horizontal, 40)
            
        }
        .padding(.horizontal, 20);
    }
}


#Preview {
    ActivityView()
        .preferredColorScheme(.dark)
}
