//
//  ExerciseRowLabel.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI

/// Primary container view for exercise rows in lists
/// Handles layout and switches between goal/non-goal states
struct ExerciseRowLabel: View {
    let exercise: Exercise
    
    var body: some View {
        ZStack {
            // Background Layer
            ExerciseRowBackground(hasGoal: exercise.hasGoal)
            
            // Content Layer
            VStack(alignment: .leading, spacing: 8) {
                ExerciseRowHeader(
                    name: exercise.name,
                    lastWorkoutText: lastWorkoutText,
                    hasGoal: exercise.hasGoal
                )
                
                if exercise.hasGoal {
                    ExerciseRowProgress(
                        progress: exercise.goalProgress,
                        prWeight: exercise.prLift?.weight ?? 0,
                        prReps: exercise.prLift?.reps ?? 0,
                        goalWeight: exercise.goalWeight ?? 0,
                        goalReps: exercise.goalReps ?? 0
                    )
                } else {
                    ExerciseRowStats(
                        prText: prText,
                        totalLifts: exercise.lifts.count
                    )
                }
                
                ExerciseRowTags(muscles: exercise.targetedMuscles, hasGoal: exercise.hasGoal)
            }
            .padding(12)
        }
        .frame(height: 120)
    }
    
    // MARK: - Computed Properties
    
    private var lastWorkoutText: String {
        guard let lastDate = exercise.lifts.max(by: { $0.timestamp < $1.timestamp })?.timestamp else {
            return "Never"
        }
        let days = Calendar.current.dateComponents([.day], from: lastDate, to: Date()).day ?? 0
        return days == 0 ? "Today" : "\(days)d ago"
    }
    
    private var prText: String {
        "\(exercise.prLift?.weight.formatted() ?? "--")kg × \(exercise.prLift?.reps.formatted() ?? "--")"
    }
}
