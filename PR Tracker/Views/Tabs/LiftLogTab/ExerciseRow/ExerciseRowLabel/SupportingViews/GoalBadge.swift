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
        HStack(alignment: .bottom, spacing: 2) {
            Image(systemName: "flag.fill")
                .foregroundStyle(Color("SecondaryMint"))
                .font(.subheadline)
            Text("Goal ")
                .font(.system(.caption, design: .monospaced))
            Text("\(weight.formatted())kg × \(reps)")
                .font(.system(.footnote, design: .monospaced))
        }
    }
}
