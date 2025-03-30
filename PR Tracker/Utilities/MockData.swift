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
        // 1. Use injected context if provided
        if let modelContext {
            self.modelContext = modelContext
            return
        }
        
        // 2. Otherwise create in-memory container
        do {
            let container = try ModelContainer(
                for: Exercise.self,
                Lift.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            self.modelContext = container.mainContext
        } catch {
            // 3. Fail clearly in development
            fatalError("""
            Failed to create mock container: \(error)
            - Check your model definitions
            - Verify no conflicting schema versions
            """)
        }
    }
    
    // MARK: - Exercises
    func generateExercises() -> [Exercise] {
        let exercises = [
            createBenchPress(),
            createSquat(),
            createDeadlift(),
//            createPullUp(),
            createOverheadPress(),
            createCableFly(),
            createBodyweightLunge()
        ]
        
        exercises.forEach { modelContext.insert($0) }
        try? modelContext.save()
        return exercises
    }
    
    // MARK: - Exercise Variations
    
    private func createBenchPress() -> Exercise {
        let exercise = Exercise(
            name: "Bench Press",
            defaultTempo: [3, 1, 1]
        )
        exercise.setMuscles([.chestUpper, .tricepsLong])
        exercise.setEquipment(.barbell)
        exercise.goalWeight = 120
        exercise.goalReps = 3
        
        exercise.addLift(weight: 60, reps: 10, rpe: 7)
        exercise.addLift(weight: 80, reps: 5, rpe: 8)
        exercise.addLift(weight: 100, reps: 1, rpe: 10) // PR
        return exercise
    }
    
    private func createSquat() -> Exercise {
        let exercise = Exercise(name: "Back Squat")
        exercise.setMuscles([.quads, .glutes])
        exercise.setEquipment(.barbell)
        exercise.goalWeight = 180
        exercise.goalReps = 2
        
        exercise.addLift(weight: 100, reps: 8)
        exercise.addLift(weight: 140, reps: 3)
        return exercise
    }
    
    private func createDeadlift() -> Exercise {
        let exercise = Exercise(name: "Deadlift")
        exercise.setMuscles([.glutes, .hamstrings, .erectorSpinae])
        exercise.setEquipment(.barbell)
        // No goal set
        
        exercise.addLift(weight: 120, reps: 5)
        exercise.addLift(weight: 160, reps: 3)
        return exercise
    }
    
#warning("FIX: doesnt work with weight 0")
//    private func createPullUp() -> Exercise {
//        let exercise = Exercise(name: "Pull Up")
//        exercise.setMuscles([.lats, .bicepsLong])
//        exercise.setEquipment(.bodyweight)
//        exercise.goalWeight = 0  // Bodyweight
//        exercise.goalReps = 12
//        
//        exercise.addLift(weight: 0, reps: 8)
//        exercise.addLift(weight: 0, reps: 10)
//        return exercise
//    }
    
    private func createOverheadPress() -> Exercise {
        let exercise = Exercise(name: "Overhead Press")
        exercise.setMuscles([.frontDelt, .tricepsLong])
        // No equipment set (should handle nil)
        exercise.goalWeight = 60
        exercise.goalReps = 5
        
        exercise.addLift(timestamp: Date(timeIntervalSinceNow: -400000) ,weight: 40, reps: 8)
        return exercise
    }
    
    private func createCableFly() -> Exercise {
        let exercise = Exercise(name: "Cable Fly")
        exercise.setMuscles([.chestMiddle])
        exercise.setEquipment(.cable)
        // No goals, no lifts added
        
        return exercise
    }
    
    private func createBodyweightLunge() -> Exercise {
        let exercise = Exercise(name: "Walking Lunge")
        // No muscles set
        exercise.setEquipment(.bodyweight)
        // No goals
        
        exercise.addLift(weight: 0, reps: 20)
        return exercise
    }
    
    // MARK: - Preview Support
    static var previewContainer: ModelContainer = {
        let schema = Schema([Exercise.self, Lift.self])
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        return try! ModelContainer(for: schema, configurations: config)
    }()
}
