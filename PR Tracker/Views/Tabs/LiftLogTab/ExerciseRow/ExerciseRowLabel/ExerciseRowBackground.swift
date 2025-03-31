//
//  ExerciseRowBackground.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI

/// Handles the background styling for exercise rows
/// Includes conditional gradient overlay for goal exercises
struct ExerciseRowBackground: View {
    let hasGoal: Bool
    
    var body: some View {
        ZStack {
            // Base card style
            RoundedRectangle(cornerRadius: 12)
                .fill(Color("CardBackground"))
                .shadow(color: .black.opacity(0.08), radius: 5, x: 0, y: 2)
            
            // Goal overlay
            if hasGoal {
                RoundedRectangle(cornerRadius: 12)
                    .fill(
                        LinearGradient(
                            colors: [Color("PrimaryCoral").opacity(0.15), .clear],
                            startPoint: .topLeading,
                            endPoint: .bottomTrailing
                        )
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 12)
                            .stroke(Color("PrimaryCoral").opacity(0.3), lineWidth: 1)
                    )
            }
        }
    }
}
