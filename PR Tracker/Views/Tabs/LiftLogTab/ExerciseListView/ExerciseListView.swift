//
//  ExerciseRow.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI

struct ExerciseListView: View {
    let exercises: [Exercise]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 10) {
                ForEach(exercises) { exercise in
                    NavigationLink(value: exercise) {
                        ExerciseRowLabel(exercise: exercise)
                    }
                }
            }
            .padding(.horizontal, 10)
        }
        .scrollIndicators(.never)
        .navigationTitle("Exercises")
    }
}
