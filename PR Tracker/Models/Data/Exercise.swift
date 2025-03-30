//
//  Exercise.swift
//  PR Tracker
//
//  Created by Jan Jędra on 29/03/2025.
//

import Foundation
import SwiftData

// MARK: - Exercise
@Model
final class Exercise {
    
    // MARK: Attributes
    @Attribute(.unique) var id: UUID
    var name: String
    var defaultTempo: [Int]  // [Eccentric, Pause, Concentric]
    var targetedMuscles: [ExerciseMuscle] = []
    
    @Relationship(inverse: \Equipment.exercises)
    var equipment: Equipment?
    
    var lifts: [Lift] = []
    
    @Relationship
    private var _prLift: Lift?  // SwiftData-managed PR reference
    
    // Computed property for easy access
    var prLift: Lift? {
        _prLift
    }

    // MARK: Init
    init(
        id: UUID = UUID(),
        name: String,
        defaultTempo: [Int] = [2, 1, 1]     // Default 2-1-1 tempo
    ) {
        self.id = id
        self.name = name
        self.defaultTempo = defaultTempo
    }
    
    // MARK: Helper methods
    func setMuscles(_ muscles: [Muscle]) {
        targetedMuscles = []
        for muscle in muscles {
            addMuscle(muscle)
        }
    }
    
    func addMuscle(_ muscle: Muscle) {
        let muscleString = muscle.rawValue
        
        // Check for existing muscle
        guard !targetedMuscles.contains(where: { $0.muscle == muscleString }) else {
            return
        }
        
        targetedMuscles.append(ExerciseMuscle(muscle: muscle))
    }
    
    func setEquipment(_ equipment: EquipmentType) {
        self.equipment = Equipment(type: equipment)
    }
    
    func addLift(
        timestamp: Date = Date(),
        weight: Double,
        reps: Int,
        tempo: [Int]? = nil,
        notes: String? = nil,
        rpe: Int? = nil
    ) {
        let newLift = Lift(
            timestamp: timestamp,
            weight: weight,
            reps: reps,
            tempo: tempo ?? defaultTempo, // Use exercise's default if not provided
            notes: notes,
            rpe: rpe,
            exercise: self  // Set the back-reference
        )
        
        // Check against current PR
        if isNewPR(newLift) {
            newLift.isPR = true
            _prLift?.isPR = false  // Demote old PR
            _prLift = newLift
        }
        
        lifts.append(newLift)
    }
    
    private func isNewPR(_ lift: Lift) -> Bool {
        guard let currentPR = _prLift else { return true }
        
        // PR logic: heavier OR same weight with more reps
        return lift.weight > currentPR.weight ||
              (lift.weight == currentPR.weight && lift.reps > currentPR.reps)
    }
}
