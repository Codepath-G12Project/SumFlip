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
        VStack(spacing: 24) {
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
                .pickerStyle(.segmented)
            }

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

            NavigationLink("Start Game") {
                GameView(
                    operation: operation,
                    difficulty: difficulty
                )
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)

            Spacer()
        }
        .padding()
        .navigationTitle("Setup")
    }
}
