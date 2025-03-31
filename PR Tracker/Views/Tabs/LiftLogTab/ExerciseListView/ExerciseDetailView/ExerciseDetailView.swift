//
//  ExerciseDetailView.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI

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
        }
        .navigationTitle(exercise.name)
        .toolbar {
            Button("Add Lift") { /* ... */ }
        }
    }
}
