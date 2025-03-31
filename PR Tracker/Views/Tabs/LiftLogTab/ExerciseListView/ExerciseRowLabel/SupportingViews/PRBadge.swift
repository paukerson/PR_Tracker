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
        HStack(alignment: .bottom, spacing: 2) {
            Image(systemName: "crown.fill")
                .foregroundStyle(Color("PrimaryCoral"))
                .font(.subheadline)
            Text("PR ")
                .foregroundStyle(Color("TextSecondary"))
                .font(.system(.caption, design: .monospaced))
            Text("\(weight.formatted())kg × \(reps)")
                .foregroundStyle(Color("TextPrimary"))
                .font(.system(.footnote, design: .monospaced))
        }
    }
}
