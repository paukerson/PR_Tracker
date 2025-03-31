//
//  ExerciseRowStats.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI

/// Basic stats display for non-goal exercises
struct ExerciseRowStats: View {
    let prText: String
    let totalLifts: Int
    
    var body: some View {
        HStack {
            StatBadge(title: "PR", value: prText, color: Color("SecondaryMint"))
            Spacer()
            StatBadge(title: "Total", value: "\(totalLifts)", color: Color("TextSecondary"))
        }
    }
}
