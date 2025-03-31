//
//  ExerciseRowTags.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI

/// Horizontal scroll view of muscle tags
struct ExerciseRowTags: View {
    let muscles: [ExerciseMuscle]
    let hasGoal: Bool
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(muscles, id: \.self) { muscle in
                    Text(muscle.muscle)
                        .font(.caption2)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(hasGoal ?
                                    Color("PrimaryCoral").opacity(0.2) :
                                    Color("SecondaryMint").opacity(0.2))
                        )
                        .foregroundColor(Color("TextSecondary"))
                }
            }
        }
    }
}
