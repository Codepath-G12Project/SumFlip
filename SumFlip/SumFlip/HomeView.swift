//
//  HomeView.swift
//  SumFlip
//
//  Created by Carlvensky St Fleur on 11/22/26.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationStack {
            VStack(spacing: 24) {
                Spacer()

                Image(systemName: "square.grid.3x3.fill")
                    .font(.system(size: 70))
                    .foregroundStyle(.purple)

                Text("SumFlip")
                    .font(.largeTitle)
                    .bold()

                Text("Flip cards. Solve math. Earn points!")
                    .foregroundStyle(.secondary)

                NavigationLink("Play") {
                    GameSetupView()
                }
                .buttonStyle(.borderedProminent)
                .tint(.purple)

                Spacer()
            }
            .padding()
        }
    }
}
