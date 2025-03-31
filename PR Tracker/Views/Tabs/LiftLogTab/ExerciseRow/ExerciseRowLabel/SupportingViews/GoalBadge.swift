//
//  GoalBadge.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI

/// Badge displaying Goal information
struct GoalBadge: View {
    let weight: Double
    let reps: Int
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "flag.fill")
                .foregroundStyle(Color("SecondaryMint"))
            Text("Goal: \(weight.formatted())kg × \(reps)")
                .font(.system(.caption, design: .monospaced))
        }
    }
}
