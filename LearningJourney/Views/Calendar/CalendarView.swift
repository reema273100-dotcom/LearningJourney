//
//  CalendarView.swift
//  LearningJourney
//
//  Created by Reema on 01/06/1448 AH.
//
import SwiftUI

struct CalendarView: View {
    let viewModel: CalendarViewModel
    private let columns = Array(repeating: GridItem(.flexible()), count: 7)

    var body: some View {
        ScrollView {
            LazyVStack(alignment: .leading, spacing: 24) {
                ForEach(viewModel.months) { month in
                    VStack(alignment: .leading, spacing: 12) {
                        Text(month.title).font(.headline)

                        LazyVGrid(columns: columns, spacing: 8) {
                            ForEach(viewModel.weekdayHeaders, id: \.self) { header in
                                Text(header)
                                    .font(.caption)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.secondary)
                            }
                            ForEach(month.days) { day in
                                if let number = day.number {
                                    Text("\(number)")
                                        .frame(width: 40, height: 40)
                                        .background(day.state.circleColor, in: Circle())
                                        .foregroundStyle(day.state.numberColor)
                                } else {
                                    Color.clear.frame(width: 40, height: 40)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.horizontal, 20)
        }
        .navigationTitle("Activities") // TEMP: wording
        .navigationBarTitleDisplayMode(.inline)
    }
}

