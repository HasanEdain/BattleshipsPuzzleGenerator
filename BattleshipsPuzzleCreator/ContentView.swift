//
//  ContentView.swift
//  BattleshipsPuzzleCreator
//
//  Created by Hasan Edain on 9/29/24.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var puzzle: Puzzle

    var body: some View {
        GenerateView()
    }

    func printEmpty() {
        let emptyPuzzle = Puzzle.emptyPuzzle(width: 10, height: 10)
        print("\(emptyPuzzle)")
    }
}

#Preview {
    let emptyPuzzle: Puzzle = Puzzle.emptyPuzzle(width: 10, height: 10)

    ContentView()
        .environmentObject(emptyPuzzle)
}
