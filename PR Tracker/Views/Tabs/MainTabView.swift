//
//  ContentView.swift
//  PR Tracker
//
//  Created by Jan Jędra on 29/03/2025.
//

import SwiftUI
import SwiftData

struct MainTabView: View {
    
    @State var selectedTab: Int = 0
    
    var body: some View {
        TabView(selection: $selectedTab) {
            // 1. Lift Log Tab
            LiftLogTab()
                .tabItem {
                    Label("Exercises", systemImage: "dumbbell")
                }
                .tag(0)
            
            // 2. PRs Tab
            PRsTab()
                .tabItem {
                    Label("PRs", systemImage: "trophy")
                }
                .tag(1)
            
            // 3. Stats Tab
            StatsTab()
                .tabItem {
                    Label("Stats", systemImage: "chart.line.uptrend.xyaxis")
                }
                .tag(2)
            
            // 4. More Tab (optional)
            Text("To be added").font(.largeTitle)
                .tabItem {
                    Label("More", systemImage: "ellipsis")
                }
                .tag(3)
        }
        .tint(Color(.secondaryMint)) // Accent colour
    }
}

#Preview {
    MainTabView()
}
