//
//  Muscle.swift
//  PR Tracker
//
//  Created by Jan Jędra on 30/03/2025.
//

import Foundation
import SwiftData

@Model
final class ExerciseMuscle {
    var muscle: String  // Stores Muscle.rawValue
    
    init(muscle: Muscle) {
        self.muscle = muscle.rawValue
    }
    
    // Helper for enum access
    var muscleType: Muscle? {
        Muscle(rawValue: muscle)
    }
}

// MARK: - Muscle Groups (Precision Level: (not so) Specific)
enum Muscle: String, CaseIterable, Codable {
    // Upper Body
    case chestUpper, chestLower, chestMiddle
    case frontDelt, sideDelt, rearDelt
    case lats, trapsUpper, trapsMid
    case rhomboids, teresMajor, teresMinor
    case bicepsShort, bicepsLong, brachialis
    case tricepsLong, tricepsLateral, tricepsMedial
    case forearmsFlexors, forearmsExtensors
    
    // Lower Body
    case quads, hamstrings, glutes
    case adductors, abductors
    case calvesGastrocn, calvesSoleus
    
    // Core
    case absUpper, absLower, obliques, serratus, erectorSpinae
    
    // Special
    case rotatorCuff, hipFlexors, tibialisAnterior
}
