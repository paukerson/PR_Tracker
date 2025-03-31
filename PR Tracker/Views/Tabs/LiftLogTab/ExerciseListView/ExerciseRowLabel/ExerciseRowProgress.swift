//
//  ExerciseRowProgress.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI

/// Progress section for exercises with goals
/// Shows progress bar and PR/Goal badges
struct ExerciseRowProgress: View {
    let progress: Double
    let prWeight: Double
    let prReps: Int
    let goalWeight: Double
    let goalReps: Int
    
    var body: some View {
        VStack(spacing: 8) {
            ProgressView(value: progress)
                .tint(Color("SecondaryMint"))
                .scaleEffect(x: 1, y: 1.5, anchor: .leading)
            
            HStack {
                PRBadge(weight: prWeight, reps: prReps)
                Spacer()
                GoalBadge(weight: goalWeight, reps: goalReps)
            }
        }
    }
}
