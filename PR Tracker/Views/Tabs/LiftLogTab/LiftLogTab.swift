//
//  LiftLogTab.swift
//  PR Tracker
//
//  Created by Jan Jędra on 29/03/2025.
//

import Foundation
import SwiftUI
import SwiftData

struct LiftLogTab: View {
    
    @Query private var exercises: [Exercise]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack {
                    ForEach(exercises) { exercise in
                        ExerciseRow(exercise: exercise)
                    }
                }
                .padding([.horizontal, .top], 10)
            }
            .navigationTitle("Exercises")
        }

    }
}

#Preview {
    let mock = MockData(modelContext: MockData.previewContainer.mainContext)
    mock.generateExercises()
    
    return MainTabView()
        .modelContainer(MockData.previewContainer)
}

struct ExerciseRow: View {
    
    let exercise: Exercise
    
    var body: some View {
        NavigationLink {
            Text(exercise.name)
            List(exercise.lifts) { lift in
                Text("\(lift.weight)x\(lift.reps)")
            }
        } label: {
            ExerciseRowLabel(exercise: exercise)
        }
    }
}
