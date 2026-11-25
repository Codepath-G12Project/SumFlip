//
//  ResultsView.swift
//  SumFlip
//
//  Created by Carlvensky St Fleur on 11/22/26.
//


import SwiftUI

struct ResultsView: View {
    let score: Int
    let matches: Int
    let attempts: Int
    let onPlayAgain: () -> Void

    private var accuracy: Int {
        guard attempts > 0 else {
            return 0
        }

        return Int(
            Double(matches) / Double(attempts) * 100
        )
    }

    var body: some View {
        VStack(spacing: 25) {
            Spacer()

            Image(systemName: "trophy.fill")
                .font(.system(size: 80))
                .foregroundStyle(.yellow)

            Text("Game Over!")
                .font(.largeTitle)
                .bold()

            Text("Final Score")
                .font(.title2)

            Text("\(score)")
                .font(.system(size: 65, weight: .bold))
                .foregroundStyle(.purple)

            VStack(spacing: 15) {
                HStack {
                    Text("Correct Matches")
                    Spacer()
                    Text("\(matches)")
                        .bold()
                }

                Divider()

                HStack {
                    Text("Total Attempts")
                    Spacer()
                    Text("\(attempts)")
                        .bold()
                }

                Divider()

                HStack {
                    Text("Accuracy")
                    Spacer()
                    Text("\(accuracy)%")
                        .bold()
                }
            }
            .padding(20)
            .background(
                Color.gray.opacity(0.1)
            )
            .clipShape(
                RoundedRectangle(cornerRadius: 15)
            )

            Button {
                onPlayAgain()
            } label: {
                Text("Play Again")
                    .font(.headline)
                    .frame(maxWidth: .infinity)
                    .padding()
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)

            NavigationStack {
                NavigationLink {
                    HomeView()
                } label: {
                    Text("Home")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
                .buttonStyle(.bordered)
            }
            .frame(height: 60)

            Spacer()
        }
        .padding(25)
    }
}
