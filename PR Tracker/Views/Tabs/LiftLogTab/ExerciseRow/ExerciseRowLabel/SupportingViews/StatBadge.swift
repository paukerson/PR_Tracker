//
//  StatBadge.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI

/// Reusable badge for statistics display
struct StatBadge: View {
    let title: String
    let value: String
    let color: Color
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(title)
                .font(.caption2)
                .foregroundStyle(color.opacity(0.8))
            Text(value)
                .font(.system(.subheadline, design: .rounded))
        }
    }
}
