//
//  ExerciseDetailView.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI
import Charts

// TODO: works for now, work on UI later

struct ExerciseDetailView: View {
    @Bindable var exercise: Exercise
    
    var body: some View {
        List {
            Section("Stats") {
                Text("PR: \(exercise.prLift?.weight.formatted() ?? "--") kg × \(exercise.prLift?.reps.formatted() ?? "--")")
                Text("Total Lifts: \(exercise.lifts.count)")
            }
            
            Section("Recent Lifts") {
                ForEach(exercise.lifts.prefix(5)) { lift in
                    Text("\(lift.weight.formatted())kg × \(lift.reps)")
                }
            }
            
            Section("Chart") {
                ChartView(exercise: exercise)
            }
        }
        .navigationTitle(exercise.name)
        .toolbar {
            Button("Add Lift") { /* ... */ }
        }
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
    
    exercise.addLift(weight: 100, reps: 1, rpe: 10) // PR
    
    exercise.addLift(timestamp: Date.init(timeIntervalSinceNow: 86400 * 3), weight: 90, reps: 3, rpe: 9)
    exercise.addLift(timestamp: Date.init(timeIntervalSinceNow: 86400 * 7), weight: 80, reps: 3, rpe: 9)
    exercise.addLift(timestamp: Date.init(timeIntervalSinceNow: 86400 * 11), weight: 100, reps: 3, rpe: 9)
    
    
    return ExerciseDetailView(exercise: exercise)
}
