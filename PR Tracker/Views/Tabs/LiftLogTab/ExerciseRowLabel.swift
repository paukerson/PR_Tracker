//
//  ExerciseRowLabel.swift
//  PR Tracker
//
//  Created by Jan Jędra on 30/03/2025.
//

import SwiftUI

struct ExerciseRowLabel: View {
    let exercise: Exercise
    
    var body: some View {
        ZStack {
            // Background with conditional opacity
            exerciseBackground
            
            // Content
            VStack(alignment: .leading, spacing: 8) {
                headerRow
                
                if exercise.hasGoal {
                    goalProgressSection
                } else {
                    basicStatsSection
                }
                
                muscleTags
            }
            .padding(12)
        }
        .frame(height: 120)
        .overlay(borderOverlay)
    }
    
    // MARK: - Conditional Subviews
    
    // MARK: - Background
    
    private var exerciseBackground: some View {
        ZStack {
            // Base card style (consistent for all)
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("CardBackground"))
                .shadow(color: .black.opacity(0.05), radius: 5, x: 0, y: 2)
            
            // Goal overlay (adds premium feel)
            if exercise.hasGoal {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [Color("PrimaryCoral").opacity(0.15), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("PrimaryCoral").opacity(0.3), lineWidth: 1)
                    )
            }
        }
    }
    
    // MARK: - Border
    private var borderOverlay: some View {
        RoundedRectangle(cornerRadius: 12)
            .stroke(
                exercise.hasGoal ?
                Color("AccentOrange").opacity(0.3) :
                Color("PrimaryBlue").opacity(0.3),
                lineWidth: 1
            )
    }
    
    // MARK: - Header
    private var headerRow: some View {
        HStack {
            Text(exercise.name)
                .font(.system(size: 17, weight: .semibold))
                .foregroundColor(Color("TextPrimary"))
            
            Spacer()
            
            Text(lastWorkoutText)
                .font(.caption)
                .padding(6)
                .background(
                    Capsule()
                        .fill(exercise.hasGoal ?
                              Color("PrimaryCoral").opacity(0.2) :
                              Color("SecondaryMint").opacity(0.2))
                )
                .foregroundColor(exercise.hasGoal ?
                                 Color("PrimaryCoral") :
                                 Color("SecondaryMint"))
        }
    }
    
    // MARK: Progress
    
    private var goalProgressSection: some View {
        VStack(spacing: 8) {
            // Progress bar with mint accent
            ProgressView(value: exercise.goalProgress)
                .tint(Color("SecondaryMint"))
                .scaleEffect(x: 1, y: 1.5, anchor: .leading)
            
            HStack {
                PRBadge(
                    weight: exercise.prLift?.weight ?? 0,
                    reps: exercise.prLift?.reps ?? 0)
                Spacer()
                GoalBadge(weight: exercise.goalWeight ?? 0, reps: exercise.goalReps ?? 0)
            }
        }
    }
    
    // MARK: - Stats Section
    
    private var basicStatsSection: some View {
        HStack {
            StatBadge(title: "PR",
                     value: "\(exercise.prLift?.weight.formatted() ?? "--")kg × \(exercise.prLift?.reps.formatted() ?? "--")",
                     color: Color("SecondaryMint"))
            
            Spacer()
            
            StatBadge(title: "Total",
                     value: "\(exercise.lifts.count)",
                     color: Color("TextSecondary"))
        }
    }
    
    // MARK: - Muscle Tags
    private var muscleTags: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 6) {
                ForEach(exercise.targetedMuscles, id: \.self) { muscle in
                    Text(muscle.muscle)
                        .font(.caption2)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(
                            Capsule()
                                .fill(
                                    exercise.hasGoal ?
                                    Color("AccentOrange").opacity(0.2) :
                                    Color("PrimaryBlueLowOpacity")
                                )
                        )
                        .foregroundStyle(
                            exercise.hasGoal ?
                            Color("TextSecondary"):
                            Color("TextSecondary")
                        )
                }
            }
        }
    }
    
    // MARK: - Helpers
    
    private var hasGoal: Bool {
        exercise.goalWeight != nil && exercise.goalReps != nil
    }
    
    private var lastWorkoutText: String {
        guard let lastDate = exercise.lifts.max(by: { $0.timestamp < $1.timestamp })?.timestamp else {
            return "Never"
        }
        let days = Calendar.current.dateComponents([.day], from: lastDate, to: Date()).day ?? 0
        return days == 0 ? "Today" : "\(days)d ago"
    }
    
    private var formattedCurrent1RM: String {
        guard let orm = exercise.oneRepMax else { return "--" }
        return "\(orm.formatted(.number.precision(.fractionLength(1)))) kg"
    }
    
    private var formattedGoal1RM: String {
        guard let goal = exercise.goalOneRepMax else { return "--" }
        return "\(goal.formatted(.number.precision(.fractionLength(1)))) kg"
    }
}

 // MARK: SUPPORTING VIEWS

struct PRBadge: View {
    let weight: Double
    let reps: Int
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "crown.fill")
                .foregroundStyle(Color("PrimaryCoral"))
            Text("PR: \(weight.formatted())kg x \(reps)")
                .font(.system(.caption, design: .monospaced))
        }
    }
}

struct GoalBadge: View {
    let weight: Double
    let reps: Int
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "flag.fill")
                .foregroundStyle(Color("SecondaryMint"))
            Text("Goal: \(weight.formatted())kg × \(reps)")
                .font(.system(.caption, design: .monospaced))
        }
    }
}

struct StatBadge: View {
    let title: String
    let value: String
    let color: Color
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption2)
                .foregroundStyle(color.opacity(0.8))
            Text(value)
                .font(.system(.subheadline, design: .rounded))
        }
    }
}
