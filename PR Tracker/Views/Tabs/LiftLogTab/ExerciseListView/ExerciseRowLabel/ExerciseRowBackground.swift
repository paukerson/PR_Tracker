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
            RoundedRectangle(cornerRadius: 12)
                .fill(
                    LinearGradient(
                        colors: [
                            hasGoal ? Color(.primaryCoral).opacity(0.12) : Color(.secondaryMint).opacity(0.12),
                            .clear],
                        startPoint: .topLeading,
                        endPoint: .bottomTrailing
                    )
                )
                .overlay(alignment: .center, content: {
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(
                            hasGoal ? Color(.primaryCoral).opacity(0.5) : Color(.secondaryMint).opacity(0.5),
                            lineWidth: 1
                        )
                })
        }
    }
}
