//
//  Lift.swift
//  PR Tracker
//
//  Created by Jan Jędra on 29/03/2025.
//

import Foundation
import SwiftData

// MARK: - Lift Record
@Model
final class Lift: Identifiable {
    var id: UUID
    var timestamp: Date
    var weight: Double             // in kg
    var reps: Int
    var tempo: [Int]               // [Eccentric, Pause, Concentric], inherited from exercise if not set
    var isPR: Bool
    var notes: String?
    var rpe: Int?      // RPE (1-10 scale)
    var exercise: Exercise
    
    init(
        id: UUID = UUID(),
        timestamp: Date = Date(),
        weight: Double,
        reps: Int,
        tempo: [Int]?,
        isPR: Bool = false,
        notes: String? = nil,
        rpe: Int? = nil,
        exercise: Exercise
    ) {
        self.id = id
        self.timestamp = timestamp
        self.weight = weight
        self.reps = reps
        self.tempo = tempo ?? exercise.defaultTempo
        self.isPR = isPR
        self.notes = notes
        self.rpe = rpe
        self.exercise = exercise
    }
    
    
    // Computed property for tempo display
    var formattedTempo: String {
        tempo.map(String.init).joined(separator: "-")
    }
}
