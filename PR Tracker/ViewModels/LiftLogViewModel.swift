////
////  LiftLogViewModel.swift
////  PR Tracker
////
////  Created by Jan Jędra on 29/03/2025.
////
//
//import Foundation
//import SwiftData
//
//@MainActor
//class LiftLogViewModel: ObservableObject {
//    private let modelContext: ModelContext
//    
//    // Published properties for view updates
//    @Published var exercises: [Exercise] = []
//    @Published var sortCriteria: SortCriteria = .totalLiftsDescending
//    
//    enum SortCriteria {
//        case totalLiftsDescending
//        case nameAscending
//        // Add more cases as needed
//    }
//    
//    init(modelContext: ModelContext) {
//        self.modelContext = modelContext
//        fetchExercises()
//    }
//    
//    func fetchExercises() {
//        let descriptor = FetchDescriptor<Exercise>()
//        exercises = (try? modelContext.fetch(descriptor)) ?? []
//    }
//    
//    var sortedExercises: [Exercise] {
//        switch sortCriteria {
//        case .totalLiftsDescending:
//            return exercises.sorted {
//                $0.totalLifts != $1.totalLifts ?
//                $0.totalLifts > $1.totalLifts :
//                $0.hasGoal
//            }
//        case .nameAscending:
//            return exercises.sorted { $0.name < $1.name }
//        }
//    }
//    
//    // Add other business logic methods here
//    func addExercise(_ exercise: Exercise) {
//        modelContext.insert(exercise)
//        fetchExercises()
//    }
//    
//    func deleteExercise(_ exercise: Exercise) {
//        modelContext.delete(exercise)
//        fetchExercises()
//    }
//}
