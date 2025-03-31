//
//  PRBadge.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI

/// Badge displaying Personal Record information
struct PRBadge: View {
    let weight: Double
    let reps: Int
    
    var body: some View {
        HStack(spacing: 4) {
            Image(systemName: "crown.fill")
                .foregroundStyle(Color("PrimaryCoral"))
            Text("PR: \(weight.formatted())kg × \(reps)")
                .font(.system(.caption, design: .monospaced))
        }
    }
}
