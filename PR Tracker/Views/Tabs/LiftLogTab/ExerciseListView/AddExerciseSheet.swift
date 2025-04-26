//
//  AddExerciseSheet.swift
//  PR Tracker
//
//  Created by Jan Jędra on 26/04/2025.
//

import Foundation
import SwiftUI

struct AddExerciseSheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = ""
    
    // Form State
    @State private var name = ""
    @State private var tempoEccentric = ""
    @State private var tempoPause = ""
    @State private var tempoConcentric = ""
    @State private var selectedMuscles = Set<Muscle>()
    @State private var goalWeight: Double?
    @State private var goalReps: Int?
    @State private var selectedEquipment: EquipmentType?
    
    private var isValid: Bool {
        !name.isEmpty
    }
    
    private var suggestedMuscles: [Muscle] {
        if searchText.isEmpty {
            return []
        } else {
            return Muscle.allCases.filter { muscle in
                !selectedMuscles.contains(muscle) && // Exclude already selected
                muscle.rawValue.localizedCaseInsensitiveContains(searchText)
            }
            .sorted { $0.rawValue < $1.rawValue } // Sort alphabetically
        }
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("Basic Info")) {
                    TextField("Exercise Name", text: $name)
                    
                    HStack {
                        TextField("Eccentric", text: $tempoEccentric)
                            .keyboardType(.numberPad)
                        TextField("Pause", text: $tempoPause)
                            .keyboardType(.numberPad)
                        TextField("Concentric", text: $tempoConcentric)
                            .keyboardType(.numberPad)
                    }
                }
                

                Section(header: Text("Target Muscles")) {
                    // Search bar for adding muscles
                    HStack {
                        TextField("Add muscles...", text: $searchText)
                            .textFieldStyle(.roundedBorder)
                            .autocorrectionDisabled()
                        
                        if !searchText.isEmpty {
                            Button {
                                searchText = ""
                            } label: {
                                Image(systemName: "xmark.circle.fill")
                                    .foregroundColor(.gray)
                            }
                            .buttonStyle(.plain)
                        }
                    }
                    .padding(.bottom, 8)
                    
                    // Suggestions while typing
                    if !suggestedMuscles.isEmpty {
                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(suggestedMuscles, id: \.self) { muscle in
                                    Button {
                                        withAnimation {
                                            selectedMuscles.insert(muscle)
                                            searchText = ""
                                        }
                                    } label: {
                                        Text(muscle.rawValue.capitalized)
                                            .padding(.horizontal, 12)
                                            .padding(.vertical, 6)
                                            .background(Color.blue)
                                            .foregroundColor(.white)
                                            .clipShape(Capsule())
                                    }
                                    .buttonStyle(.plain)
                                }
                            }
                            .padding(.bottom, 8)
                        }
                    }
                    
                    // Selected muscles list (converted to array for ForEach)
                    if !selectedMuscles.isEmpty {
                        VStack(alignment: .leading, spacing: 8) {
                            ForEach(Array(selectedMuscles).sorted { $0.rawValue < $1.rawValue }, id: \.self) { muscle in
                                HStack {
                                    Text(muscle.rawValue.capitalized)
                                        .padding(.vertical, 6)
                                    
                                    Spacer()
                                    
                                    Button {
//                                        withAnimation {
                                            selectedMuscles.remove(muscle)
//                                        }
                                    } label: {
                                        Image(systemName: "minus.circle.fill")
                                            .foregroundColor(.red)
                                    }
                                    .buttonStyle(.plain)
                                }
                                .padding(.horizontal, 8)
                                .background(Color(.systemGray6))
                                .clipShape(RoundedRectangle(cornerRadius: 8))
                            }
                        }
                    } else {
                        Text("No muscles selected")
                            .foregroundColor(.secondary)
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                }
                
                Section(header: Text("Goals")) {
                    HStack {
                        Text("Target Weight")
                        Spacer()
                        TextField("kg", value: $goalWeight, format: .number)
                            .keyboardType(.decimalPad)
                            .multilineTextAlignment(.trailing)
                    }
                    
                    HStack {
                        Text("Target Reps")
                        Spacer()
                        TextField("reps", value: $goalReps, format: .number)
                            .keyboardType(.numberPad)
                            .multilineTextAlignment(.trailing)
                    }
                }
                
                Section(header: Text("Equipment")) {
                    Picker("Equipment", selection: $selectedEquipment) {
                        Text("None").tag(nil as EquipmentType?)
                        ForEach(EquipmentType.allCases, id: \.self) { equipment in
                            Text(equipment.rawValue.capitalized).tag(equipment as EquipmentType?)
                        }
                    }
                    .pickerStyle(.menu)
                }
            }
            .navigationTitle("New Exercise")
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add") { saveExercise() }
                        .disabled(!isValid)
                }
            }
        }
    }
    
    private func saveExercise() {
        let exercise = Exercise(
            name: name,
            defaultTempo: [
                Int(tempoEccentric) ?? 0,
                Int(tempoPause) ?? 0,
                Int(tempoConcentric) ?? 0
            ])
        
        exercise.setMuscles(Array(selectedMuscles))
        if let weight = goalWeight, let reps = goalReps {
            exercise.setGoal(weight: weight, reps: reps)
        }
        if let equipment = selectedEquipment {
            exercise.setEquipment(equipment)
        }
        
        context.insert(exercise)
        dismiss()
    }
}

#Preview {
    let container = MockData.previewContainer
    return AddExerciseSheet()
        .modelContainer(container)
}
