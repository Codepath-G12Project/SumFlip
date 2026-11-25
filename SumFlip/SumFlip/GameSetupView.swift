//
//  GameSetupView.swift
//  SumFlip
//
//  Created by Carlvensky St Fleur on 11/22/26.
//

import SwiftUI

struct GameSetupView: View {
    @State private var operation = "Addition"
    @State private var difficulty = "Easy"

    private let operations = [
        "Addition",
        "Subtraction",
        "Multiplication",
        "Division"
    ]

    private let difficulties = [
        "Easy",
        "Medium",
        "Hard"
    ]

    var body: some View {
        VStack(spacing: 25) {
            Text("Game Setup")
                .font(.largeTitle)
                .bold()

            VStack(alignment: .leading, spacing: 12) {
                Text("Math Operation")
                    .font(.headline)

                Picker("Operation", selection: $operation) {
                    ForEach(operations, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.menu)
                .tint(.purple)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            VStack(alignment: .leading, spacing: 12) {
                Text("Difficulty")
                    .font(.headline)

                Picker("Difficulty", selection: $difficulty) {
                    ForEach(difficulties, id: \.self) { item in
                        Text(item)
                    }
                }
                .pickerStyle(.segmented)
            }

            Text("Find matching cards and earn as many points as possible in 60 seconds.")
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)

            NavigationLink {
                GameView(
                    operation: operation,
                    difficulty: difficulty
                )
            } label: {
                Text("Start Game")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)

            Spacer()
        }
        .padding()
        .navigationTitle("Setup")
    }
}
