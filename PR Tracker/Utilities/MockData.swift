//
//  MockData.swift
//  PR Tracker
//
//  Created by Jan Jędra on 29/03/2025.
//

import Foundation
import SwiftData

@MainActor
struct MockData {
    static let shared = MockData()
    private let modelContext: ModelContext
    
    init(modelContext: ModelContext? = nil) {
        self.modelContext = try! modelContext ?? ModelContainer(for: Exercise.self, Lift.self).mainContext
    }
    
    // MARK: - Exercises
    func generateExercises() -> [Exercise] {
        let exercises = [
            createBenchPress(),
            createSquat(),
        ]
        
        exercises.forEach { modelContext.insert($0) }
        try? modelContext.save()
        return exercises
    }
    
    private func createBenchPress() -> Exercise {
        let exercise = Exercise(
            name: "Bench Press",
            defaultTempo: [3, 1, 1]  // 3-1-1 tempo
        )
        exercise.setMuscles([.chestUpper, .tricepsLong])
        exercise.setEquipment(.barbell)
        
        // Add lifts
        exercise.addLift(weight: 60, reps: 10, rpe: 7)
        exercise.addLift(weight: 80, reps: 5, rpe: 8)
        exercise.addLift(weight: 100, reps: 1, rpe: 10)  // PR
        
        return exercise
    }
    
    private func createSquat() -> Exercise {
        let exercise = Exercise(name: "Back Squat")
        exercise.setMuscles([.quads, .glutes])
        exercise.setEquipment(.barbell)
        
        exercise.addLift(weight: 100, reps: 8)
        exercise.addLift(weight: 140, reps: 3)
        
        return exercise
    }
    
    // MARK: - Preview Support
    static var previewContainer: ModelContainer = {
        let schema = Schema([Exercise.self, Lift.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try! ModelContainer(for: schema, configurations: config)
    }()
}
