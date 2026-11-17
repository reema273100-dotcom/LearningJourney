//
//  CounterCardView.swift
//  LearningJourney
//
//  Created by Reema on 04/06/1448 AH.
//

import Foundation
import SwiftUI

struct CounterCardView: View {
    let icon: String
    let color: Color
    let value: String
    let label: String

    var body: some View {
        // the VStack, frame, padding, and background from one card go here
        VStack(spacing: 6) {
            Image(systemName: icon)
                .foregroundStyle(color)
            Text(value)
            // TEMP: wording moves to the ViewModel
                .fontWeight(.bold)
            Text(label)
                .font(.subheadline)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 20)
        .glassEffect(in: RoundedRectangle(cornerRadius: 28))
        
        // use icon, color, value, and label instead of the hardcoded values
    }
}

#Preview {
    CounterCardView(icon: "flame.fill", color: .orange, value: "4 days", label: "Learned")
        .preferredColorScheme(.dark)
}
