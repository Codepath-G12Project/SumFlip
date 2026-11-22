//
//  GameView.swift
//  SumFlip
//
//  Created by Carlvensky St Fleur on 11/22/26.
//

import SwiftUI

struct GameView: View {
    let operation: String
    let difficulty: String

    @State private var flippedCards: Set<Int> = []

    private let numbers = [2, 7, 3, 9, 4, 6, 1, 8, 5]

    private var symbol: String {
        switch operation {
        case "Subtraction": return "−"
        case "Multiplication": return "×"
        case "Division": return "÷"
        default: return "+"
        }
    }

    var body: some View {
        VStack(spacing: 20) {
            HStack {
                Text("Score: 0")
                Spacer()
                Text("Time: 60")
            }
            .font(.headline)

            Text("Find two numbers")
                .font(.headline)

            Text("Target: 5")
                .font(.largeTitle)
                .bold()

            Text("\(operation) (\(symbol)) • \(difficulty)")
                .foregroundStyle(.secondary)

            LazyVGrid(
                columns: Array(
                    repeating: GridItem(.flexible()),
                    count: 3
                ),
                spacing: 12
            ) {
                ForEach(numbers.indices, id: \.self) { index in
                    Button {
                        if flippedCards.contains(index) {
                            flippedCards.remove(index)
                        } else {
                            flippedCards.insert(index)
                        }
                    } label: {
                        RoundedRectangle(cornerRadius: 14)
                            .fill(
                                flippedCards.contains(index)
                                ? Color.yellow
                                : Color.purple
                            )
                            .frame(height: 85)
                            .overlay {
                                Text(
                                    flippedCards.contains(index)
                                    ? "\(numbers[index])"
                                    : "?"
                                )
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(
                                    flippedCards.contains(index)
                                    ? .black
                                    : .white
                                )
                            }
                    }
                    .buttonStyle(.plain)
                }
            }

            Spacer()

            NavigationLink("View Results") {
                ResultsView(score: 0)
            }
            .buttonStyle(.borderedProminent)
        }
        .padding()
        .navigationTitle("SumFlip")
    }
}
