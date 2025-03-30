//
//  ContentView.swift
//  PR Tracker
//
//  Created by Jan Jędra on 29/03/2025.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    var body: some View {
        TabView {
            // 1. Lift Log Tab
            LiftLogTab()
            .tabItem {
                Label("Workouts", systemImage: "dumbbell")
            }
            
            // 2. PRs Tab
            PRsTab()
            .tabItem {
                Label("PRs", systemImage: "trophy")
            }
            
            // 3. Stats Tab
            StatsTab()
            .tabItem {
                Label("Stats", systemImage: "chart.line.uptrend.xyaxis")
            }
            
            // 4. More Tab (optional)
            Text("To be added").font(.largeTitle)
            .tabItem {
                Label("More", systemImage: "ellipsis")
            }
        }
        .tint(.teal) // Your app's accent color
    }
}

#Preview {
    MainTabView()
}
