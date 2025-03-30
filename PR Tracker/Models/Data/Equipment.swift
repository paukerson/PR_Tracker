//
//  Equipment.swift
//  PR Tracker
//
//  Created by Jan Jędra on 29/03/2025.
//

import Foundation
import SwiftData

@Model
final class Equipment {
    @Attribute(.unique) var id: UUID
    var name: String  // Matches EquipmentType rawValue
    var exercises: [Exercise] = []
    
    init(
        id: UUID = UUID(),
        type: EquipmentType
    ) {
        self.id = id
        self.name = type.rawValue
    }
}

enum EquipmentType: String, CaseIterable, Codable {
    case barbell, dumbbell, machine, cable, kettlebell
    case bodyweight, bands, other
}
