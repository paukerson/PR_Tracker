//
//  AddLiftSheet.swift
//  PR Tracker
//
//  Created by Jan Jędra on 21/04/2025.
//

import SwiftUI

struct AddLiftSheet: View {
    @Environment(\.modelContext) private var context
    @Environment(\.dismiss) private var dismiss
    @Bindable var exercise: Exercise // Required exercise parameter
    
    @State private var weight: String = ""
    @State private var reps: String = ""
    @State private var tempo = ["", "", ""]
    @State private var notes: String = ""
    @State private var rpe: Double?
    
    private var isValid: Bool {
        !weight.isEmpty && !reps.isEmpty
    }
    
    var body: some View {
        NavigationStack {
            Form {
                // Exercise Header
                Section {
                    HStack {
                        Image(systemName: "dumbbell")
                            .foregroundColor(.blue)
                        Text(exercise.name)
                            .font(.headline)
                    }
                }
                
                // Weight & Reps
                Section {
                    WeightRepsInput(weight: $weight, reps: $reps)
                    
                    TempoInputSection(tempo: $tempo)
                } header: {
                    Text("Performance Metrics")
                }

                // RPE Slider
                Section {
                    RPERatingView(rpe: $rpe)
                } header: {
                    Text("Rate of Perceived Exertion")
                } footer: {
                    Text("Scale: 1 (Easy) - 10 (Max Effort)")
                }

                // Notes
                Section {
                    TextField("Session Notes", text: $notes, axis: .vertical)
                        .lineLimit(2...4)
                }
            }
            .navigationTitle("Log New Lift")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add", action: saveLift)
                        .disabled(!isValid)
                        .animation(.default, value: isValid)
                }
            }
        }
        .presentationDetents([.medium])
        .presentationCornerRadius(16)
    }
    
    private func saveLift() {
        guard let weight = Double(weight),
              let reps = Int(reps) else { return }
        
        exercise.addLift(
            weight: weight,
            reps: reps,
            tempo: tempo.compactMap { Int($0) },
            notes: notes.isEmpty ? nil : notes,
            rpe: rpe.map { Int($0) }
        )
        dismiss()
    }
}

// MARK: - Subviews

private struct WeightRepsInput: View {
    @Binding var weight: String
    @Binding var reps: String
    
    var body: some View {
        HStack(spacing: 20) {
            VStack(alignment: .leading) {
                Text("Weight (kg)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                TextField("0.0", text: $weight)
                    .keyboardType(.decimalPad)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
            
            Divider()
                .frame(height: 40)
            
            VStack(alignment: .leading) {
                Text("Reps")
                    .font(.caption)
                    .foregroundStyle(.secondary)
                
                TextField("0", text: $reps)
                    .keyboardType(.numberPad)
                    .padding(10)
                    .background(Color(.systemGray6))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
            }
        }
    }
}

private struct TempoInputSection: View {
    @Binding var tempo: [String]
    let labels = ["Eccentric", "Pause", "Concentric"]
    
    var body: some View {
        HStack {
            ForEach(0..<3, id: \.self) { index in
                VStack {
                    Text(labels[index])
                        .font(.caption)
                        .foregroundStyle(.secondary)
                    
                    TextField("0", text: $tempo[index])
                        .keyboardType(.numberPad)
                        .multilineTextAlignment(.center)
                        .frame(width: 60)
                        .padding(8)
                        .background(Color(.systemGray6))
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
        }
        .frame(maxWidth: .infinity)
    }
}

private struct RPERatingView: View {
    @Binding var rpe: Double?
    
    var body: some View {
        VStack(spacing: 15) {
            HStack {
                Text(rpe?.formatted() ?? "–")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundStyle(rpe != nil ? .blue : .secondary)
                
                Text("/ 10")
                    .foregroundStyle(.secondary)
            }
            
            Slider(
                value: Binding(
                    get: { rpe ?? 5 }, // Default to middle if nil
                    set: { rpe = $0 }
                ),
                in: 1...10,
                step: 1
            )
            .tint(rpe != nil ? .blue : .gray)
            .overlay(
                HStack {
                    ForEach(1..<11) { num in
                        VerticalTick()
                            .frame(maxWidth: .infinity)
                    }
                }
            )
            
            HStack {
                Button("Clear") {
                    rpe = nil
                }
                .font(.caption)
                .foregroundStyle(.secondary)
                
                Spacer()
                
                Text("RPE Scale")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding(.vertical, 8)
    }
}

private struct VerticalTick: View {
    var body: some View {
        Rectangle()
            .frame(width: 1, height: 10)
            .foregroundStyle(.gray.opacity(0.5))
    }
}

// MARK: - Preview

#Preview {
    let exercise = Exercise(name: "Bench Press", defaultTempo: [1, 0, 1])
    
    return AddLiftSheet(exercise: exercise)
}
