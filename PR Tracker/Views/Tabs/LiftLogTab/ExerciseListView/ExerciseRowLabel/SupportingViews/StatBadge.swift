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
//    let color: Color
    
    var body: some View {
        HStack(alignment: .bottom) {
            Text(title)
                .font(.caption)
                .foregroundStyle(Color("TextSecondary"))
            Text(value)
                .font(.system(.subheadline, design: .rounded))
                .foregroundStyle(Color("TextPrimary"))
        }
    }
}
