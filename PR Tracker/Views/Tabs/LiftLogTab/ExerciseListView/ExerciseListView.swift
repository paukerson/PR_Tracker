//
//  ExerciseRow.swift
//  PR Tracker
//
//  Created by Jan Jędra on 31/03/2025.
//

import SwiftUI

struct ExerciseListView: View {
    let exercises: [Exercise]
    @Binding var selectedExerciseForLift: Exercise?
    
    // Constants for styling
    private let rowInsets = EdgeInsets(top: 4, leading: 10, bottom: 4, trailing: 8)
    private let rowSpacing: CGFloat = 5
    
    var body: some View {
        listContent
            .listStyle(.plain)
            .listRowSpacing(rowSpacing)
            .scrollIndicators(.never)
            .navigationTitle("Exercises")
    }
    
    // MARK: - Subviews
    
    private var listContent: some View {
        List(exercises) { exercise in
            NavigationLink(value: exercise) {
                ExerciseRowLabel(exercise: exercise)
            }
            .listRowSeparator(.hidden)
            .listRowInsets(rowInsets)
            .swipeActions(edge: .trailing) {
                addLiftButton(for: exercise)
                editExerciseButton(for: exercise)
            }
            .tint(.black)
        }
    }
    
    // MARK: - Swipe Actions
    
    private func addLiftButton(for exercise: Exercise) -> some View {
        Button {
            selectedExerciseForLift = exercise
        } label: {
            Label("Log Lift", systemImage: "plus")
        }
    }
    
    private func editExerciseButton(for exercise: Exercise) -> some View {
        Button {
            // TODO: Edit action
        } label: {
            Label("Edit", systemImage: "gearshape")
        }
    }
}

#Preview {
    let mock = MockData(modelContext: MockData.previewContainer.mainContext)
    mock.generateExercises()
    
    return MainTabView()
        .modelContainer(MockData.previewContainer)
}
