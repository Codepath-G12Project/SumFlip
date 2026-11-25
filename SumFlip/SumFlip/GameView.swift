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

    @State private var numbers: [Int] = []
    @State private var target = 0
    @State private var selectedCards: [Int] = []
    @State private var score = 0
    @State private var matches = 0
    @State private var attempts = 0
    @State private var timeRemaining = 60
    @State private var feedback = "Select two cards"
    @State private var isChecking = false
    @State private var gameOver = false
    @State private var gameID = UUID()

    private let columns = Array(
        repeating: GridItem(.flexible()),
        count: 3
    )

    private var maxNumber: Int {
        switch difficulty {
        case "Medium": return 15
        case "Hard": return 25
        default: return 10
        }
    }

    private var symbol: String {
        switch operation {
        case "Subtraction": return "−"
        case "Multiplication": return "×"
        case "Division": return "÷"
        default: return "+"
        }
    }

    var body: some View {
        VStack(spacing: 16) {
            HStack {
                Label("\(score) pts", systemImage: "star.fill")
                    .foregroundStyle(.orange)

                Spacer()

                Label(
                    "\(timeRemaining)s",
                    systemImage: "clock.fill"
                )
                .foregroundStyle(
                    timeRemaining <= 10
                    ? Color.red
                    : Color.primary
                )
            }
            .font(.headline)

            ProgressView(
                value: Double(timeRemaining),
                total: 60
            )
            .tint(timeRemaining <= 10 ? .red : .purple)

            Text("\(operation) • \(difficulty)")
                .foregroundStyle(.secondary)

            Text("Find two numbers")
                .font(.headline)

            Text("? \(symbol) ? = \(target)")
                .font(.system(size: 36, weight: .bold))
                .foregroundStyle(.purple)

            Text(feedback)
                .font(.headline)
                .foregroundStyle(
                    feedback == "Correct!"
                    ? Color.green
                    : feedback == "Incorrect. Try again!"
                    ? Color.red
                    : Color.primary
                )
                .frame(height: 30)

            LazyVGrid(columns: columns, spacing: 12) {
                ForEach(numbers.indices, id: \.self) { index in
                    Button {
                        selectCard(index)
                    } label: {
                        RoundedRectangle(cornerRadius: 15)
                            .fill(
                                selectedCards.contains(index)
                                ? Color.yellow
                                : Color.purple
                            )
                            .frame(height: 85)
                            .overlay {
                                Text(
                                    selectedCards.contains(index)
                                    ? "\(numbers[index])"
                                    : "?"
                                )
                                .font(.largeTitle)
                                .bold()
                                .foregroundStyle(
                                    selectedCards.contains(index)
                                    ? Color.black
                                    : Color.white
                                )
                            }
                    }
                    .buttonStyle(.plain)
                    .disabled(isChecking || gameOver)
                }
            }

            HStack {
                Text("Matches: \(matches)")
                Spacer()
                Text("Attempts: \(attempts)")
            }
            .font(.subheadline)

            Spacer()

            Button("End Game") {
                gameOver = true
            }
            .buttonStyle(.bordered)
            .tint(.red)
        }
        .padding()
        .navigationTitle("SumFlip")
        .navigationBarBackButtonHidden()
        .onAppear {
            if numbers.isEmpty {
                generateRound()
            }
        }
        .task(id: gameID) {
            await runTimer()
        }
        .fullScreenCover(isPresented: $gameOver) {
            ResultsView(
                score: score,
                matches: matches,
                attempts: attempts,
                onPlayAgain: {
                    resetGame()
                }
            )
            .interactiveDismissDisabled()
        }
    }

    private func generateRound() {
        let a: Int
        let b: Int

        switch operation {
        case "Subtraction":
            a = Int.random(in: 2...maxNumber)
            b = Int.random(in: 1..<a)
            target = a - b

        case "Multiplication":
            a = Int.random(in: 1...maxNumber)
            b = Int.random(in: 1...maxNumber)
            target = a * b

        case "Division":
            b = Int.random(in: 1...maxNumber)
            let quotient = Int.random(in: 1...maxNumber)
            a = b * quotient
            target = quotient

        default:
            a = Int.random(in: 1...maxNumber)
            b = Int.random(in: 1...maxNumber)
            target = a + b
        }

        var cards = [a, b]

        let upperLimit = operation == "Division"
            ? maxNumber * maxNumber
            : maxNumber

        while cards.count < 9 {
            cards.append(
                Int.random(in: 1...upperLimit)
            )
        }

        numbers = cards.shuffled()
        selectedCards.removeAll()
        feedback = "Select two cards"
    }

    private func selectCard(_ index: Int) {
        guard !isChecking,
              !gameOver,
              !selectedCards.contains(index),
              selectedCards.count < 2 else {
            return
        }

        withAnimation(.easeInOut(duration: 0.2)) {
            selectedCards.append(index)
        }

        if selectedCards.count == 2 {
            isChecking = true
            attempts += 1

            let first = numbers[selectedCards[0]]
            let second = numbers[selectedCards[1]]
            let correct = checkAnswer(first, second)
            let currentGame = gameID

            if correct {
                feedback = "Correct!"
                score += 10
                matches += 1
            } else {
                feedback = "Incorrect. Try again!"
            }

            Task { @MainActor in
                try? await Task.sleep(
                    for: .milliseconds(800)
                )

                guard currentGame == gameID,
                      !gameOver else {
                    return
                }

                withAnimation {
                    if correct {
                        generateRound()
                    } else {
                        selectedCards.removeAll()
                        feedback = "Select two cards"
                    }
                }

                isChecking = false
            }
        }
    }

    private func checkAnswer(_ a: Int, _ b: Int) -> Bool {
        switch operation {
        case "Subtraction":
            return abs(a - b) == target

        case "Multiplication":
            return a * b == target

        case "Division":
            let larger = max(a, b)
            let smaller = min(a, b)

            return smaller != 0 &&
                larger % smaller == 0 &&
                larger / smaller == target

        default:
            return a + b == target
        }
    }

    @MainActor
    private func runTimer() async {
        while timeRemaining > 0 && !gameOver {
            do {
                try await Task.sleep(for: .seconds(1))
            } catch {
                return
            }

            guard !Task.isCancelled,
                  !gameOver else {
                return
            }

            timeRemaining -= 1
        }

        if timeRemaining == 0 && !Task.isCancelled {
            gameOver = true
        }
    }

    private func resetGame() {
        score = 0
        matches = 0
        attempts = 0
        timeRemaining = 60
        isChecking = false

        generateRound()

        gameOver = false
        gameID = UUID()
    }
}
