//
//  PR_TrackerApp.swift
//  PR Tracker
//
//  Created by Jan Jędra on 29/03/2025.
//

import SwiftUI
import SwiftData

@main
struct PR_TrackerApp: App {
    // 1. Model Container Setup
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Lift.self,          // Your custom Lift model
            Exercise.self       // Your custom Exercise model
        ])
        
        let modelConfiguration = ModelConfiguration(
            schema: schema
        )

        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            // 2. Better Error Handling
            let message = "Failed to initialize model container: \(error.localizedDescription)"
            #if DEBUG
            fatalError(message)  // Crash in development for visibility
            #else
            print(message)      // Log in production but continue
            return try! ModelContainer(for: schema, configurations: .init(isStoredInMemoryOnly: true))
            #endif
        }
    }()

    var body: some Scene {
        WindowGroup {
            // 3. Root View with Dependency Injection
            MainTabView()
//                .environment(\.modelContext, sharedModelContainer.mainContext)
//                .environmentObject(WorkoutData())  // For non-SwiftData state
        }
        .modelContainer(sharedModelContainer)
    }
}
