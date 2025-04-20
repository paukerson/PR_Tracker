//
//  ChartView.swift
//  PR Tracker
//
//  Created by Jan Jędra on 20/04/2025.
//

import Foundation
import Charts
import SwiftUI

// TODO: fix chart sizing, colors

struct ChartView: View {
    var exercise: Exercise
    
    // Color gradient for the chart
    let gradient = LinearGradient(
        gradient: Gradient(colors: [.blue, .purple]),
        startPoint: .bottom,
        endPoint: .top
    )
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Performance Over Time")
                .font(.headline)
                .padding(.leading)
            
            Chart {
                // Line Chart
                ForEach(exercise.lifts.sorted(by: { $0.timestamp < $1.timestamp })) { lift in
                    LineMark(
                        x: .value("Date", lift.timestamp, unit: .day),
                        y: .value("Weight", lift.weight)
                    )
                    .lineStyle(StrokeStyle(lineWidth: 3))
                    .symbol(Circle().strokeBorder(lineWidth: 2))
                    .foregroundStyle(.purple)
                }
                
                
                // Option 3: Rule Mark for PR (uncomment to use)
                if let pr = exercise.prLift {
                    RuleMark(
                        y: .value("PR", pr.weight)
                    )
                    .foregroundStyle(.red)
                    .lineStyle(StrokeStyle(lineWidth: 1, dash: [5]))
                    .annotation(position: .trailing) {
                        Text("PR: \(pr.weight) kg")
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                }
            }
            .chartXAxis {
                AxisMarks(values: .stride(by: .month)) { value in
                    AxisGridLine()
                    AxisTick()
                    AxisValueLabel(format: .dateTime.day().month(.defaultDigits))
                }
            }
            .chartYAxis {
                AxisMarks(position: .leading)
            }
            .frame(height: 300)
            .padding()
            
            // Stats Summary
            HStack {
                PRBadge(weight: exercise.prLift?.weight ?? 0, reps: exercise.prLift?.reps ?? 0)
                StatBadge(title: "Total", value: exercise.lifts.count.formatted())
            }
            .padding(.horizontal)
        }
    }
}

// Array extension for average calculation
extension Array where Element == Double {
    func average() -> Double {
        guard !isEmpty else { return 0 }
        return reduce(0, +) / Double(count)
    }
}

#Preview {
    let exercise = Exercise(
        name: "Bench Press",
        defaultTempo: [3, 1, 1]
    )
    exercise.setMuscles([.chestUpper, .tricepsLong])
    exercise.setEquipment(.barbell)
    exercise.goalWeight = 120
    exercise.goalReps = 3
    
    exercise.addLift(timestamp: Date.init(timeIntervalSinceNow: -86400 * 10), weight: 90, reps: 3, rpe: 9)
    exercise.addLift(timestamp: Date.init(timeIntervalSinceNow: -86400 * 6), weight: 80, reps: 3, rpe: 9)
    exercise.addLift(timestamp: Date.init(timeIntervalSinceNow: -86400 * 3), weight: 100, reps: 3, rpe: 9)
    
//    exercise.addLift(weight: 60, reps: 10, rpe: 7)
//    exercise.addLift(weight: 80, reps: 5, rpe: 8)
    exercise.addLift(weight: 100, reps: 1, rpe: 10) // PR
    
    exercise.addLift(timestamp: Date.init(timeIntervalSinceNow: 86400 * 3), weight: 90, reps: 3, rpe: 9)
    exercise.addLift(timestamp: Date.init(timeIntervalSinceNow: 86400 * 7), weight: 80, reps: 3, rpe: 9)
    exercise.addLift(timestamp: Date.init(timeIntervalSinceNow: 86400 * 11), weight: 100, reps: 3, rpe: 9)
    
    
    return ExerciseDetailView(exercise: exercise)
}
