//
//  ResultsView.swift
//  SumFlip
//
//  Created by Carlvensky St Fleur on 11/22/26.
//

import SwiftUI

struct ResultsView: View {
    let score: Int

    var body: some View {
        VStack(spacing: 24) {
            Spacer()

            Image(systemName: "trophy.fill")
                .font(.system(size: 70))
                .foregroundStyle(.yellow)

            Text("Game Over!")
                .font(.largeTitle)
                .bold()

            Text("Final Score")
                .font(.headline)

            Text("\(score)")
                .font(.system(size: 60, weight: .bold))
                .foregroundStyle(.purple)

            NavigationLink("Play Again") {
                GameSetupView()
            }
            .buttonStyle(.borderedProminent)
            .tint(.purple)

            Spacer()
        }
        .padding()
        .navigationTitle("Results")
    }
}
