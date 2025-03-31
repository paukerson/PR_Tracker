//
//  ExerciseRowHeader.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI

/// Header section containing exercise name and last workout indicator
struct ExerciseRowHeader: View {
    let name: String
    let lastWorkoutText: String
    let hasGoal: Bool
    
    var body: some View {
        HStack {
            Text(name)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color("TextPrimary"))
            
            Spacer()
            
            Text(lastWorkoutText)
                .font(.caption)
                .padding(6)
                .background(
                    Capsule()
                        .fill(hasGoal ?
                            Color("PrimaryCoral").opacity(0.2) :
                            Color("SecondaryMint").opacity(0.2))
                )
                .foregroundColor(hasGoal ?
                               Color("PrimaryCoral") :
                               Color("SecondaryMint"))
        }
    }
}
