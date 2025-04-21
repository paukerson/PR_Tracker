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
    @State private var showAddLiftSheet: Bool = true
    
    // sorting by totalLifts, hasGoal
    private var exercisesSorted: [Exercise] {
        exercises.sorted(by: {
            $0.totalLifts != $1.totalLifts ? $0.totalLifts > $1.totalLifts : $0.hasGoal
        })
    }
    @State private var path = NavigationPath()
    
    
    var body: some View {
        
        NavigationStack(path: $path) {
            ExerciseListView(exercises: exercisesSorted)
                .navigationDestination(for: Exercise.self) { exercise in
                    ExerciseDetailView(exercise: exercise)
                }
        }
        .sheet(isPresented: $showAddLiftSheet) {
            AddLiftSheet(exercise: exercises.first!)
                .presentationDetents([.fraction(0.65), .fraction(0.9)])
        }
        
    }
}

#Preview {
    let mock = MockData(modelContext: MockData.previewContainer.mainContext)
    mock.generateExercises()
    
    
    return MainTabView()
        .modelContainer(MockData.previewContainer)
}
