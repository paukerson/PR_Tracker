//
//  WorkoutData.swift
//  PR Tracker
//
//  Created by Jan Jędra on 29/03/2025.
//

import SwiftUI
import SwiftData

@MainActor  // Ensures UI updates happen on main thread
final class WorkoutData: ObservableObject {
    
    // MARK: - Temporary State
    @Published var selectedTab: AppTab = .liftLog
    
    // MARK: - Services
    let analyticsEngine = AnalyticsEngine()
}

// Supporting Types
enum AppTab {
    case liftLog, prs, stats, more
}

// TODO: cool idea, might implement later
//struct WorkoutSession {
//    var startTime: Date
//    var exercises: [Exercise]
//}
